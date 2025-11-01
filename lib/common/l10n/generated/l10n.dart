// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `PureLive`
  String get app_name {
    return Intl.message('PureLive', name: 'app_name', desc: '', args: []);
  }

  /// `This is a third-party live streaming player optimized for macOS and iOS platforms. We do not collect user information. The application directly requests the live streaming platform's official interface. All data is stored locally on the user's device, with optional WebDAV synchronization.`
  String get app_legalese {
    return Intl.message(
      'This is a third-party live streaming player optimized for macOS and iOS platforms. We do not collect user information. The application directly requests the live streaming platform\'s official interface. All data is stored locally on the user\'s device, with optional WebDAV synchronization.',
      name: 'app_legalese',
      desc: '',
      args: [],
    );
  }

  /// `https://github.com/aydomini/pure-live`
  String get repository_url {
    return Intl.message(
      'https://github.com/aydomini/pure-live',
      name: 'repository_url',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Remove`
  String get remove {
    return Intl.message('Remove', name: 'remove', desc: '', args: []);
  }

  /// `Move To Top`
  String get move_to_top {
    return Intl.message('Move To Top', name: 'move_to_top', desc: '', args: []);
  }

  /// `Favorites`
  String get favorites_title {
    return Intl.message(
      'Favorites',
      name: 'favorites_title',
      desc: '',
      args: [],
    );
  }

  /// `No Favorites`
  String get empty_favorite_title {
    return Intl.message(
      'No Favorites',
      name: 'empty_favorite_title',
      desc: '',
      args: [],
    );
  }

  /// `Please follow live rooms first`
  String get empty_favorite_subtitle {
    return Intl.message(
      'Please follow live rooms first',
      name: 'empty_favorite_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `No Offline Room`
  String get empty_favorite_offline_title {
    return Intl.message(
      'No Offline Room',
      name: 'empty_favorite_offline_title',
      desc: '',
      args: [],
    );
  }

  /// `Please follow live rooms first`
  String get empty_favorite_offline_subtitle {
    return Intl.message(
      'Please follow live rooms first',
      name: 'empty_favorite_offline_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `No Online Room`
  String get empty_favorite_online_title {
    return Intl.message(
      'No Online Room',
      name: 'empty_favorite_online_title',
      desc: '',
      args: [],
    );
  }

  /// `Please follow live rooms first`
  String get empty_favorite_online_subtitle {
    return Intl.message(
      'Please follow live rooms first',
      name: 'empty_favorite_online_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Show Offline Rooms`
  String get show_offline_rooms {
    return Intl.message(
      'Show Offline Rooms',
      name: 'show_offline_rooms',
      desc: '',
      args: [],
    );
  }

  /// `Hide Offline Rooms`
  String get hide_offline_rooms {
    return Intl.message(
      'Hide Offline Rooms',
      name: 'hide_offline_rooms',
      desc: '',
      args: [],
    );
  }

  /// `RoomId: {roomid}\nPlatform: {platform}\nName: {nickname}\nTitle: {title}\nLiveStatus: {livestatus}`
  String room_info_content(
    Object roomid,
    Object platform,
    Object nickname,
    Object title,
    Object livestatus,
  ) {
    return Intl.message(
      'RoomId: $roomid\nPlatform: $platform\nName: $nickname\nTitle: $title\nLiveStatus: $livestatus',
      name: 'room_info_content',
      desc: '',
      args: [roomid, platform, nickname, title, livestatus],
    );
  }

  /// `Online`
  String get online_room_title {
    return Intl.message(
      'Online',
      name: 'online_room_title',
      desc: '',
      args: [],
    );
  }

  /// `Offline`
  String get offline_room_title {
    return Intl.message(
      'Offline',
      name: 'offline_room_title',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get popular_title {
    return Intl.message('Popular', name: 'popular_title', desc: '', args: []);
  }

  /// `No Live Found`
  String get empty_live_title {
    return Intl.message(
      'No Live Found',
      name: 'empty_live_title',
      desc: '',
      args: [],
    );
  }

  /// `Click the button below\nto switch platform`
  String get empty_live_subtitle {
    return Intl.message(
      'Click the button below\nto switch platform',
      name: 'empty_live_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Areas`
  String get areas_title {
    return Intl.message('Areas', name: 'areas_title', desc: '', args: []);
  }

  /// `No Area Found`
  String get empty_areas_title {
    return Intl.message(
      'No Area Found',
      name: 'empty_areas_title',
      desc: '',
      args: [],
    );
  }

  /// `Click the button below\nto switch platform`
  String get empty_areas_subtitle {
    return Intl.message(
      'Click the button below\nto switch platform',
      name: 'empty_areas_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `No Live Found`
  String get empty_areas_room_title {
    return Intl.message(
      'No Live Found',
      name: 'empty_areas_room_title',
      desc: '',
      args: [],
    );
  }

  /// `Pull down to refresh data`
  String get empty_areas_room_subtitle {
    return Intl.message(
      'Pull down to refresh data',
      name: 'empty_areas_room_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Switch platform`
  String get switch_platform {
    return Intl.message(
      'Switch platform',
      name: 'switch_platform',
      desc: '',
      args: [],
    );
  }

  /// `Favorite Areas`
  String get favorite_areas {
    return Intl.message(
      'Favorite Areas',
      name: 'favorite_areas',
      desc: '',
      args: [],
    );
  }

  /// `Input live room keyword`
  String get search_input_hint {
    return Intl.message(
      'Input live room keyword',
      name: 'search_input_hint',
      desc: '',
      args: [],
    );
  }

  /// `Only Living`
  String get only_living {
    return Intl.message('Only Living', name: 'only_living', desc: '', args: []);
  }

  /// `No Live Found`
  String get empty_search_title {
    return Intl.message(
      'No Live Found',
      name: 'empty_search_title',
      desc: '',
      args: [],
    );
  }

  /// `You can input other keyword`
  String get empty_search_subtitle {
    return Intl.message(
      'You can input other keyword',
      name: 'empty_search_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings_title {
    return Intl.message('Settings', name: 'settings_title', desc: '', args: []);
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Video`
  String get video {
    return Intl.message('Video', name: 'video', desc: '', args: []);
  }

  /// `Custom`
  String get custom {
    return Intl.message('Custom', name: 'custom', desc: '', args: []);
  }

  /// `Experiment`
  String get experiment {
    return Intl.message('Experiment', name: 'experiment', desc: '', args: []);
  }

  /// `Theme Color`
  String get change_theme_color {
    return Intl.message(
      'Theme Color',
      name: 'change_theme_color',
      desc: '',
      args: [],
    );
  }

  /// `Change the primay color of the app`
  String get change_theme_color_subtitle {
    return Intl.message(
      'Change the primay color of the app',
      name: 'change_theme_color_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Theme Mode`
  String get change_theme_mode {
    return Intl.message(
      'Theme Mode',
      name: 'change_theme_mode',
      desc: '',
      args: [],
    );
  }

  /// `Change form light / dark / system modes`
  String get change_theme_mode_subtitle {
    return Intl.message(
      'Change form light / dark / system modes',
      name: 'change_theme_mode_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get change_language {
    return Intl.message(
      'Language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Change the display language of the app`
  String get change_language_subtitle {
    return Intl.message(
      'Change the display language of the app',
      name: 'change_language_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Backup &Recover`
  String get backup_recover {
    return Intl.message(
      'Backup &Recover',
      name: 'backup_recover',
      desc: '',
      args: [],
    );
  }

  /// `Create backup and recover`
  String get backup_recover_subtitle {
    return Intl.message(
      'Create backup and recover',
      name: 'backup_recover_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Backup`
  String get create_backup {
    return Intl.message('Backup', name: 'create_backup', desc: '', args: []);
  }

  /// `Used to recover from current`
  String get create_backup_subtitle {
    return Intl.message(
      'Used to recover from current',
      name: 'create_backup_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Recover`
  String get recover_backup {
    return Intl.message('Recover', name: 'recover_backup', desc: '', args: []);
  }

  /// `Recover form selected file`
  String get recover_backup_subtitle {
    return Intl.message(
      'Recover form selected file',
      name: 'recover_backup_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Auto Backup`
  String get auto_backup {
    return Intl.message('Auto Backup', name: 'auto_backup', desc: '', args: []);
  }

  /// `Backup Directory`
  String get backup_directory {
    return Intl.message(
      'Backup Directory',
      name: 'backup_directory',
      desc: '',
      args: [],
    );
  }

  /// `Create backup success`
  String get create_backup_success {
    return Intl.message(
      'Create backup success',
      name: 'create_backup_success',
      desc: '',
      args: [],
    );
  }

  /// `Create backup failed`
  String get create_backup_failed {
    return Intl.message(
      'Create backup failed',
      name: 'create_backup_failed',
      desc: '',
      args: [],
    );
  }

  /// `Select backup file`
  String get select_recover_file {
    return Intl.message(
      'Select backup file',
      name: 'select_recover_file',
      desc: '',
      args: [],
    );
  }

  /// `Recover backup success, please restart`
  String get recover_backup_success {
    return Intl.message(
      'Recover backup success, please restart',
      name: 'recover_backup_success',
      desc: '',
      args: [],
    );
  }

  /// `Recover backup failed`
  String get recover_backup_failed {
    return Intl.message(
      'Recover backup failed',
      name: 'recover_backup_failed',
      desc: '',
      args: [],
    );
  }

  /// `Dense Mode`
  String get enable_dense_favorites_mode {
    return Intl.message(
      'Dense Mode',
      name: 'enable_dense_favorites_mode',
      desc: '',
      args: [],
    );
  }

  /// `Display more favorite rooms at once`
  String get enable_dense_favorites_mode_subtitle {
    return Intl.message(
      'Display more favorite rooms at once',
      name: 'enable_dense_favorites_mode_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Play Background`
  String get enable_background_play {
    return Intl.message(
      'Play Background',
      name: 'enable_background_play',
      desc: '',
      args: [],
    );
  }

  /// `When leave app, allow video play background`
  String get enable_background_play_subtitle {
    return Intl.message(
      'When leave app, allow video play background',
      name: 'enable_background_play_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Keep Screen On`
  String get enable_screen_keep_on {
    return Intl.message(
      'Keep Screen On',
      name: 'enable_screen_keep_on',
      desc: '',
      args: [],
    );
  }

  /// `When in live play, keep screen on`
  String get enable_screen_keep_on_subtitle {
    return Intl.message(
      'When in live play, keep screen on',
      name: 'enable_screen_keep_on_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Auto Full Screen`
  String get enable_fullscreen_default {
    return Intl.message(
      'Auto Full Screen',
      name: 'enable_fullscreen_default',
      desc: '',
      args: [],
    );
  }

  /// `When enter live play, auto into full screen`
  String get enable_fullscreen_default_subtitle {
    return Intl.message(
      'When enter live play, auto into full screen',
      name: 'enable_fullscreen_default_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Float Video Ratio`
  String get float_overlay_ratio {
    return Intl.message(
      'Float Video Ratio',
      name: 'float_overlay_ratio',
      desc: '',
      args: [],
    );
  }

  /// `When using float window, ratio control the size`
  String get float_overlay_ratio_subtitle {
    return Intl.message(
      'When using float window, ratio control the size',
      name: 'float_overlay_ratio_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Platform Preference`
  String get prefer_platform {
    return Intl.message(
      'Platform Preference',
      name: 'prefer_platform',
      desc: '',
      args: [],
    );
  }

  /// `When enter popular/areas, first platform choice`
  String get prefer_platform_subtitle {
    return Intl.message(
      'When enter popular/areas, first platform choice',
      name: 'prefer_platform_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Resolution Preference`
  String get prefer_resolution {
    return Intl.message(
      'Resolution Preference',
      name: 'prefer_resolution',
      desc: '',
      args: [],
    );
  }

  /// `When enter live play, first resolution choice`
  String get prefer_resolution_subtitle {
    return Intl.message(
      'When enter live play, first resolution choice',
      name: 'prefer_resolution_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Auto Refresh Time`
  String get auto_refresh_time {
    return Intl.message(
      'Auto Refresh Time',
      name: 'auto_refresh_time',
      desc: '',
      args: [],
    );
  }

  /// `Auto refresh favorites rooms status`
  String get auto_refresh_time_subtitle {
    return Intl.message(
      'Auto refresh favorites rooms status',
      name: 'auto_refresh_time_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Auto close app`
  String get auto_shutdown_time_subtitle {
    return Intl.message(
      'Auto close app',
      name: 'auto_shutdown_time_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Auto ShutDown Time`
  String get auto_shutdown_time {
    return Intl.message(
      'Auto ShutDown Time',
      name: 'auto_shutdown_time',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `New Features`
  String get what_is_new {
    return Intl.message(
      'New Features',
      name: 'what_is_new',
      desc: '',
      args: [],
    );
  }

  /// `New version found: v{version}`
  String new_version_info(Object version) {
    return Intl.message(
      'New version found: v$version',
      name: 'new_version_info',
      desc: '',
      args: [version],
    );
  }

  /// `You are using the latest version.`
  String get no_new_version_info {
    return Intl.message(
      'You are using the latest version.',
      name: 'no_new_version_info',
      desc: '',
      args: [],
    );
  }

  /// `License`
  String get license {
    return Intl.message('License', name: 'license', desc: '', args: []);
  }

  /// `Project`
  String get project {
    return Intl.message('Project', name: 'project', desc: '', args: []);
  }

  /// `Donate Support`
  String get support_donate {
    return Intl.message(
      'Donate Support',
      name: 'support_donate',
      desc: '',
      args: [],
    );
  }

  /// `Issue Feedback`
  String get issue_feedback {
    return Intl.message(
      'Issue Feedback',
      name: 'issue_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Development`
  String get develop_progress {
    return Intl.message(
      'Development',
      name: 'develop_progress',
      desc: '',
      args: [],
    );
  }

  /// `Project Homepage`
  String get project_page {
    return Intl.message(
      'Project Homepage',
      name: 'project_page',
      desc: '',
      args: [],
    );
  }

  /// `Project Alert`
  String get project_alert {
    return Intl.message(
      'Project Alert',
      name: 'project_alert',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contact {
    return Intl.message('Contact', name: 'contact', desc: '', args: []);
  }

  /// `QQ Group`
  String get qq_group {
    return Intl.message('QQ Group', name: 'qq_group', desc: '', args: []);
  }

  /// `GroupNo.: {number}`
  String qq_group_num(Object number) {
    return Intl.message(
      'GroupNo.: $number',
      name: 'qq_group_num',
      desc: '',
      args: [number],
    );
  }

  /// `Telegram`
  String get telegram {
    return Intl.message('Telegram', name: 'telegram', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Github`
  String get github {
    return Intl.message('Github', name: 'github', desc: '', args: []);
  }

  /// `Help`
  String get help {
    return Intl.message('Help', name: 'help', desc: '', args: []);
  }

  /// `Timed Close`
  String get settings_timedclose_title {
    return Intl.message(
      'Timed Close',
      name: 'settings_timedclose_title',
      desc: '',
      args: [],
    );
  }

  /// `{time} Min`
  String timedclose_time(Object time) {
    return Intl.message(
      '$time Min',
      name: 'timedclose_time',
      desc: '',
      args: [time],
    );
  }

  /// `Video Fit`
  String get settings_videofit_title {
    return Intl.message(
      'Video Fit',
      name: 'settings_videofit_title',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get videofit_contain {
    return Intl.message(
      'Default',
      name: 'videofit_contain',
      desc: '',
      args: [],
    );
  }

  /// `Fill`
  String get videofit_fill {
    return Intl.message('Fill', name: 'videofit_fill', desc: '', args: []);
  }

  /// `Cover`
  String get videofit_cover {
    return Intl.message('Cover', name: 'videofit_cover', desc: '', args: []);
  }

  /// `AdaptWidth`
  String get videofit_fitwidth {
    return Intl.message(
      'AdaptWidth',
      name: 'videofit_fitwidth',
      desc: '',
      args: [],
    );
  }

  /// `AdaptHeight`
  String get videofit_fitheight {
    return Intl.message(
      'AdaptHeight',
      name: 'videofit_fitheight',
      desc: '',
      args: [],
    );
  }

  /// `Danmaku Setting`
  String get settings_danmaku_title {
    return Intl.message(
      'Danmaku Setting',
      name: 'settings_danmaku_title',
      desc: '',
      args: [],
    );
  }

  /// `Danmaku area`
  String get settings_danmaku_area {
    return Intl.message(
      'Danmaku area',
      name: 'settings_danmaku_area',
      desc: '',
      args: [],
    );
  }

  /// `Danmaku switch`
  String get settings_danmaku_open {
    return Intl.message(
      'Danmaku switch',
      name: 'settings_danmaku_open',
      desc: '',
      args: [],
    );
  }

  /// `Danmaku opacity`
  String get settings_danmaku_opacity {
    return Intl.message(
      'Danmaku opacity',
      name: 'settings_danmaku_opacity',
      desc: '',
      args: [],
    );
  }

  /// `Danmaku speed`
  String get settings_danmaku_speed {
    return Intl.message(
      'Danmaku speed',
      name: 'settings_danmaku_speed',
      desc: '',
      args: [],
    );
  }

  /// `Danmaku fontsize`
  String get settings_danmaku_fontsize {
    return Intl.message(
      'Danmaku fontsize',
      name: 'settings_danmaku_fontsize',
      desc: '',
      args: [],
    );
  }

  /// `Border width`
  String get settings_danmaku_fontBorder {
    return Intl.message(
      'Border width',
      name: 'settings_danmaku_fontBorder',
      desc: '',
      args: [],
    );
  }

  /// `Danmaku amount`
  String get settings_danmaku_amount {
    return Intl.message(
      'Danmaku amount',
      name: 'settings_danmaku_amount',
      desc: '',
      args: [],
    );
  }

  /// `Follow`
  String get follow {
    return Intl.message('Follow', name: 'follow', desc: '', args: []);
  }

  /// `Unfollow`
  String get unfollow {
    return Intl.message('Unfollow', name: 'unfollow', desc: '', args: []);
  }

  /// `Are you sure to unfollow {name}?`
  String unfollow_message(Object name) {
    return Intl.message(
      'Are you sure to unfollow $name?',
      name: 'unfollow_message',
      desc: '',
      args: [name],
    );
  }

  /// `Followed`
  String get followed {
    return Intl.message('Followed', name: 'followed', desc: '', args: []);
  }

  /// `Offline`
  String get offline {
    return Intl.message('Offline', name: 'offline', desc: '', args: []);
  }

  /// `{name} is offline.`
  String info_is_offline(Object name) {
    return Intl.message(
      '$name is offline.',
      name: 'info_is_offline',
      desc: '',
      args: [name],
    );
  }

  /// `{name} is replaying.`
  String info_is_replay(Object name) {
    return Intl.message(
      '$name is replaying.',
      name: 'info_is_replay',
      desc: '',
      args: [name],
    );
  }

  /// `Play by float window`
  String get float_window_play {
    return Intl.message(
      'Play by float window',
      name: 'float_window_play',
      desc: '',
      args: [],
    );
  }

  /// `DLNA Broadcast`
  String get dlan_button_info {
    return Intl.message(
      'DLNA Broadcast',
      name: 'dlan_button_info',
      desc: '',
      args: [],
    );
  }

  /// `DLNA`
  String get dlan_title {
    return Intl.message('DLNA', name: 'dlan_title', desc: '', args: []);
  }

  /// `DLNA device not found`
  String get dlan_device_not_found {
    return Intl.message(
      'DLNA device not found',
      name: 'dlan_device_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Play Video Failed`
  String get play_video_failed {
    return Intl.message(
      'Play Video Failed',
      name: 'play_video_failed',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `REPLAY`
  String get replay {
    return Intl.message('REPLAY', name: 'replay', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `No history here`
  String get empty_history {
    return Intl.message(
      'No history here',
      name: 'empty_history',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want to exit?`
  String get exit_app {
    return Intl.message(
      'Are you sure want to exit?',
      name: 'exit_app',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get exit_yes {
    return Intl.message('Yes', name: 'exit_yes', desc: '', args: []);
  }

  /// `No`
  String get exit_no {
    return Intl.message('No', name: 'exit_no', desc: '', args: []);
  }

  /// `Double click to exit`
  String get double_click_to_exit {
    return Intl.message(
      'Double click to exit',
      name: 'double_click_to_exit',
      desc: '',
      args: [],
    );
  }

  /// `Change videoPlayer`
  String get change_player {
    return Intl.message(
      'Change videoPlayer',
      name: 'change_player',
      desc: '',
      args: [],
    );
  }

  /// `Change videoPlayer of liveroom`
  String get change_player_subtitle {
    return Intl.message(
      'Change videoPlayer of liveroom',
      name: 'change_player_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `enable hardcodec`
  String get enable_codec {
    return Intl.message(
      'enable hardcodec',
      name: 'enable_codec',
      desc: '',
      args: [],
    );
  }

  /// `Video Player`
  String get video_player_title {
    return Intl.message(
      'Video Player',
      name: 'video_player_title',
      desc: '',
      args: [],
    );
  }

  /// `Select video player`
  String get video_player_subtitle {
    return Intl.message(
      'Select video player',
      name: 'video_player_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `MPV Player`
  String get mpv_player {
    return Intl.message('MPV Player', name: 'mpv_player', desc: '', args: []);
  }

  /// `Exo Player`
  String get exo_player {
    return Intl.message('Exo Player', name: 'exo_player', desc: '', args: []);
  }

  /// `min`
  String get minutes_unit {
    return Intl.message('min', name: 'minutes_unit', desc: '', args: []);
  }

  /// `Danmaku Filter`
  String get danmaku_filter_title {
    return Intl.message(
      'Danmaku Filter',
      name: 'danmaku_filter_title',
      desc: '',
      args: [],
    );
  }

  /// `Filter danmaku by custom keywords`
  String get danmaku_filter_subtitle {
    return Intl.message(
      'Filter danmaku by custom keywords',
      name: 'danmaku_filter_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Platform Settings`
  String get platform_settings_title {
    return Intl.message(
      'Platform Settings',
      name: 'platform_settings_title',
      desc: '',
      args: [],
    );
  }

  /// `Customize your favorite platforms`
  String get platform_settings_subtitle {
    return Intl.message(
      'Customize your favorite platforms',
      name: 'platform_settings_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Compatibility Mode`
  String get compatibility_mode {
    return Intl.message(
      'Compatibility Mode',
      name: 'compatibility_mode',
      desc: '',
      args: [],
    );
  }

  /// `Try enabling this if playback is choppy`
  String get compatibility_mode_subtitle {
    return Intl.message(
      'Try enabling this if playback is choppy',
      name: 'compatibility_mode_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Danmaku Display Area`
  String get danmaku_display_area {
    return Intl.message(
      'Danmaku Display Area',
      name: 'danmaku_display_area',
      desc: '',
      args: [],
    );
  }

  /// `Free & Open Source, Download from China: 123Pan`
  String get app_download_info {
    return Intl.message(
      'Free & Open Source, Download from China: 123Pan',
      name: 'app_download_info',
      desc: '',
      args: [],
    );
  }

  /// `Version History`
  String get version_history {
    return Intl.message(
      'Version History',
      name: 'version_history',
      desc: '',
      args: [],
    );
  }

  /// `Back to Bottom`
  String get back_to_bottom {
    return Intl.message(
      'Back to Bottom',
      name: 'back_to_bottom',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Timed Close`
  String get timed_close {
    return Intl.message('Timed Close', name: 'timed_close', desc: '', args: []);
  }

  /// `Fit`
  String get video_fit_contain {
    return Intl.message('Fit', name: 'video_fit_contain', desc: '', args: []);
  }

  /// `Fill`
  String get video_fit_cover {
    return Intl.message('Fill', name: 'video_fit_cover', desc: '', args: []);
  }

  /// `Stretch`
  String get video_fit_fill {
    return Intl.message('Stretch', name: 'video_fit_fill', desc: '', args: []);
  }

  /// `Aspect Ratio`
  String get aspect_ratio {
    return Intl.message(
      'Aspect Ratio',
      name: 'aspect_ratio',
      desc: '',
      args: [],
    );
  }

  /// `Quality`
  String get quality {
    return Intl.message('Quality', name: 'quality', desc: '', args: []);
  }

  /// `Link cannot be empty`
  String get link_cannot_be_empty {
    return Intl.message(
      'Link cannot be empty',
      name: 'link_cannot_be_empty',
      desc: '',
      args: [],
    );
  }

  /// `Cannot parse this link`
  String get cannot_parse_link {
    return Intl.message(
      'Cannot parse this link',
      name: 'cannot_parse_link',
      desc: '',
      args: [],
    );
  }

  /// `Select Quality`
  String get select_quality {
    return Intl.message(
      'Select Quality',
      name: 'select_quality',
      desc: '',
      args: [],
    );
  }

  /// `Select Stream`
  String get select_stream {
    return Intl.message(
      'Select Stream',
      name: 'select_stream',
      desc: '',
      args: [],
    );
  }

  /// `Link copied`
  String get link_copied {
    return Intl.message('Link copied', name: 'link_copied', desc: '', args: []);
  }

  /// `Failed to get stream link`
  String get failed_to_get_link {
    return Intl.message(
      'Failed to get stream link',
      name: 'failed_to_get_link',
      desc: '',
      args: [],
    );
  }

  /// `Toolbox`
  String get toolbox {
    return Intl.message('Toolbox', name: 'toolbox', desc: '', args: []);
  }

  /// `Room Jump`
  String get room_jump {
    return Intl.message('Room Jump', name: 'room_jump', desc: '', args: []);
  }

  /// `Link Jump`
  String get link_jump {
    return Intl.message('Link Jump', name: 'link_jump', desc: '', args: []);
  }

  /// `Get Stream Link`
  String get get_stream_link {
    return Intl.message(
      'Get Stream Link',
      name: 'get_stream_link',
      desc: '',
      args: [],
    );
  }

  /// `Support local files and network links`
  String get support_local_and_network {
    return Intl.message(
      'Support local files and network links',
      name: 'support_local_and_network',
      desc: '',
      args: [],
    );
  }

  /// `Network Import`
  String get network_import {
    return Intl.message(
      'Network Import',
      name: 'network_import',
      desc: '',
      args: [],
    );
  }

  /// `Import from Network`
  String get import_from_network {
    return Intl.message(
      'Import from Network',
      name: 'import_from_network',
      desc: '',
      args: [],
    );
  }

  /// `Local Import`
  String get local_import {
    return Intl.message(
      'Local Import',
      name: 'local_import',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Search Live`
  String get search_live {
    return Intl.message('Search Live', name: 'search_live', desc: '', args: []);
  }

  /// `Link Access`
  String get link_access {
    return Intl.message('Link Access', name: 'link_access', desc: '', args: []);
  }

  /// `Third-Party Auth`
  String get third_party_auth {
    return Intl.message(
      'Third-Party Auth',
      name: 'third_party_auth',
      desc: '',
      args: [],
    );
  }

  /// `Bilibili`
  String get platform_bilibili {
    return Intl.message(
      'Bilibili',
      name: 'platform_bilibili',
      desc: '',
      args: [],
    );
  }

  /// `Bili`
  String get platform_bilibili_short {
    return Intl.message(
      'Bili',
      name: 'platform_bilibili_short',
      desc: '',
      args: [],
    );
  }

  /// `Douyu`
  String get platform_douyu {
    return Intl.message('Douyu', name: 'platform_douyu', desc: '', args: []);
  }

  /// `Douyu`
  String get platform_douyu_short {
    return Intl.message(
      'Douyu',
      name: 'platform_douyu_short',
      desc: '',
      args: [],
    );
  }

  /// `Huya`
  String get platform_huya {
    return Intl.message('Huya', name: 'platform_huya', desc: '', args: []);
  }

  /// `Huya`
  String get platform_huya_short {
    return Intl.message(
      'Huya',
      name: 'platform_huya_short',
      desc: '',
      args: [],
    );
  }

  /// `Douyin`
  String get platform_douyin {
    return Intl.message('Douyin', name: 'platform_douyin', desc: '', args: []);
  }

  /// `Douyin`
  String get platform_douyin_short {
    return Intl.message(
      'Douyin',
      name: 'platform_douyin_short',
      desc: '',
      args: [],
    );
  }

  /// `Kuaishou`
  String get platform_kuaishou {
    return Intl.message(
      'Kuaishou',
      name: 'platform_kuaishou',
      desc: '',
      args: [],
    );
  }

  /// `NetEase CC`
  String get platform_cc {
    return Intl.message('NetEase CC', name: 'platform_cc', desc: '', args: []);
  }

  /// `Network`
  String get platform_iptv {
    return Intl.message('Network', name: 'platform_iptv', desc: '', args: []);
  }

  /// `All`
  String get platform_all {
    return Intl.message('All', name: 'platform_all', desc: '', args: []);
  }

  /// `Set Cookie`
  String get set_cookie {
    return Intl.message('Set Cookie', name: 'set_cookie', desc: '', args: []);
  }

  /// `Not Supported Yet`
  String get not_supported_yet {
    return Intl.message(
      'Not Supported Yet',
      name: 'not_supported_yet',
      desc: '',
      args: [],
    );
  }

  /// `Fullscreen`
  String get danmaku_area_fullscreen {
    return Intl.message(
      'Fullscreen',
      name: 'danmaku_area_fullscreen',
      desc: '',
      args: [],
    );
  }

  /// `2/3 Screen`
  String get danmaku_area_two_thirds {
    return Intl.message(
      '2/3 Screen',
      name: 'danmaku_area_two_thirds',
      desc: '',
      args: [],
    );
  }

  /// `1/3 Screen`
  String get danmaku_area_one_third {
    return Intl.message(
      '1/3 Screen',
      name: 'danmaku_area_one_third',
      desc: '',
      args: [],
    );
  }

  /// `Enter or paste live streaming links from Bilibili/Huya/Douyu/Douyin/CC/Kuaishou`
  String get toolbox_input_hint {
    return Intl.message(
      'Enter or paste live streaming links from Bilibili/Huya/Douyu/Douyin/CC/Kuaishou',
      name: 'toolbox_input_hint',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
