import 'package:flutter/material.dart';

class ReusableWidgets {
  static getAppBar(String title) {
    return AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.public,
              color: Colors.green,
            ),
            Text("  $title"),
          ],
        ),
        leading: Row(
          children: const[
             Icon(Icons.menu),
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
      )
      ;
  }
}