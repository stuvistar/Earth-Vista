import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:earth_vista/myWidgets/widgets.dart';

const String mediaStackAPIKey = 'Your Media Stack API Key';

class SpaceNews extends StatefulWidget {
  const SpaceNews({Key? key}) : super(key: key);

  @override
  _SpaceNewsState createState() => _SpaceNewsState();
}

class _SpaceNewsState extends State<SpaceNews> {
  String url =
      "http://api.mediastack.com/v1/news?access_key=$mediaStackAPIKey&categories=health,sports&languages=en,-de&country=in,us";
  var news = [];

  // calling Space news
  getSpaceNews() async {
    http.Response response = await http.get(Uri.parse(url));

    Map result = jsonDecode(response.body);

    setState(() {
      news = result['data'];
    });
    // print(news[1]['image']);
  }

  @override
  void initState() {
    getSpaceNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Icon(
              Icons.public,
              color: Colors.green,
            ),
            Text(" Sports News"),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.notifications_none),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: news.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: [
                  if (news[index]['image'] == null) ...[
                    MyCustomListTile(
                      title: news[index]['title'],
                      author: news[index]['author'] ?? "Unknown",
                      publishedAt: news[index]['published_at'],
                      image: const Image(
                        image: AssetImage('images/newsAnchor.jpg'),
                      ),
                    ),
                  ] else ...[
                    MyCustomListTile(
                      title: news[index]['title'],
                      author: news[index]['author'] ?? "Unknown",
                      publishedAt: news[index]['published_at'],
                      image: Image(
                        image: NetworkImage(news[index]['image']),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
    );
  }
}

class MyCustomListTile extends StatelessWidget {
  const MyCustomListTile(
      {Key? key,
      required this.image,
      required this.title,
      required this.author,
      required this.publishedAt})
      : super(key: key);

  final Widget image;
  final String title;
  final String author;
  final String publishedAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: image,
          ),
          Expanded(
              flex: 3,
              child: NewsDescription(
                author: author,
                title: title,
                publiashedDate: publishedAt,
              ))
        ],
      ),
    );
  }
}

class NewsDescription extends StatelessWidget {
  const NewsDescription({
    Key? key,
    required this.title,
    required this.author,
    required this.publiashedDate,
  }) : super(key: key);

  final String title;
  final String author;
  final String publiashedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            "Author: $author",
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            'Published at: $publiashedDate',
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}
