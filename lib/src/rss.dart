import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RSSDemo extends StatefulWidget {
  //
  RSSDemo() : super();

  final String title = 'RSS Feed Demo';

  @override
  RSSDemoState createState() => RSSDemoState();
}

class RSSDemoState extends State<RSSDemo> {
  //
  static const String FEED_URL =
      'https://www.alkhaleej.ae/section/1111/rss.xml';
  //'https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss';
  RssFeed? _feed;
  String? _title;
  static const String loadingFeedMsg = 'Loading Feed...';
  static const String feedLoadErrorMsg = 'Error Loading Feed.';
  static const String feedOpenErrorMsg = 'Error Opening Feed.';
  static const String placeholderImg = 'images/no-image.png';
  GlobalKey<RefreshIndicatorState>? _refreshKey;

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
      return;
    }
    updateTitle(feedOpenErrorMsg);
  }

  load() async {
    updateTitle(loadingFeedMsg);
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        updateTitle(feedLoadErrorMsg);
        return;
      }
      updateFeed(result);
      updateTitle(_feed?.title);
    });
  }

  Future<RssFeed?> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(FEED_URL));

      //print('hhhhhhhhh ${response.body}');
      return RssFeed.parse(response.body);
    } catch (e) {
      //
    }
    return null;
  }

  Future<RssFeed?> loadFeed2() async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(
          'https://www.alkhaleej.ae/2022-03-28/%D8%AE%D9%84%D9%8A%D9%81%D8%A9-%D9%8A%D8%A3%D9%85%D8%B1-%D8%A8%D8%A7%D9%84%D8%A5%D9%81%D8%B1%D8%A7%D8%AC-%D8%B9%D9%86-540-%D9%86%D8%B2%D9%8A%D9%84%D8%A7%D9%8B-%D8%A8%D9%85%D9%86%D8%A7%D8%B3%D8%A8%D8%A9-%D8%AD%D9%84%D9%88%D9%84-%D8%B4%D9%87%D8%B1-%D8%B1%D9%85%D8%B6%D8%A7%D9%86/%D8%A3%D8%AE%D8%A8%D8%A7%D8%B1-%D9%85%D9%86-%D8%A7%D9%84%D8%A5%D9%85%D8%A7%D8%B1%D8%A7%D8%AA/%D8%A3%D8%AE%D8%A8%D8%A7%D8%B1-%D8%A7%D9%84%D8%AF%D8%A7%D8%B1'));

      print('hhhhhhhhh ${response.body}');
      return RssFeed.parse(response.body);
    } catch (e) {
      //
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    load();
    loadFeed2();
  }

  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subtitle(subTitle) {
    return Text(
      subTitle,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  thumbnail(imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: CachedNetworkImage(
        placeholder: (context, url) => Image.asset(placeholderImg),
        imageUrl: imageUrl,
        height: 130,
        width: 120,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }

  rightIcon() {
    return const Icon(
      Icons.keyboard_arrow_left,
      color: Colors.grey,
      size: 30.0,
    );
  }

  list() {
    return ListView.builder(
      itemCount: _feed?.items?.length,
      //itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed?.items![index];
        return ListTile(
          title: title(item?.title),
          //subtitle: subtitle(item?.pubDate),
          leading: thumbnail(item?.enclosure?.url),
          trailing: rightIcon(),
          contentPadding: EdgeInsets.all(5.0),
          onTap: () => openFeed(item!.link.toString()),
        );
      },
    );
  }

  isFeedEmpty() {
    return null == _feed || null == _feed?.items;
  }

  body() {
    return isFeedEmpty()
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: list(),
            onRefresh: () => load(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title!),
      ),
      body: body(),
    );
  }
}
