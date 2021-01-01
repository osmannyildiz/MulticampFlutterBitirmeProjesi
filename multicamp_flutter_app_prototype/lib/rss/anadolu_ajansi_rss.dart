import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class AnadoluAjansiRss {
  static const endpoint = "https://www.aa.com.tr/tr/rss/default?cat=guncel";

  static Future<RssFeed> getFeed() async {
    final response = await http.get(endpoint);
    final feed = RssFeed.parse(response.body);
    return feed;
  }
}
