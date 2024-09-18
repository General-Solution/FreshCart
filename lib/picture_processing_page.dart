import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'dart:io';
import 'dart:ui';

class PictureProcessingPage extends StatefulWidget {
  const PictureProcessingPage(
      {super.key, required this.title, required this.imageFile});
  final String title;
  final File imageFile;

  @override
  State<PictureProcessingPage> createState() => _PictureProcessingPageState();
}

class _PictureProcessingPageState extends State<PictureProcessingPage> {
  @override
  void initState() {
    super.initState();
    processImage(widget.imageFile); // getting prefs etc.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Center(child: Image.file(widget.imageFile)),
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

Future<void> processImage(File image) async {
    print('Analysing Image');
    var file = image.toString();
    var recognitions = await Tflite.detectObjectOnImage(
      path: file,       // required
      model: "YOLO",      
      imageMean: 0.0,       
      imageStd: 255.0,      
      threshold: 0.3,       // defaults to 0.1
      asynch: true          // defaults to true
    );
    print(recognitions);
  }