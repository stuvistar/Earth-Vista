import 'package:flutter/material.dart';


class Preview extends StatefulWidget {
  final String imageLink;

  const Preview({Key? key, required this.imageLink}) : super(key: key);

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(widget.imageLink),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
