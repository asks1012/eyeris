import 'dart:io';
import 'package:camera/camera.dart';
import 'package:eyeris/pages/location.dart';
import 'package:flutter/material.dart';

class Camera extends StatefulWidget {
  const Camera({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<Camera> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.ultraHigh,
    );

    _initializeControllerFuture = _controller.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take Eye Picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            // LocationFind().locationTracking();
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => LocationFind()));
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                ),
              ),
            );
            dispose();
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Display the Picture'),
            automaticallyImplyLeading: false),
        body: Column(
          children: [
            Image.file(
              File(imagePath),
              width: 355,
              height: 600,
            ),
            Row(
              children: [
                FloatingActionButton.extended(
                    heroTag: "Retake-btn",
                    onPressed: () async {
                      final cameras = await availableCameras();

                      final firstCamera = cameras.first;

                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Camera(
                                camera: firstCamera,
                              )));
                    },
                    backgroundColor: Colors.blue,
                    label: const Text("Retake"),
                    icon: const Icon(Icons.camera)),
                FloatingActionButton.extended(
                    heroTag: "Done-btn",
                    onPressed: () async {
                      print("THis is my image path: " + imagePath);
                      // SaveImage(imagePath);
                      Navigator.pushNamed(context, '/home');
                    },
                    backgroundColor: Colors.blue,
                    label: const Text("Done"),
                    icon: const Icon(Icons.thumb_up))
              ],
            ),
          ],
        ));
  }
}
