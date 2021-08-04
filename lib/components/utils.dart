import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future openLink({required String url}) => _launchUrl(url);

  static Future _launchUrl(String url) async {
    await launch(url);
  }

  static Future openEmail({
    required String toEmail,
    required String subject,
    required String body,
  }) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';
    await _launchUrl(url);
  }

  static void openPhoneCall({required String phoneNumber}) async {
    final url = 'tel:$phoneNumber';
    await _launchUrl(url);
  }
}