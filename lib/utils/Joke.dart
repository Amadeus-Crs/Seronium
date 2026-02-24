import 'package:url_launcher/url_launcher.dart';

void JokeURL() async {
  final Uri url = Uri.parse('https://www.bilibili.com/video/BV1uT4y1P7CX/?spm_id_from=333.337.search-card.all.click&vd_source=dab663aa1aa5560cf1a48eba0f081dc5');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw '无法打开链接 $url';
  }
}