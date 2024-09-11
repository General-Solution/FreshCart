import 'package:flutter/material.dart';

class PictureProcessingPage extends StatelessWidget {
  const PictureProcessingPage(
      {super.key, required this.title, required this.image});
  final String title;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            image,
            Center(
              child: Container(
                width: 200.0,
                height: 120.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularProgressIndicator(),
                    Text("Analyzing Your Photo"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
