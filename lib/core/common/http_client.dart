import 'dart:io' as io;
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'custom_interceptor.dart';
import 'package:pure_live/core/common/core_error.dart';


class MyHttpClient {
  static MyHttpClient? _httpUtil;
  static DateTime _lastRecreateTime = DateTime.now();
  static const _recreateInterval = Duration(minutes: 5);
  static int _requestCount = 0;
  static int _errorCount = 0;

  static MyHttpClient get instance {
    // 每 5 分钟强制重建一次 HttpClient，避免连接池污染
    if (DateTime.now().difference(_lastRecreateTime) > _recreateInterval) {
      developer.log(
        '🔄 自动重建 HttpClient (已运行 ${_recreateInterval.inMinutes} 分钟，请求数: $_requestCount，错误数: $_errorCount)',
        name: 'HttpClient',
      );
      _httpUtil = null;
      _lastRecreateTime = DateTime.now();
      _requestCount = 0;
      _errorCount = 0;
    }
    _httpUtil ??= MyHttpClient();
    return _httpUtil!;
  }

  late Dio dio;
  MyHttpClient() {
    developer.log('✅ 创建新的 HttpClient 实例', name: 'HttpClient');

    // 配置 Dio 基础选项，增强连接稳定性
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        // 持久连接设置：保持连接复用以提高性能
        persistentConnection: true,
      ),
    );

    // 配置底层 HTTP 客户端连接池参数
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = io.HttpClient();
      // 设置空闲连接超时为 60 秒（默认 15 秒太短）
      client.idleTimeout = const Duration(seconds: 60);
      // 设置最大连接数
      client.maxConnectionsPerHost = 10;
      return client;
    };

    // 添加自定义拦截器
    dio.interceptors.add(CustomInterceptor());

    // 添加详细的日志拦截器（用于排查问题）
    dio.interceptors.add(_createDebugInterceptor());

    // 添加错误处理和重试拦截器
    dio.interceptors.add(_createErrorInterceptor());
  }

  /// 创建调试日志拦截器
  Interceptor _createDebugInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        _requestCount++;
        final uri = options.uri;
        developer.log(
          '📤 请求 #$_requestCount: ${options.method} ${uri.host}${uri.path}',
          name: 'HTTP',
        );
        return handler.next(options);
      },
      onResponse: (response, handler) {
        final duration = response.extra['duration'] ?? 0;
        developer.log(
          '✅ 响应: ${response.statusCode} (耗时: ${duration}ms)',
          name: 'HTTP',
        );
        return handler.next(response);
      },
      onError: (error, handler) {
        _errorCount++;
        _logDetailedError(error);
        return handler.next(error);
      },
    );
  }

  /// 创建错误处理拦截器
  Interceptor _createErrorInterceptor() {
    return InterceptorsWrapper(
      onError: (DioException error, handler) {
        // 检测到连接错误，记录并考虑重建 HttpClient
        if (error.type == DioExceptionType.connectionError ||
            error.type == DioExceptionType.connectionTimeout) {
          developer.log(
            '⚠️ 连接错误累计: $_errorCount 次（阈值: 5次触发重建）',
            name: 'HttpClient',
          );

          // 如果连续错误超过 5 次，主动重建 HttpClient
          if (_errorCount >= 5) {
            developer.log(
              '🔥 检测到连续错误，立即重建 HttpClient',
              name: 'HttpClient',
            );
            _httpUtil = null;
            _lastRecreateTime = DateTime.now();
            _errorCount = 0;
          }
        }
        return handler.next(error);
      },
    );
  }

  /// 记录详细的错误信息
  void _logDetailedError(DioException error) {
    final uri = error.requestOptions.uri;
    final method = error.requestOptions.method;

    String errorDetail = '';
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorDetail = '❌ 连接超时 (${error.requestOptions.connectTimeout?.inSeconds}秒)';
        break;
      case DioExceptionType.sendTimeout:
        errorDetail = '❌ 发送超时 (${error.requestOptions.sendTimeout?.inSeconds}秒)';
        break;
      case DioExceptionType.receiveTimeout:
        errorDetail = '❌ 接收超时 (${error.requestOptions.receiveTimeout?.inSeconds}秒)';
        break;
      case DioExceptionType.badResponse:
        errorDetail = '❌ 服务器错误: ${error.response?.statusCode} ${error.response?.statusMessage}';
        break;
      case DioExceptionType.cancel:
        errorDetail = '⚠️ 请求已取消';
        break;
      case DioExceptionType.connectionError:
        errorDetail = '❌ 连接错误: ${error.error}';
        // 检测是否是 DNS 解析失败
        if (error.error.toString().contains('Failed host lookup')) {
          errorDetail += ' (DNS 解析失败)';
        }
        // 检测是否是连接被拒绝
        if (error.error.toString().contains('Connection refused')) {
          errorDetail += ' (连接被拒绝)';
        }
        break;
      case DioExceptionType.unknown:
        errorDetail = '❌ 未知错误: ${error.error}';
        break;
      default:
        errorDetail = '❌ 其他错误: ${error.type}';
    }

    developer.log(
      '$errorDetail\n'
      '🔗 URL: $method ${uri.host}${uri.path}\n'
      '🕐 时间: ${DateTime.now().toIso8601String()}',
      name: 'HTTP_ERROR',
      error: error.error,
      stackTrace: error.stackTrace,
    );
  }

  /// Get请求，返回String
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  Future<String> getText(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    CancelToken? cancel,
  }) async {
    try {
      queryParameters ??= {};
      header ??= {};
      var result = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.plain,
          headers: header,
        ),
        cancelToken: cancel,
      );
      return result.data;
    } catch (e) {
      // 详细记录错误信息
      developer.log(
        '❌ getText 失败\n'
        '🔗 URL: $url\n'
        '📋 Query: $queryParameters\n'
        '🎫 Headers: $header\n'
        '⚠️ 错误: ${e.toString()}',
        name: 'HTTP_ERROR',
        error: e,
      );

      if (e is DioException && e.type == DioExceptionType.badResponse) {
        throw CoreError(e.message ?? "", statusCode: e.response?.statusCode ?? 0);
      } else {
        throw CoreError("发送GET请求失败: ${e.toString()}");
      }
    }
  }

  /// Get请求，返回Map
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  Future<dynamic> getJson(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    CancelToken? cancel,
  }) async {
    try {
      queryParameters ??= {};
      header ??= {};
      var result = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.json,
          headers: header,
        ),
        cancelToken: cancel,
      );
      return result.data;
    } catch (e) {
      // 详细记录错误信息
      developer.log(
        '❌ getJson 失败\n'
        '🔗 URL: $url\n'
        '📋 Query: $queryParameters\n'
        '🎫 Headers: $header\n'
        '⚠️ 错误: ${e.toString()}',
        name: 'HTTP_ERROR',
        error: e,
      );

      if (e is DioException && e.type == DioExceptionType.badResponse) {
        throw CoreError(e.message ?? "", statusCode: e.response?.statusCode ?? 0);
      } else {
        throw CoreError("发送GET请求失败: ${e.toString()}");
      }
    }
  }

  /// Post请求，返回Map
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [data] 内容
  /// * [cancel] 任务取消Token
  Future<dynamic> postJson(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? header,
    bool formUrlEncoded = false,
    CancelToken? cancel,
  }) async {
    try {
      queryParameters ??= {};
      header ??= {};
      data ??= {};
      var result = await dio.post(
        url,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          responseType: ResponseType.json,
          headers: header,
          contentType: formUrlEncoded ? Headers.formUrlEncodedContentType : null,
        ),
        cancelToken: cancel,
      );
      return result.data;
    } catch (e) {
      // 详细记录错误信息
      developer.log(
        '❌ postJson 失败\n'
        '🔗 URL: $url\n'
        '📋 Query: $queryParameters\n'
        '🎫 Headers: $header\n'
        '📦 Data: $data\n'
        '⚠️ 错误: ${e.toString()}',
        name: 'HTTP_ERROR',
        error: e,
      );

      if (e is DioException && e.type == DioExceptionType.badResponse) {
        throw CoreError(e.message ?? "", statusCode: e.response?.statusCode ?? 0);
      } else {
        throw CoreError("发送POST请求失败: ${e.toString()}");
      }
    }
  }

  /// Head请求，返回Response
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  Future<Response> head(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    CancelToken? cancel,
  }) async {
    try {
      queryParameters ??= {};
      header ??= {};
      var result = await dio.head(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: header,
          receiveDataWhenStatusError: true,
        ),
        cancelToken: cancel,
      );
      return result;
    } catch (e) {
      // 详细记录错误信息
      developer.log(
        '❌ head 失败\n'
        '🔗 URL: $url\n'
        '📋 Query: $queryParameters\n'
        '🎫 Headers: $header\n'
        '⚠️ 错误: ${e.toString()}',
        name: 'HTTP_ERROR',
        error: e,
      );

      if (e is DioException && e.type == DioExceptionType.badResponse) {
        //throw CoreError(e.message, statusCode: e.response?.statusCode ?? 0);
        return e.response!;
      } else {
        throw CoreError("发送HEAD请求失败: ${e.toString()}");
      }
    }
  }

  /// Get请求，返回Response
  /// * [url] 请求链接
  /// * [queryParameters] 请求参数
  /// * [cancel] 任务取消Token
  Future<Response<dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    CancelToken? cancel,
  }) async {
    try {
      queryParameters ??= {};
      header ??= {};
      var result = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.json,
          headers: header,
        ),
        cancelToken: cancel,
      );
      return result;
    } catch (e) {
      // 详细记录错误信息
      developer.log(
        '❌ get 失败\n'
        '🔗 URL: $url\n'
        '📋 Query: $queryParameters\n'
        '🎫 Headers: $header\n'
        '⚠️ 错误: ${e.toString()}',
        name: 'HTTP_ERROR',
        error: e,
      );

      if (e is DioException && e.type == DioExceptionType.badResponse) {
        return e.response!;
      } else {
        throw CoreError("发送GET请求失败: ${e.toString()}");
      }
    }
  }
}
