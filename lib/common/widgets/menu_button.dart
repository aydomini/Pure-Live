import 'package:get/get.dart';
import 'package:pure_live/common/index.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  final menuRoutes = const [
    RoutePath.kSettingsAccount,
    RoutePath.kSettings,
    RoutePath.kAbout,
    RoutePath.kHistory,
  ];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: 'menu',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      offset: const Offset(12, 0),
      position: PopupMenuPosition.under,
      icon: const Icon(Icons.menu_rounded),
      onSelected: (int index) {
        Get.toNamed(menuRoutes[index]);
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: MenuListTile(
            leading: const Icon(Icons.assignment_ind_sharp),
            text: S.of(context).third_party_auth,
          ),
        ),
        PopupMenuItem(
          value: 1,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: MenuListTile(
            leading: const Icon(Icons.settings_rounded),
            text: S.of(context).settings_title,
          ),
        ),
        PopupMenuItem(
          value: 2,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: MenuListTile(
            leading: const Icon(Icons.info_rounded),
            text: S.of(context).about,
          ),
        ),
        PopupMenuItem(
          value: 3,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: MenuListTile(
            leading: const Icon(Icons.history),
            text: S.of(context).history,
          ),
        ),
      ],
    );
  }
}

class MenuListTile extends StatelessWidget {
  final Widget? leading;
  final String text;
  final Widget? trailing;

  const MenuListTile({
    super.key,
    required this.leading,
    required this.text,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: 12),
        ],
        Text(
          text,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        if (trailing != null) ...[
          const SizedBox(width: 24),
          trailing!,
        ],
      ],
    );
  }
}
