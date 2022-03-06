import 'package:earth_vista/screens/preview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:earth_vista/myWidgets/widgets.dart';

const String pexelAPIKey = 'Your Pexels API Key';

class Wallpapers extends StatefulWidget {
  const Wallpapers({Key? key}) : super(key: key);

  @override
  _WallpapersState createState() => _WallpapersState();
}

class _WallpapersState extends State<Wallpapers> {
  List images = [];
  int pg = 1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  // Calling API
  void getData() async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=wildlife&per_page=80?"),
        headers: {
          'Authorization':
              pexelAPIKey
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result["photos"];
      });
    });
  }

  // for getting more images
  loadmore() async {
    setState(() {
      pg++;
    });

    String url =
        "https://api.pexels.com/v1/search?query=wildlife&per_page=80&page=" +
            pg.toString();
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          pexelAPIKey
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
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
            Text(" Wildlife Photography"),
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
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2,
                      crossAxisCount: 3,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Preview(
                                      imageLink: images[index]['src']
                                          ['large2x'],
                                    )));
                      },
                      child: Container(
                          color: Colors.white,
                          child: Image.network(
                            images[index]['src']['tiny'],
                            fit: BoxFit.cover,
                          )),
                    );
                  }),
            ),
          ),
          InkWell(
            onTap: () {
              loadmore();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                child: Text(
                  'Load More',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
