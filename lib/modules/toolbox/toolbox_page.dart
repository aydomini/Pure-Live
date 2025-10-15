import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:pure_live/modules/toolbox/toolbox_controller.dart';

class ToolBoxPage extends GetView<ToolBoxController> {
  const ToolBoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("工具箱"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          buildCard(
            context: context,
            child: ExpansionTile(
              title: const Text("直播间跳转"),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              initiallyExpanded: true,
              children: [
                TextField(
                  minLines: 3,
                  maxLines: 3,
                  controller: controller.roomJumpToController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "输入或粘贴哔哩哔哩直播/虎牙直播/斗鱼直播/抖音/网易cc/快手直播的链接",
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
                    label: const Text("链接跳转"),
                  ),
                ),
              ],
            ),
          ),
          buildCard(
            context: context,
            child: ExpansionTile(
              title: const Text("获取直链"),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              initiallyExpanded: false,
              children: [
                TextField(
                  minLines: 3,
                  maxLines: 3,
                  controller: controller.getUrlController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "输入或粘贴哔哩哔哩直播/虎牙直播/斗鱼直播/抖音/网易cc/快手直播的链接",
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
                    label: const Text("获取直链"),
                  ),
                ),
              ],
            ),
          ),
          buildCard(
            context: context,
            child: ExpansionTile(
              title: const Text("导入 M3U 直播源"),
              subtitle: const Text("支持本地文件和网络链接"),
              childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              initiallyExpanded: false,
              children: [
                // 网络导入部分
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "网络导入",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                    label: const Text("从网络导入"),
                  ),
                ),
                const Divider(height: 24.0),
                // 本地导入部分
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "本地导入",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
          ),
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
