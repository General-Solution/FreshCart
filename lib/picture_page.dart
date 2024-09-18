import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'picture_processing_page.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PicturePage extends StatefulWidget {
  const PicturePage({super.key});

  @override
  State<PicturePage> createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TakePicture(),
            AddPicture()
          ]
        ),
      );
  }
}

class TakePicture extends StatelessWidget {

  const TakePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return MaterialButton(
      color: theme.colorScheme.primary, 
      child: Text('Take a Picture', style: textStyle),
      onPressed: () => {_pickImageFromSource(source: ImageSource.camera, context: context)},
    );
  }


}

class AddPicture extends StatelessWidget {
  const AddPicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return MaterialButton(
      color: theme.colorScheme.primary, 
      child: Text('Or Add a Picture', style: textStyle),
      onPressed: () => {_pickImageFromSource(source: ImageSource.gallery, context: context)},
    );
  }
}

Future _pickImageFromSource({required ImageSource source, required BuildContext context}) async {
  final navigator = Navigator.of(context);
  final pickedFile = await ImagePicker().pickImage(source: source);
  if (pickedFile != null){
    if (kIsWeb) {
      print("Picture analysis not yet available on web.");
    }
    final tempDir = await getTemporaryDirectory();
    File imageFile = File('${tempDir.path}/sth.jpg');
    final bytes = await pickedFile.readAsBytes();
    await imageFile.writeAsBytes(bytes);
    navigator.push(
      MaterialPageRoute(builder: (context) => PictureProcessingPage(title: "Picture Processing Page", imageFile: imageFile)),
    );
  }
}