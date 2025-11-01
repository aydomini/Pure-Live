// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(name) => "${name} is offline.";

  static String m1(name) => "${name} is replaying.";

  static String m2(version) => "New version found: v${version}";

  static String m3(number) => "GroupNo.: ${number}";

  static String m4(roomid, platform, nickname, title, livestatus) =>
      "RoomId: ${roomid}\nPlatform: ${platform}\nName: ${nickname}\nTitle: ${title}\nLiveStatus: ${livestatus}";

  static String m5(time) => "${time} Min";

  static String m6(name) => "Are you sure to unfollow ${name}?";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "app_download_info": MessageLookupByLibrary.simpleMessage(
      "Free & Open Source, Download from China: 123Pan",
    ),
    "app_legalese": MessageLookupByLibrary.simpleMessage(
      "This is a third-party live streaming player optimized for macOS and iOS platforms. We do not collect user information. The application directly requests the live streaming platform\'s official interface. All data is stored locally on the user\'s device, with optional WebDAV synchronization.",
    ),
    "app_name": MessageLookupByLibrary.simpleMessage("PureLive"),
    "areas_title": MessageLookupByLibrary.simpleMessage("Areas"),
    "aspect_ratio": MessageLookupByLibrary.simpleMessage("Aspect Ratio"),
    "auto_backup": MessageLookupByLibrary.simpleMessage("Auto Backup"),
    "auto_refresh_time": MessageLookupByLibrary.simpleMessage(
      "Auto Refresh Time",
    ),
    "auto_refresh_time_subtitle": MessageLookupByLibrary.simpleMessage(
      "Auto refresh favorites rooms status",
    ),
    "auto_shutdown_time": MessageLookupByLibrary.simpleMessage(
      "Auto ShutDown Time",
    ),
    "auto_shutdown_time_subtitle": MessageLookupByLibrary.simpleMessage(
      "Auto close app",
    ),
    "back_to_bottom": MessageLookupByLibrary.simpleMessage("Back to Bottom"),
    "backup_directory": MessageLookupByLibrary.simpleMessage(
      "Backup Directory",
    ),
    "backup_recover": MessageLookupByLibrary.simpleMessage("Backup &Recover"),
    "backup_recover_subtitle": MessageLookupByLibrary.simpleMessage(
      "Create backup and recover",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cannot_parse_link": MessageLookupByLibrary.simpleMessage(
      "Cannot parse this link",
    ),
    "change_language": MessageLookupByLibrary.simpleMessage("Language"),
    "change_language_subtitle": MessageLookupByLibrary.simpleMessage(
      "Change the display language of the app",
    ),
    "change_player": MessageLookupByLibrary.simpleMessage("Change videoPlayer"),
    "change_player_subtitle": MessageLookupByLibrary.simpleMessage(
      "Change videoPlayer of liveroom",
    ),
    "change_theme_color": MessageLookupByLibrary.simpleMessage("Theme Color"),
    "change_theme_color_subtitle": MessageLookupByLibrary.simpleMessage(
      "Change the primay color of the app",
    ),
    "change_theme_mode": MessageLookupByLibrary.simpleMessage("Theme Mode"),
    "change_theme_mode_subtitle": MessageLookupByLibrary.simpleMessage(
      "Change form light / dark / system modes",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "compatibility_mode": MessageLookupByLibrary.simpleMessage(
      "Compatibility Mode",
    ),
    "compatibility_mode_subtitle": MessageLookupByLibrary.simpleMessage(
      "Try enabling this if playback is choppy",
    ),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "contact": MessageLookupByLibrary.simpleMessage("Contact"),
    "create_backup": MessageLookupByLibrary.simpleMessage("Backup"),
    "create_backup_failed": MessageLookupByLibrary.simpleMessage(
      "Create backup failed",
    ),
    "create_backup_subtitle": MessageLookupByLibrary.simpleMessage(
      "Used to recover from current",
    ),
    "create_backup_success": MessageLookupByLibrary.simpleMessage(
      "Create backup success",
    ),
    "custom": MessageLookupByLibrary.simpleMessage("Custom"),
    "danmaku_area_fullscreen": MessageLookupByLibrary.simpleMessage(
      "Fullscreen",
    ),
    "danmaku_area_one_third": MessageLookupByLibrary.simpleMessage(
      "1/3 Screen",
    ),
    "danmaku_area_two_thirds": MessageLookupByLibrary.simpleMessage(
      "2/3 Screen",
    ),
    "danmaku_display_area": MessageLookupByLibrary.simpleMessage(
      "Danmaku Display Area",
    ),
    "danmaku_filter_subtitle": MessageLookupByLibrary.simpleMessage(
      "Filter danmaku by custom keywords",
    ),
    "danmaku_filter_title": MessageLookupByLibrary.simpleMessage(
      "Danmaku Filter",
    ),
    "develop_progress": MessageLookupByLibrary.simpleMessage("Development"),
    "dlan_button_info": MessageLookupByLibrary.simpleMessage("DLNA Broadcast"),
    "dlan_device_not_found": MessageLookupByLibrary.simpleMessage(
      "DLNA device not found",
    ),
    "dlan_title": MessageLookupByLibrary.simpleMessage("DLNA"),
    "double_click_to_exit": MessageLookupByLibrary.simpleMessage(
      "Double click to exit",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "empty_areas_room_subtitle": MessageLookupByLibrary.simpleMessage(
      "Pull down to refresh data",
    ),
    "empty_areas_room_title": MessageLookupByLibrary.simpleMessage(
      "No Live Found",
    ),
    "empty_areas_subtitle": MessageLookupByLibrary.simpleMessage(
      "Click the button below\nto switch platform",
    ),
    "empty_areas_title": MessageLookupByLibrary.simpleMessage("No Area Found"),
    "empty_favorite_offline_subtitle": MessageLookupByLibrary.simpleMessage(
      "Please follow live rooms first",
    ),
    "empty_favorite_offline_title": MessageLookupByLibrary.simpleMessage(
      "No Offline Room",
    ),
    "empty_favorite_online_subtitle": MessageLookupByLibrary.simpleMessage(
      "Please follow live rooms first",
    ),
    "empty_favorite_online_title": MessageLookupByLibrary.simpleMessage(
      "No Online Room",
    ),
    "empty_favorite_subtitle": MessageLookupByLibrary.simpleMessage(
      "Please follow live rooms first",
    ),
    "empty_favorite_title": MessageLookupByLibrary.simpleMessage(
      "No Favorites",
    ),
    "empty_history": MessageLookupByLibrary.simpleMessage("No history here"),
    "empty_live_subtitle": MessageLookupByLibrary.simpleMessage(
      "Click the button below\nto switch platform",
    ),
    "empty_live_title": MessageLookupByLibrary.simpleMessage("No Live Found"),
    "empty_search_subtitle": MessageLookupByLibrary.simpleMessage(
      "You can input other keyword",
    ),
    "empty_search_title": MessageLookupByLibrary.simpleMessage("No Live Found"),
    "enable_background_play": MessageLookupByLibrary.simpleMessage(
      "Play Background",
    ),
    "enable_background_play_subtitle": MessageLookupByLibrary.simpleMessage(
      "When leave app, allow video play background",
    ),
    "enable_codec": MessageLookupByLibrary.simpleMessage("enable hardcodec"),
    "enable_dense_favorites_mode": MessageLookupByLibrary.simpleMessage(
      "Dense Mode",
    ),
    "enable_dense_favorites_mode_subtitle":
        MessageLookupByLibrary.simpleMessage(
          "Display more favorite rooms at once",
        ),
    "enable_fullscreen_default": MessageLookupByLibrary.simpleMessage(
      "Auto Full Screen",
    ),
    "enable_fullscreen_default_subtitle": MessageLookupByLibrary.simpleMessage(
      "When enter live play, auto into full screen",
    ),
    "enable_screen_keep_on": MessageLookupByLibrary.simpleMessage(
      "Keep Screen On",
    ),
    "enable_screen_keep_on_subtitle": MessageLookupByLibrary.simpleMessage(
      "When in live play, keep screen on",
    ),
    "exit_app": MessageLookupByLibrary.simpleMessage(
      "Are you sure want to exit?",
    ),
    "exit_no": MessageLookupByLibrary.simpleMessage("No"),
    "exit_yes": MessageLookupByLibrary.simpleMessage("Yes"),
    "exo_player": MessageLookupByLibrary.simpleMessage("Exo Player"),
    "experiment": MessageLookupByLibrary.simpleMessage("Experiment"),
    "failed_to_get_link": MessageLookupByLibrary.simpleMessage(
      "Failed to get stream link",
    ),
    "favorite_areas": MessageLookupByLibrary.simpleMessage("Favorite Areas"),
    "favorites_title": MessageLookupByLibrary.simpleMessage("Favorites"),
    "float_overlay_ratio": MessageLookupByLibrary.simpleMessage(
      "Float Video Ratio",
    ),
    "float_overlay_ratio_subtitle": MessageLookupByLibrary.simpleMessage(
      "When using float window, ratio control the size",
    ),
    "float_window_play": MessageLookupByLibrary.simpleMessage(
      "Play by float window",
    ),
    "follow": MessageLookupByLibrary.simpleMessage("Follow"),
    "followed": MessageLookupByLibrary.simpleMessage("Followed"),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "get_stream_link": MessageLookupByLibrary.simpleMessage("Get Stream Link"),
    "github": MessageLookupByLibrary.simpleMessage("Github"),
    "help": MessageLookupByLibrary.simpleMessage("Help"),
    "hide_offline_rooms": MessageLookupByLibrary.simpleMessage(
      "Hide Offline Rooms",
    ),
    "history": MessageLookupByLibrary.simpleMessage("History"),
    "import_from_network": MessageLookupByLibrary.simpleMessage(
      "Import from Network",
    ),
    "info_is_offline": m0,
    "info_is_replay": m1,
    "issue_feedback": MessageLookupByLibrary.simpleMessage("Issue Feedback"),
    "license": MessageLookupByLibrary.simpleMessage("License"),
    "link_access": MessageLookupByLibrary.simpleMessage("Link Access"),
    "link_cannot_be_empty": MessageLookupByLibrary.simpleMessage(
      "Link cannot be empty",
    ),
    "link_copied": MessageLookupByLibrary.simpleMessage("Link copied"),
    "link_jump": MessageLookupByLibrary.simpleMessage("Link Jump"),
    "local_import": MessageLookupByLibrary.simpleMessage("Local Import"),
    "minutes_unit": MessageLookupByLibrary.simpleMessage("min"),
    "move_to_top": MessageLookupByLibrary.simpleMessage("Move To Top"),
    "mpv_player": MessageLookupByLibrary.simpleMessage("MPV Player"),
    "network_import": MessageLookupByLibrary.simpleMessage("Network Import"),
    "new_version_info": m2,
    "no_new_version_info": MessageLookupByLibrary.simpleMessage(
      "You are using the latest version.",
    ),
    "not_supported_yet": MessageLookupByLibrary.simpleMessage(
      "Not Supported Yet",
    ),
    "offline": MessageLookupByLibrary.simpleMessage("Offline"),
    "offline_room_title": MessageLookupByLibrary.simpleMessage("Offline"),
    "online_room_title": MessageLookupByLibrary.simpleMessage("Online"),
    "only_living": MessageLookupByLibrary.simpleMessage("Only Living"),
    "platform_all": MessageLookupByLibrary.simpleMessage("All"),
    "platform_bilibili": MessageLookupByLibrary.simpleMessage("Bilibili"),
    "platform_bilibili_short": MessageLookupByLibrary.simpleMessage("Bili"),
    "platform_cc": MessageLookupByLibrary.simpleMessage("NetEase CC"),
    "platform_douyin": MessageLookupByLibrary.simpleMessage("Douyin"),
    "platform_douyin_short": MessageLookupByLibrary.simpleMessage("Douyin"),
    "platform_douyu": MessageLookupByLibrary.simpleMessage("Douyu"),
    "platform_douyu_short": MessageLookupByLibrary.simpleMessage("Douyu"),
    "platform_huya": MessageLookupByLibrary.simpleMessage("Huya"),
    "platform_huya_short": MessageLookupByLibrary.simpleMessage("Huya"),
    "platform_iptv": MessageLookupByLibrary.simpleMessage("Network"),
    "platform_kuaishou": MessageLookupByLibrary.simpleMessage("Kuaishou"),
    "platform_settings_subtitle": MessageLookupByLibrary.simpleMessage(
      "Customize your favorite platforms",
    ),
    "platform_settings_title": MessageLookupByLibrary.simpleMessage(
      "Platform Settings",
    ),
    "play_video_failed": MessageLookupByLibrary.simpleMessage(
      "Play Video Failed",
    ),
    "popular_title": MessageLookupByLibrary.simpleMessage("Popular"),
    "prefer_platform": MessageLookupByLibrary.simpleMessage(
      "Platform Preference",
    ),
    "prefer_platform_subtitle": MessageLookupByLibrary.simpleMessage(
      "When enter popular/areas, first platform choice",
    ),
    "prefer_resolution": MessageLookupByLibrary.simpleMessage(
      "Resolution Preference",
    ),
    "prefer_resolution_subtitle": MessageLookupByLibrary.simpleMessage(
      "When enter live play, first resolution choice",
    ),
    "project": MessageLookupByLibrary.simpleMessage("Project"),
    "project_alert": MessageLookupByLibrary.simpleMessage("Project Alert"),
    "project_page": MessageLookupByLibrary.simpleMessage("Project Homepage"),
    "qq_group": MessageLookupByLibrary.simpleMessage("QQ Group"),
    "qq_group_num": m3,
    "quality": MessageLookupByLibrary.simpleMessage("Quality"),
    "recover_backup": MessageLookupByLibrary.simpleMessage("Recover"),
    "recover_backup_failed": MessageLookupByLibrary.simpleMessage(
      "Recover backup failed",
    ),
    "recover_backup_subtitle": MessageLookupByLibrary.simpleMessage(
      "Recover form selected file",
    ),
    "recover_backup_success": MessageLookupByLibrary.simpleMessage(
      "Recover backup success, please restart",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Remove"),
    "replay": MessageLookupByLibrary.simpleMessage("REPLAY"),
    "repository_url": MessageLookupByLibrary.simpleMessage(
      "https://github.com/aydomini/pure-live",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "room_info_content": m4,
    "room_jump": MessageLookupByLibrary.simpleMessage("Room Jump"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "search_input_hint": MessageLookupByLibrary.simpleMessage(
      "Input live room keyword",
    ),
    "search_live": MessageLookupByLibrary.simpleMessage("Search Live"),
    "select_quality": MessageLookupByLibrary.simpleMessage("Select Quality"),
    "select_recover_file": MessageLookupByLibrary.simpleMessage(
      "Select backup file",
    ),
    "select_stream": MessageLookupByLibrary.simpleMessage("Select Stream"),
    "set_cookie": MessageLookupByLibrary.simpleMessage("Set Cookie"),
    "settings_danmaku_amount": MessageLookupByLibrary.simpleMessage(
      "Danmaku amount",
    ),
    "settings_danmaku_area": MessageLookupByLibrary.simpleMessage(
      "Danmaku area",
    ),
    "settings_danmaku_fontBorder": MessageLookupByLibrary.simpleMessage(
      "Border width",
    ),
    "settings_danmaku_fontsize": MessageLookupByLibrary.simpleMessage(
      "Danmaku fontsize",
    ),
    "settings_danmaku_opacity": MessageLookupByLibrary.simpleMessage(
      "Danmaku opacity",
    ),
    "settings_danmaku_open": MessageLookupByLibrary.simpleMessage(
      "Danmaku switch",
    ),
    "settings_danmaku_speed": MessageLookupByLibrary.simpleMessage(
      "Danmaku speed",
    ),
    "settings_danmaku_title": MessageLookupByLibrary.simpleMessage(
      "Danmaku Setting",
    ),
    "settings_timedclose_title": MessageLookupByLibrary.simpleMessage(
      "Timed Close",
    ),
    "settings_title": MessageLookupByLibrary.simpleMessage("Settings"),
    "settings_videofit_title": MessageLookupByLibrary.simpleMessage(
      "Video Fit",
    ),
    "show_offline_rooms": MessageLookupByLibrary.simpleMessage(
      "Show Offline Rooms",
    ),
    "support_donate": MessageLookupByLibrary.simpleMessage("Donate Support"),
    "support_local_and_network": MessageLookupByLibrary.simpleMessage(
      "Support local files and network links",
    ),
    "switch_platform": MessageLookupByLibrary.simpleMessage("Switch platform"),
    "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
    "third_party_auth": MessageLookupByLibrary.simpleMessage(
      "Third-Party Auth",
    ),
    "timed_close": MessageLookupByLibrary.simpleMessage("Timed Close"),
    "timedclose_time": m5,
    "toolbox": MessageLookupByLibrary.simpleMessage("Toolbox"),
    "toolbox_input_hint": MessageLookupByLibrary.simpleMessage(
      "Enter or paste live streaming links from Bilibili/Huya/Douyu/Douyin/CC/Kuaishou",
    ),
    "unfollow": MessageLookupByLibrary.simpleMessage("Unfollow"),
    "unfollow_message": m6,
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "version_history": MessageLookupByLibrary.simpleMessage("Version History"),
    "video": MessageLookupByLibrary.simpleMessage("Video"),
    "video_fit_contain": MessageLookupByLibrary.simpleMessage("Fit"),
    "video_fit_cover": MessageLookupByLibrary.simpleMessage("Fill"),
    "video_fit_fill": MessageLookupByLibrary.simpleMessage("Stretch"),
    "video_player_subtitle": MessageLookupByLibrary.simpleMessage(
      "Select video player",
    ),
    "video_player_title": MessageLookupByLibrary.simpleMessage("Video Player"),
    "videofit_contain": MessageLookupByLibrary.simpleMessage("Default"),
    "videofit_cover": MessageLookupByLibrary.simpleMessage("Cover"),
    "videofit_fill": MessageLookupByLibrary.simpleMessage("Fill"),
    "videofit_fitheight": MessageLookupByLibrary.simpleMessage("AdaptHeight"),
    "videofit_fitwidth": MessageLookupByLibrary.simpleMessage("AdaptWidth"),
    "what_is_new": MessageLookupByLibrary.simpleMessage("New Features"),
  };
}
