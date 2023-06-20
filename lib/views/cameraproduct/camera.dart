
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _takePicture,
          child: const Icon(Icons.photo_camera),
        ),
      ),
    );
  }

  void _takePicture() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
      });

      _processImage();
    }
  }

  void _processImage() async {
    const productUrl = 'https://www.google.com/search?q=jumia&oq=jumia&aqs=chrome.0.0i271j46i131i199i433i465i512j69i64j0i131i433i512j0i131i433i457i512j0i402i650j0i512j5.1713j0j7&sourceid=chrome&ie=UTF-8'; // Replace with the actual product URL

    // ignore: deprecated_member_use
    if (await canLaunch(productUrl)) {
      // ignore: deprecated_member_use
      await launch(productUrl);
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Could not launch URL.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
