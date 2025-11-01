import 'site/huya_site.dart';
import 'package:get/get.dart';
import 'site/douyu_site.dart';
import 'site/douyin_site.dart';
import 'interface/live_site.dart';
import 'package:pure_live/core/sign/douyu.dart';
import 'package:pure_live/core/sign/douyin.dart';
import 'package:pure_live/core/site/cc_site.dart';
import 'package:pure_live/core/site/iptv_site.dart';
import 'package:pure_live/core/site/bilibili_site.dart';
import 'package:pure_live/core/site/kuaishou_site.dart';
import 'package:pure_live/common/index.dart';

class Sites {
  static const String allSite = "all";
  static const String bilibiliSite = "bilibili";
  static const String douyuSite = "douyu";
  static const String huyaSite = "huya";
  static const String douyinSite = "douyin";
  static const String kuaishouSite = "kuaishou";
  static const String ccSite = "cc";
  static const String iptvSite = "iptv";
  static List<Site> supportSites = [
    Site(id: "bilibili", nameKey: "platform_bilibili_short", logo: "assets/images/bilibili_2.png", liveSite: BiliBiliSite()),
    Site(
      id: "douyu",
      nameKey: "platform_douyu_short",
      logo: "assets/images/douyu.png",
      liveSite: DouyuSite()..setDouyuSignFunction(DouyuSign.getSign),
    ),
    Site(id: "huya", nameKey: "platform_huya_short", logo: "assets/images/huya.png", liveSite: HuyaSite()),
    Site(
      id: "douyin",
      nameKey: "platform_douyin_short",
      logo: "assets/images/douyin.png",
      liveSite: DouyinSite()
        ..setAbogusUrlFunction(DouyinSign.getAbogusUrl)
        ..setSignatureFunction(DouyinSign.getSignature),
    ),
    Site(id: "kuaishou", nameKey: "platform_kuaishou", logo: "assets/images/kuaishou.png", liveSite: KuaishowSite()),
    Site(id: "cc", nameKey: "platform_cc", logo: "assets/images/cc.png", liveSite: CCSite()),
    Site(id: "iptv", nameKey: "platform_iptv", logo: "assets/images/logo.png", liveSite: IptvSite()),
  ];

  static Site of(String id) {
    return supportSites.firstWhere((e) => id == e.id);
  }

  List<Site> availableSites({bool containsAll = false}) {
    final SettingsService settingsService = Get.find<SettingsService>();
    if (containsAll) {
      var result = supportSites.where((element) => settingsService.hotAreasList.value.contains(element.id)).toList();
      result.insert(0, Site(id: "all", nameKey: "platform_all", logo: "assets/images/all.png", liveSite: LiveSite()));
      return result;
    }
    return supportSites.where((element) => settingsService.hotAreasList.value.contains(element.id)).toList();
  }
}

class Site {
  final String id;
  final String nameKey; // 翻译键，用于国际化
  final String logo;
  final LiveSite liveSite;

  Site({required this.id, required this.liveSite, required this.logo, required this.nameKey});

  // 获取本地化名称
  String get name {
    // 使用 Get.context 获取当前 context
    final context = Get.context;
    if (context == null) {
      // 如果没有 context，使用默认名称（中文）
      return _getDefaultName();
    }
    return _getLocalizedName(context);
  }

  String _getLocalizedName(BuildContext context) {
    switch (nameKey) {
      case 'platform_bilibili_short':
        return S.of(context).platform_bilibili_short;
      case 'platform_douyu_short':
        return S.of(context).platform_douyu_short;
      case 'platform_huya_short':
        return S.of(context).platform_huya_short;
      case 'platform_douyin_short':
        return S.of(context).platform_douyin_short;
      case 'platform_kuaishou':
        return S.of(context).platform_kuaishou;
      case 'platform_cc':
        return S.of(context).platform_cc;
      case 'platform_iptv':
        return S.of(context).platform_iptv;
      case 'platform_all':
        return S.of(context).platform_all;
      default:
        return nameKey;
    }
  }

  String _getDefaultName() {
    switch (nameKey) {
      case 'platform_bilibili_short':
        return '哔哩';
      case 'platform_douyu_short':
        return '斗鱼';
      case 'platform_huya_short':
        return '虎牙';
      case 'platform_douyin_short':
        return '抖音';
      case 'platform_kuaishou':
        return '快手';
      case 'platform_cc':
        return '网易CC';
      case 'platform_iptv':
        return '网络';
      case 'platform_all':
        return '全部';
      default:
        return nameKey;
    }
  }
}
