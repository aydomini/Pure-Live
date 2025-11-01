import 'dart:convert';
import 'package:http/http.dart' as http;

class VersionUtil {
  static const String version = '2.1.0';
  static const String projectUrl = 'https://github.com/aydomini/pure-live';
  static const String releaseUrl = 'https://api.github.com/repos/aydomini/pure-live/releases';
  static const String issuesUrl = 'https://github.com/aydomini/pure-live/issues';
  static const String kanbanUrl =
      'https://jackiu-notes.notion.site/50bc0d3d377445eea029c6e3d4195671?v=663125e639b047cea5e69d8264926b8b';

  static const String githubUrl = 'https://github.com/aydomini';
  static const String email = '17792321552@163.com';
  static const String emailUrl = 'mailto:17792321552@163.com?subject=PureLive Feedback';
  static const String telegramGroup = 't.me/pure_live_channel';
  static const String telegramGroupUrl = 'https://t.me/pure_live_channel';

  static String latestVersion = version;
  static String latestUpdateLog = '''
v2.1.0 更新内容：
• 优化关于页面，精简展示内容
• 弹幕设置弹窗支持响应式布局
• 移除播放器高级设置，使用默认配置
• 移除M3U导入功能，专注直播平台
• 优化macOS和iOS用户体验
• 界面优化，提升整体使用流畅度
''';
  static List allReleased = [];
  static Future<void> checkUpdate() async {
    try {
      var response = await http.get(
        Uri.parse(releaseUrl),
        headers: {'Accept-Charset': 'utf-8'},
      );
      // 确保响应体使用 UTF-8 解码
      final body = utf8.decode(response.bodyBytes);
      allReleased = await jsonDecode(body);
      var latest = allReleased[0];
      latestVersion = latest['tag_name'].replaceAll('v', '');
      latestUpdateLog = latest['body'] ?? latestUpdateLog;
    } catch (e) {
      // 保持默认的更新日志，不显示错误
      // latestUpdateLog = e.toString();
    }
  }

  static bool hasNewVersion() {
    List latestVersions = latestVersion.split('-')[0].split('.');
    List versions = version.split('-')[0].split('.');
    for (int i = 0; i < latestVersions.length; i++) {
      if (int.parse(latestVersions[i]) > int.parse(versions[i])) {
        return true;
      } else if (int.parse(latestVersions[i]) < int.parse(versions[i])) {
        return false;
      }
    }
    return false;
  }
}
