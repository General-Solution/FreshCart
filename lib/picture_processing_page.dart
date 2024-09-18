import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:tflite_web/tflite_web.dart';
import 'dart:io';
import 'dart:ui';
import 'dart:ui_web';
import 'package:image/image.dart' as img;

class PictureProcessingPage extends StatefulWidget {
  const PictureProcessingPage(
      {super.key, required this.title, required this.imageFile});
  final String title;
  final XFile imageFile;

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
            Center(child: Image.network(widget.imageFile.path)),
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

Future<void> processImage(XFile imageFile) async {
    print('Initializing tflite-web');
    await TFLiteWeb.initialize();
    print('Loading Model');
    final loadedModel = await TFLiteModel.fromUrl('../lib/assets/nn_model.tflite');
    print('Model Loaded');
    print('Analyzing Image');
    final imageData = await imageFile.readAsBytes();
    final image = img.decodeImage(imageData);
    final imageInput = img.copyResize(
      image!,
      width: 300,
      height: 300,
    );
    final imageMatrix = List.generate(
      imageInput.height,
      (y) => List.generate(
        imageInput.width,
        (x) {
          final pixel = imageInput.getPixel(x, y);
          return [pixel.r, pixel.g, pixel.b];
        },
      ),
    );
    final output = _runInference(imageMatrix, loadedModel);
  }

List<List<Object>> _runInference(
    List<List<List<num>>> imageMatrix,
    TFLiteModel loadedModel, 
  ) {
    print('Running inference...');

    // Set input tensor [1, 300, 300, 3]
    
    final input = createTensor(
      imageMatrix,
      shape: [300, 300, 3],
      type: TFLiteDataType.int32,
    );

    final output = loadedModel.predict(input);
    print(output);
    return output.values.toList();
  }