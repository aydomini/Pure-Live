import 'dart:async';
import 'dart:developer' as developer;
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 紧急修复：添加请求队列和错误重试机制
class BaseControllerPatch extends GetxController {
  /// 加载中，更新页面
  var pageLoadding = false.obs;

  /// 加载中,不会更新页面
  var loadding = false;

  /// 空白页面
  var pageEmpty = false.obs;

  /// 页面错误
  var pageError = false.obs;

  /// 未登录
  var notLogin = false.obs;

  /// 错误信息
  var errorMsg = "".obs;

  /// 显示错误
  /// * [msg] 错误信息
  /// * [showPageError] 显示页面错误
  /// * 只在第一页加载错误时showPageError=true，后续页加载错误时使用Toast弹出通知
  void handleError(Object exception, {bool showPageError = false}) {
    var msg = exceptionToString(exception);

    developer.log(
      '⚠️ Controller 错误\n'
      '📄 Page: ${currentPage ?? 0}\n'
      '💬 Message: $msg\n'
      '🔍 Exception: $exception',
      name: 'CONTROLLER_ERROR',
      error: exception,
    );

    if (showPageError) {
      pageError.value = true;
      errorMsg.value = msg;
    } else {
      SmartDialog.showToast(exceptionToString(msg));
    }
  }

  String exceptionToString(Object exception) {
    return exception.toString().replaceAll("Exception:", "");
  }

  void onLogin() {}
  void onLogout() {}

  int? currentPage;
}

class BasePageControllerPatch<T> extends BaseControllerPatch {
  final ScrollController scrollController = ScrollController();
  final EasyRefreshController easyRefreshController = EasyRefreshController();

  @override
  int currentPage = 1;

  int count = 0;
  int maxPage = 0;
  int pageSize = 30;
  var canLoadMore = false.obs;
  var list = <T>[].obs;

  /// 🔥 新增：请求队列，避免并发过载
  bool _isRefreshing = false;
  Timer? _retryTimer;
  int _retryCount = 0;
  static const _maxRetries = 3;

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          loadData();
        }
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    _retryTimer?.cancel();
    super.onClose();
  }

  Future refreshData() async {
    // 🔥 防止重复刷新
    if (_isRefreshing) {
      developer.log('⚠️ 刷新被跳过：上一次刷新未完成', name: 'CONTROLLER');
      return;
    }

    try {
      _isRefreshing = true;
      currentPage = 1;
      list.value = [];

      developer.log('🔄 开始刷新数据', name: 'CONTROLLER');
      await loadData();

      // 刷新成功，重置重试计数
      _retryCount = 0;
    } finally {
      _isRefreshing = false;
    }
  }

  Future loadData() async {
    // 🔥 防止并发加载
    if (loadding) {
      developer.log('⚠️ 加载被跳过：正在加载中', name: 'CONTROLLER');
      return;
    }

    try {
      loadding = true;
      pageError.value = false;
      pageEmpty.value = false;
      notLogin.value = false;
      pageLoadding.value = currentPage == 1;

      developer.log(
        '📥 开始加载数据\n'
        '📄 Page: $currentPage\n'
        '📊 PageSize: $pageSize',
        name: 'CONTROLLER',
      );

      var result = await getData(currentPage, pageSize);

      developer.log(
        '✅ 数据加载成功\n'
        '📄 Page: $currentPage\n'
        '📊 结果数量: ${result.length}',
        name: 'CONTROLLER',
      );

      //是否可以加载更多
      if (result.isNotEmpty) {
        currentPage++;
        canLoadMore.value = true;
        pageEmpty.value = false;
      } else {
        canLoadMore.value = false;
        if (currentPage == 1) {
          pageEmpty.value = true;
        }
      }

      // 赋值数据
      if (currentPage == 1) {
        list.value = result;
      } else {
        list.addAll(result);
      }

      // 加载成功，重置重试计数
      _retryCount = 0;

    } catch (e) {
      developer.log(
        '❌ 数据加载失败\n'
        '📄 Page: $currentPage\n'
        '🔄 重试次数: $_retryCount/$_maxRetries\n'
        '⚠️ 错误: $e',
        name: 'CONTROLLER_ERROR',
        error: e,
      );

      handleError(e, showPageError: currentPage == 1);

      // 🔥 自动重试机制
      if (_retryCount < _maxRetries) {
        _scheduleRetry();
      }
    } finally {
      loadding = false;
      pageLoadding.value = false;
    }
  }

  /// 🔥 延迟重试（指数退避）
  void _scheduleRetry() {
    _retryCount++;
    final delaySeconds = [2, 5, 10][_retryCount - 1];

    developer.log(
      '⏰ 将在 $delaySeconds 秒后自动重试 (第 $_retryCount 次)',
      name: 'CONTROLLER',
    );

    _retryTimer?.cancel();
    _retryTimer = Timer(Duration(seconds: delaySeconds), () {
      developer.log('🔄 执行自动重试', name: 'CONTROLLER');
      refreshData();
    });
  }

  Future<List<T>> getData(int page, int pageSize) async {
    return [];
  }

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  void scrollToTopOrRefresh() {
    if (scrollController.offset > 0) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    } else {
      easyRefreshController.callRefresh();
    }
  }
}
