import 'package:get/get.dart';
import 'package:pure_live/common/index.dart';
import 'package:remixicon/remixicon.dart';
import 'package:pure_live/modules/toolbox/toolbox_controller.dart';

class ToolBoxPage extends GetView<ToolBoxController> {
  const ToolBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).toolbox),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          buildCard(
            context: context,
            child: ExpansionTile(
              title: Text(S.of(context).room_jump),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              initiallyExpanded: true,
              children: [
                TextField(
                  minLines: 3,
                  maxLines: 3,
                  controller: controller.roomJumpToController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: S.of(context).toolbox_input_hint,
                    contentPadding: const EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withValues(alpha: .2),
                      ),
                    ),
                  ),
                  onSubmitted: controller.jumpToRoom,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 4.0),
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () {
                      controller.jumpToRoom(controller.roomJumpToController.text);
                    },
                    icon: const Icon(Remix.play_circle_line),
                    label: Text(S.of(context).link_jump),
                  ),
                ),
              ],
            ),
          ),
          buildCard(
            context: context,
            child: ExpansionTile(
              title: Text(S.of(context).get_stream_link),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              initiallyExpanded: false,
              children: [
                TextField(
                  minLines: 3,
                  maxLines: 3,
                  controller: controller.getUrlController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: S.of(context).toolbox_input_hint,
                    contentPadding: const EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withValues(alpha: .2),
                      ),
                    ),
                  ),
                  onSubmitted: controller.getPlayUrl,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 4.0),
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () {
                      controller.getPlayUrl(controller.getUrlController.text);
                    },
                    icon: const Icon(Remix.link),
                    label: Text(S.of(context).get_stream_link),
                  ),
                ),
              ],
            ),
          ),
          // 🔧 已隐藏：导入 M3U 直播源功能（根据用户需求）
          /* buildCard(
            context: context,
            child: ExpansionTile(
              title: const Text("导入 M3U 直播源"),
              subtitle: Text(S.of(context).support_local_and_network),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              initiallyExpanded: false,
              children: [
                // 网络导入部分
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      S.of(context).network_import,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                TextField(
                  controller: controller.m3uUrlController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "输入 M3U 文件的 URL（如：https://example.com/list.m3u）",
                    contentPadding: const EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withValues(alpha: .2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  controller: controller.m3uNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "输入自定义名称（如：我的直播源）",
                    contentPadding: const EdgeInsets.all(12.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withValues(alpha: .2),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12.0),
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: controller.importM3uFromUrl,
                    icon: const Icon(Remix.download_cloud_line),
                    label: Text(S.of(context).import_from_network),
                  ),
                ),
                const Divider(height: 24.0),
                // 本地导入部分
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      S.of(context).local_import,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 4.0),
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: controller.importM3uFromLocal,
                    icon: const Icon(Remix.folder_open_line),
                    label: const Text("选择本地 M3U 文件"),
                  ),
                ),
              ],
            ),
          ), */
        ],
      ),
    );
  }

  Widget buildCard({required BuildContext context, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        boxShadow: Get.isDarkMode
            ? []
            : [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.grey.withValues(alpha: .2),
                )
              ],
      ),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: child,
      ),
    );
  }
}
