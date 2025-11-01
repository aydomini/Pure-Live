import 'package:get/get.dart';
import 'package:pure_live/common/index.dart';
import 'package:pure_live/modules/account/account_controller.dart';
import 'package:pure_live/common/services/bilibili_account_service.dart';

class AccountPage extends GetView<AccountController> {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).third_party_auth),
      ),
      body: ListView(
        children: [
          Obx(
            () => ListTile(
              leading: Image.asset(
                'assets/images/bilibili_2.png',
                width: 36,
                height: 36,
              ),
              title: Text(S.of(context).platform_bilibili),
              subtitle: Text(BiliBiliAccountService.instance.name.value),
              trailing: BiliBiliAccountService.instance.logined.value
                  ? const Icon(Icons.logout)
                  : const Icon(Icons.chevron_right),
              onTap: controller.bilibiliTap,
            ),
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/huya.png',
              width: 36,
              height: 36,
            ),
            title: Text(S.of(context).platform_huya),
            subtitle: Text(S.of(context).set_cookie),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Get.toNamed(RoutePath.kHuyaCookie);
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/douyu.png',
              width: 36,
              height: 36,
            ),
            title: Text(S.of(context).platform_douyu),
            subtitle: Text(S.of(context).not_supported_yet),
            enabled: false,
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/douyin.png',
              width: 36,
              height: 36,
            ),
            title: Text(S.of(context).platform_douyin),
            subtitle: Text(S.of(context).not_supported_yet),
            enabled: false,
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
