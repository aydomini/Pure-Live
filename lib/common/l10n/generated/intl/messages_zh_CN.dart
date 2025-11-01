// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static String m0(name) => "${name}未开始直播.";

  static String m1(name) => "${name}轮播视频中.";

  static String m2(version) => "发现新版本: v${version}";

  static String m3(number) => "群号: ${number}";

  static String m4(roomid, platform, nickname, title, livestatus) =>
      "房间号: ${roomid}\n平台: ${platform}\n昵称: ${nickname}\n标题: ${title}\n状态: ${livestatus}";

  static String m5(time) => "${time} 分钟";

  static String m6(name) => "确定要取消关注${name}吗？";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("关于"),
    "app_download_info": MessageLookupByLibrary.simpleMessage(
      "本软件开源免费,国内下载：123云盘",
    ),
    "app_legalese": MessageLookupByLibrary.simpleMessage(
      "本项目是一个专为 macOS 和 iOS 平台优化的第三方直播播放器，不收集用户信息，应用程序直接请求直播官方接口，所有操作生成的数据由用户本地保留，可选择性使用 WebDAV 同步数据。",
    ),
    "app_name": MessageLookupByLibrary.simpleMessage("纯粹直播"),
    "areas_title": MessageLookupByLibrary.simpleMessage("分区"),
    "aspect_ratio": MessageLookupByLibrary.simpleMessage("比例"),
    "auto_backup": MessageLookupByLibrary.simpleMessage("备份目录"),
    "auto_refresh_time": MessageLookupByLibrary.simpleMessage("定时刷新时间"),
    "auto_refresh_time_subtitle": MessageLookupByLibrary.simpleMessage(
      "定时刷新关注直播间状态",
    ),
    "auto_shutdown_time": MessageLookupByLibrary.simpleMessage("定时关闭时间"),
    "auto_shutdown_time_subtitle": MessageLookupByLibrary.simpleMessage(
      "定时关闭app",
    ),
    "back_to_bottom": MessageLookupByLibrary.simpleMessage("回到底部"),
    "backup_directory": MessageLookupByLibrary.simpleMessage("备份目录"),
    "backup_recover": MessageLookupByLibrary.simpleMessage("备份与恢复"),
    "backup_recover_subtitle": MessageLookupByLibrary.simpleMessage("创建备份与恢复"),
    "cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "cannot_parse_link": MessageLookupByLibrary.simpleMessage("无法解析此链接"),
    "change_language": MessageLookupByLibrary.simpleMessage("切换语言"),
    "change_language_subtitle": MessageLookupByLibrary.simpleMessage(
      "切换软件的显示语言",
    ),
    "change_player": MessageLookupByLibrary.simpleMessage("切换播放器"),
    "change_player_subtitle": MessageLookupByLibrary.simpleMessage("切换直播间播放器"),
    "change_theme_color": MessageLookupByLibrary.simpleMessage("主题颜色"),
    "change_theme_color_subtitle": MessageLookupByLibrary.simpleMessage(
      "切换软件的主题颜色",
    ),
    "change_theme_mode": MessageLookupByLibrary.simpleMessage("主题模式"),
    "change_theme_mode_subtitle": MessageLookupByLibrary.simpleMessage(
      "切换系统/亮色/暗色模式",
    ),
    "close": MessageLookupByLibrary.simpleMessage("关闭"),
    "compatibility_mode": MessageLookupByLibrary.simpleMessage("兼容模式"),
    "compatibility_mode_subtitle": MessageLookupByLibrary.simpleMessage(
      "若播放卡顿可尝试打开此选项",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("确认"),
    "contact": MessageLookupByLibrary.simpleMessage("联系"),
    "create_backup": MessageLookupByLibrary.simpleMessage("创建备份"),
    "create_backup_failed": MessageLookupByLibrary.simpleMessage("创建备份失败"),
    "create_backup_subtitle": MessageLookupByLibrary.simpleMessage("可用于恢复当前数据"),
    "create_backup_success": MessageLookupByLibrary.simpleMessage("创建备份成功"),
    "custom": MessageLookupByLibrary.simpleMessage("定制"),
    "danmaku_area_fullscreen": MessageLookupByLibrary.simpleMessage("全屏"),
    "danmaku_area_one_third": MessageLookupByLibrary.simpleMessage("1/3屏"),
    "danmaku_area_two_thirds": MessageLookupByLibrary.simpleMessage("2/3屏"),
    "danmaku_display_area": MessageLookupByLibrary.simpleMessage("弹幕显示区域"),
    "danmaku_filter_subtitle": MessageLookupByLibrary.simpleMessage(
      "自定义关键词过滤弹幕",
    ),
    "danmaku_filter_title": MessageLookupByLibrary.simpleMessage("弹幕过滤"),
    "develop_progress": MessageLookupByLibrary.simpleMessage("开发进度"),
    "dlan_button_info": MessageLookupByLibrary.simpleMessage("DLNA投屏"),
    "dlan_device_not_found": MessageLookupByLibrary.simpleMessage("未发现DLNA设备"),
    "dlan_title": MessageLookupByLibrary.simpleMessage("DLNA投屏"),
    "double_click_to_exit": MessageLookupByLibrary.simpleMessage("双击退出"),
    "email": MessageLookupByLibrary.simpleMessage("邮件"),
    "empty_areas_room_subtitle": MessageLookupByLibrary.simpleMessage(
      "下滑/上滑刷新数据",
    ),
    "empty_areas_room_title": MessageLookupByLibrary.simpleMessage("未发现直播"),
    "empty_areas_subtitle": MessageLookupByLibrary.simpleMessage("请点击下方按钮切换平台"),
    "empty_areas_title": MessageLookupByLibrary.simpleMessage("未发现分区"),
    "empty_favorite_offline_subtitle": MessageLookupByLibrary.simpleMessage(
      "请先关注其他直播间",
    ),
    "empty_favorite_offline_title": MessageLookupByLibrary.simpleMessage(
      "无未开播直播间",
    ),
    "empty_favorite_online_subtitle": MessageLookupByLibrary.simpleMessage(
      "请先关注其他直播间",
    ),
    "empty_favorite_online_title": MessageLookupByLibrary.simpleMessage(
      "无已开播直播间",
    ),
    "empty_favorite_subtitle": MessageLookupByLibrary.simpleMessage(
      "请先关注其他直播间",
    ),
    "empty_favorite_title": MessageLookupByLibrary.simpleMessage("无关注直播"),
    "empty_history": MessageLookupByLibrary.simpleMessage("无观看历史记录"),
    "empty_live_subtitle": MessageLookupByLibrary.simpleMessage("请点击下方按钮切换平台"),
    "empty_live_title": MessageLookupByLibrary.simpleMessage("未发现直播"),
    "empty_search_subtitle": MessageLookupByLibrary.simpleMessage("请输入其他关键字搜索"),
    "empty_search_title": MessageLookupByLibrary.simpleMessage("未发现直播"),
    "enable_background_play": MessageLookupByLibrary.simpleMessage("后台播放"),
    "enable_background_play_subtitle": MessageLookupByLibrary.simpleMessage(
      "当暂时切出APP时，允许后台播放",
    ),
    "enable_codec": MessageLookupByLibrary.simpleMessage("开启硬解码"),
    "enable_dense_favorites_mode": MessageLookupByLibrary.simpleMessage("紧凑模式"),
    "enable_dense_favorites_mode_subtitle":
        MessageLookupByLibrary.simpleMessage("关注页面可显示更多直播间"),
    "enable_fullscreen_default": MessageLookupByLibrary.simpleMessage("自动全屏"),
    "enable_fullscreen_default_subtitle": MessageLookupByLibrary.simpleMessage(
      "当进入直播播放页，自动进入全屏",
    ),
    "enable_screen_keep_on": MessageLookupByLibrary.simpleMessage("屏幕常亮"),
    "enable_screen_keep_on_subtitle": MessageLookupByLibrary.simpleMessage(
      "当处于直播播放页，屏幕保持常亮",
    ),
    "exit_app": MessageLookupByLibrary.simpleMessage("确定退出吗?"),
    "exit_no": MessageLookupByLibrary.simpleMessage("取消"),
    "exit_yes": MessageLookupByLibrary.simpleMessage("确定"),
    "exo_player": MessageLookupByLibrary.simpleMessage("Exo播放器"),
    "experiment": MessageLookupByLibrary.simpleMessage("实验"),
    "failed_to_get_link": MessageLookupByLibrary.simpleMessage("读取直链失败"),
    "favorite_areas": MessageLookupByLibrary.simpleMessage("关注分区"),
    "favorites_title": MessageLookupByLibrary.simpleMessage("关注"),
    "float_overlay_ratio": MessageLookupByLibrary.simpleMessage("悬浮窗尺寸"),
    "float_overlay_ratio_subtitle": MessageLookupByLibrary.simpleMessage(
      "视频小窗播放时，悬浮窗横向相对比例",
    ),
    "float_window_play": MessageLookupByLibrary.simpleMessage("小窗播放"),
    "follow": MessageLookupByLibrary.simpleMessage("关注"),
    "followed": MessageLookupByLibrary.simpleMessage("已关注"),
    "general": MessageLookupByLibrary.simpleMessage("通用"),
    "get_stream_link": MessageLookupByLibrary.simpleMessage("获取直链"),
    "github": MessageLookupByLibrary.simpleMessage("Github"),
    "help": MessageLookupByLibrary.simpleMessage("帮助"),
    "hide_offline_rooms": MessageLookupByLibrary.simpleMessage("隐藏未直播的直播间"),
    "history": MessageLookupByLibrary.simpleMessage("历史记录"),
    "import_from_network": MessageLookupByLibrary.simpleMessage("从网络导入"),
    "info_is_offline": m0,
    "info_is_replay": m1,
    "issue_feedback": MessageLookupByLibrary.simpleMessage("问题反馈"),
    "license": MessageLookupByLibrary.simpleMessage("开源许可证"),
    "link_access": MessageLookupByLibrary.simpleMessage("链接访问"),
    "link_cannot_be_empty": MessageLookupByLibrary.simpleMessage("链接不能为空"),
    "link_copied": MessageLookupByLibrary.simpleMessage("已复制直链"),
    "link_jump": MessageLookupByLibrary.simpleMessage("链接跳转"),
    "local_import": MessageLookupByLibrary.simpleMessage("本地导入"),
    "minutes_unit": MessageLookupByLibrary.simpleMessage("分钟"),
    "move_to_top": MessageLookupByLibrary.simpleMessage("移到顶部"),
    "mpv_player": MessageLookupByLibrary.simpleMessage("Mpv播放器"),
    "network_import": MessageLookupByLibrary.simpleMessage("网络导入"),
    "new_version_info": m2,
    "no_new_version_info": MessageLookupByLibrary.simpleMessage("已在使用最新版本"),
    "not_supported_yet": MessageLookupByLibrary.simpleMessage("尚不支持"),
    "offline": MessageLookupByLibrary.simpleMessage("未直播"),
    "offline_room_title": MessageLookupByLibrary.simpleMessage("未开播"),
    "online_room_title": MessageLookupByLibrary.simpleMessage("已开播"),
    "only_living": MessageLookupByLibrary.simpleMessage("只搜索直播中"),
    "platform_all": MessageLookupByLibrary.simpleMessage("全部"),
    "platform_bilibili": MessageLookupByLibrary.simpleMessage("哔哩哔哩"),
    "platform_bilibili_short": MessageLookupByLibrary.simpleMessage("哔哩"),
    "platform_cc": MessageLookupByLibrary.simpleMessage("网易CC"),
    "platform_douyin": MessageLookupByLibrary.simpleMessage("抖音直播"),
    "platform_douyin_short": MessageLookupByLibrary.simpleMessage("抖音"),
    "platform_douyu": MessageLookupByLibrary.simpleMessage("斗鱼直播"),
    "platform_douyu_short": MessageLookupByLibrary.simpleMessage("斗鱼"),
    "platform_huya": MessageLookupByLibrary.simpleMessage("虎牙直播"),
    "platform_huya_short": MessageLookupByLibrary.simpleMessage("虎牙"),
    "platform_iptv": MessageLookupByLibrary.simpleMessage("网络"),
    "platform_kuaishou": MessageLookupByLibrary.simpleMessage("快手"),
    "platform_settings_subtitle": MessageLookupByLibrary.simpleMessage(
      "自定义观看喜爱的平台",
    ),
    "platform_settings_title": MessageLookupByLibrary.simpleMessage("平台设置"),
    "play_video_failed": MessageLookupByLibrary.simpleMessage("无法播放直播"),
    "popular_title": MessageLookupByLibrary.simpleMessage("热门"),
    "prefer_platform": MessageLookupByLibrary.simpleMessage("首选直播平台"),
    "prefer_platform_subtitle": MessageLookupByLibrary.simpleMessage(
      "当进入热门/分区，首选的直播平台",
    ),
    "prefer_resolution": MessageLookupByLibrary.simpleMessage("首选清晰度"),
    "prefer_resolution_subtitle": MessageLookupByLibrary.simpleMessage(
      "当进入直播播放页，首选的视频清晰度",
    ),
    "project": MessageLookupByLibrary.simpleMessage("项目"),
    "project_alert": MessageLookupByLibrary.simpleMessage("项目声明"),
    "project_page": MessageLookupByLibrary.simpleMessage("项目主页"),
    "qq_group": MessageLookupByLibrary.simpleMessage("QQ群"),
    "qq_group_num": m3,
    "quality": MessageLookupByLibrary.simpleMessage("画质"),
    "recover_backup": MessageLookupByLibrary.simpleMessage("恢复备份"),
    "recover_backup_failed": MessageLookupByLibrary.simpleMessage("恢复备份失败"),
    "recover_backup_subtitle": MessageLookupByLibrary.simpleMessage("从备份文件中恢复"),
    "recover_backup_success": MessageLookupByLibrary.simpleMessage(
      "恢复备份成功，请重启",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("删除"),
    "replay": MessageLookupByLibrary.simpleMessage("录播"),
    "repository_url": MessageLookupByLibrary.simpleMessage(
      "https://github.com/aydomini/pure-live",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("重试"),
    "room_info_content": m4,
    "room_jump": MessageLookupByLibrary.simpleMessage("直播间跳转"),
    "search": MessageLookupByLibrary.simpleMessage("搜索"),
    "search_input_hint": MessageLookupByLibrary.simpleMessage("输入直播关键字"),
    "search_live": MessageLookupByLibrary.simpleMessage("搜索直播"),
    "select_quality": MessageLookupByLibrary.simpleMessage("选择清晰度"),
    "select_recover_file": MessageLookupByLibrary.simpleMessage("选择备份文件"),
    "select_stream": MessageLookupByLibrary.simpleMessage("选择线路"),
    "set_cookie": MessageLookupByLibrary.simpleMessage("设置cookie"),
    "settings_danmaku_amount": MessageLookupByLibrary.simpleMessage("弹幕数量"),
    "settings_danmaku_area": MessageLookupByLibrary.simpleMessage("弹幕区域"),
    "settings_danmaku_fontBorder": MessageLookupByLibrary.simpleMessage("描边宽度"),
    "settings_danmaku_fontsize": MessageLookupByLibrary.simpleMessage("弹幕字号"),
    "settings_danmaku_opacity": MessageLookupByLibrary.simpleMessage("不透明度"),
    "settings_danmaku_open": MessageLookupByLibrary.simpleMessage("弹幕开关"),
    "settings_danmaku_speed": MessageLookupByLibrary.simpleMessage("弹幕速度"),
    "settings_danmaku_title": MessageLookupByLibrary.simpleMessage("弹幕设置"),
    "settings_timedclose_title": MessageLookupByLibrary.simpleMessage("定时关闭"),
    "settings_title": MessageLookupByLibrary.simpleMessage("设置"),
    "settings_videofit_title": MessageLookupByLibrary.simpleMessage("比例设置"),
    "show_offline_rooms": MessageLookupByLibrary.simpleMessage("显示未直播的直播间"),
    "support_donate": MessageLookupByLibrary.simpleMessage("捐赠支持"),
    "support_local_and_network": MessageLookupByLibrary.simpleMessage(
      "支持本地文件和网络链接",
    ),
    "switch_platform": MessageLookupByLibrary.simpleMessage("切换直播平台"),
    "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
    "third_party_auth": MessageLookupByLibrary.simpleMessage("三方认证"),
    "timed_close": MessageLookupByLibrary.simpleMessage("定时关闭"),
    "timedclose_time": m5,
    "toolbox": MessageLookupByLibrary.simpleMessage("工具箱"),
    "toolbox_input_hint": MessageLookupByLibrary.simpleMessage(
      "输入或粘贴哔哩哔哩直播/虎牙直播/斗鱼直播/抖音/网易cc/快手直播的链接",
    ),
    "unfollow": MessageLookupByLibrary.simpleMessage("取消关注"),
    "unfollow_message": m6,
    "update": MessageLookupByLibrary.simpleMessage("更新"),
    "version": MessageLookupByLibrary.simpleMessage("版本"),
    "version_history": MessageLookupByLibrary.simpleMessage("版本历史更新"),
    "video": MessageLookupByLibrary.simpleMessage("视频"),
    "video_fit_contain": MessageLookupByLibrary.simpleMessage("适应"),
    "video_fit_cover": MessageLookupByLibrary.simpleMessage("填满"),
    "video_fit_fill": MessageLookupByLibrary.simpleMessage("拉伸"),
    "video_player_subtitle": MessageLookupByLibrary.simpleMessage("选择视频播放器"),
    "video_player_title": MessageLookupByLibrary.simpleMessage("视频播放器"),
    "videofit_contain": MessageLookupByLibrary.simpleMessage("默认比例"),
    "videofit_cover": MessageLookupByLibrary.simpleMessage("居中裁剪"),
    "videofit_fill": MessageLookupByLibrary.simpleMessage("填充屏幕"),
    "videofit_fitheight": MessageLookupByLibrary.simpleMessage("适应高度"),
    "videofit_fitwidth": MessageLookupByLibrary.simpleMessage("适应宽度"),
    "what_is_new": MessageLookupByLibrary.simpleMessage("最新特性"),
  };
}
