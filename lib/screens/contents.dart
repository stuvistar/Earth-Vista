
import 'package:earth_vista/screens/spacenews.dart';
import 'package:earth_vista/screens/wallpapers.dart';
import 'package:flutter/material.dart';

class Contents extends StatelessWidget {
  const Contents({Key? key}) : super(key: key);

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
            Text("  Contents"),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              MyContentsCard(
                imageLocation: "images/lion.jpg",
                titleOfCard: "Wildlife Photography",
                widgetScreen: Wallpapers(),
              ),
              MyContentsCard(
                imageLocation: "images/sportsNews.jpg",
                titleOfCard: "Sports News",
                widgetScreen: SpaceNews(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyContentsCard extends StatelessWidget {
  const MyContentsCard(
      {Key? key,
      required this.imageLocation,
      required this.titleOfCard,
      required this.widgetScreen})
      : super(key: key);

  final String imageLocation;
  final String titleOfCard;
  final Widget widgetScreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: Container(
        height: 300.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(33.0),
          border: Border.all(width: 2.0, color: Colors.white),
          boxShadow: const [
            BoxShadow(
              color: Colors.white12,
              blurRadius: 20.0,
            ),
          ],
          image: DecorationImage(
            opacity: 120.0,
            image: AssetImage(imageLocation),
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
        ),
        child: Center(
          child: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => widgetScreen));
            },
            child: Text(
              titleOfCard,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}



