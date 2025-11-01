import 'dart:io';
import 'package:get/get.dart';
import 'package:pure_live/common/index.dart';
import 'package:pure_live/modules/backup/scan_page.dart';
import 'package:pure_live/plugins/file_recover_utils.dart';

class BackupPage extends StatefulWidget {
  const BackupPage({super.key});

  @override
  State<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  final settings = Get.find<SettingsService>();
  late String backupDirectory = settings.backupDirectory.value;
  late String m3uDirectory = settings.m3uDirectory.value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SectionTitle(title: S.of(context).backup_recover),
          ListTile(
            title: Text('WebDav'),
            subtitle: Text('备份到WebDav服务器'),
            onTap: () async {
              Get.toNamed(RoutePath.kWebDavPage);
            },
          ),
          if (Platform.isAndroid || Platform.isIOS)
            ListTile(
              title: const Text("同步TV数据"),
              subtitle: const Text("将数据远程同步到TV"),
              onTap: () async {
                Get.to(() => const ScanCodePage());
              },
            ),
          ListTile(
            title: Text(S.of(context).create_backup),
            subtitle: Text(S.of(context).create_backup_subtitle),
            onTap: () async {
              final selectedDirectory = await FileRecoverUtils().createBackup(backupDirectory);
              if (selectedDirectory != null) {
                setState(() {
                  backupDirectory = selectedDirectory;
                });
              }
            },
          ),
          ListTile(
            title: Text(S.of(context).recover_backup),
            subtitle: Text(S.of(context).recover_backup_subtitle),
            onTap: () => FileRecoverUtils().recoverBackup(),
          ),
          SectionTitle(title: S.of(context).auto_backup),
          ListTile(
            title: Text(S.of(context).backup_directory),
            subtitle: Text(backupDirectory),
            onTap: () async {
              final selectedDirectory = await FileRecoverUtils().selectBackupDirectory(backupDirectory);
              if (selectedDirectory != null) {
                setState(() {
                  backupDirectory = selectedDirectory;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
