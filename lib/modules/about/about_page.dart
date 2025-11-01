import 'package:pure_live/common/index.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          SectionTitle(title: S.of(context).about),
          ListTile(
            title: Text(S.of(context).version),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'v${VersionUtil.version}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  VersionUtil.latestUpdateLog,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          SectionTitle(title: S.of(context).project),
          ListTile(
            title: Text(S.of(context).project_alert),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).app_legalese),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      launchUrl(
                        Uri.parse(S.of(context).repository_url),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Text(
                      S.of(context).repository_url,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
