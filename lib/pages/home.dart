import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:eyeris/pages/forms/stateGov.dart';
import 'package:eyeris/pages/lists/stateGovList.dart';
import 'package:eyeris/pages/login.dart';
import 'package:eyeris/pages/vars.dart' as vars;
import 'package:eyeris/pages/widgets.dart';
import 'package:eyeris/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () async {
                final snackbar = ScaffoldMessenger.of(context);
                try {
                  String test1 = "passing arguments....";
                  var code = """import scipy
import numpy as np
import cv2
import subprocess
from urllib.request import urlopen
req = urlopen('https://en.wikipedia.org/wiki/Image')
arr = np.asarray(bytearray(req.read()), dtype=np.uint8)
img = cv2.imdecode(arr,-1)
print(arr)
print("$test1")
""";
                  // final result = await Chaquopy.executeCode(code);
                  // print("-------------");
                  // print(result['textOutputOrError']);
                  // print("----------");
                  final ImagePicker picker = ImagePicker();
                  final XFile? photo =
                      await picker.pickImage(source: ImageSource.camera);
                  if (photo != null) {
                    File imageFile = File(photo.path);
                    final imageBytes = imageFile.readAsBytesSync();
                    String imageEncoded = base64Encode(imageBytes);
                    print("----------------");

                    // Directory tempDir =
                    //     await getApplicationDocumentsDirectory();
                    // String appDocPath = tempDir.path;
                    // final fileName = basename(photo.path);
                    // final File localImage =
                    //     await imageFile.copy("$appDocPath/$fileName");
                    // print("appDocPath:$appDocPath/$fileName");
                    // print("---------------------------");
                    // var res =
                    //     await http.get(Uri.parse("http://localhost:5000/"));
                    // print(res.body);
                    var uri = Uri.parse("${vars.url}/registerImage");
                    var response = await http.post(
                      uri,
                      body: {"imageString": imageEncoded},
                    );
                    print(response.body);
                  } else {
                    snackbar.showSnackBar(const SnackBar(
                        content:
                            Text("Unable to get photo. Please try again")));
                  }
                } catch (e) {
                  print(e);
                  snackbar.showSnackBar(
                    const SnackBar(
                      content: Text("Error Occured"),
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.transparent,
              )),
          IconButton(
              onPressed: () async {
                const storage = FlutterSecureStorage();
                final navigator = Navigator.of(context);
                await storage.deleteAll();
                navigator.pop();
                navigator.push(MaterialPageRoute(
                  builder: (context) => const Login(),
                ));
              },
              icon: const Icon(Icons.power_settings_new))
        ],
        backgroundColor: Colors.white,
        foregroundColor: Palette.myTheme,
        title: const Text("EYEris"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // const Text(
              //   "Create Accounts",
              //   style: TextStyle(fontSize: 18),
              // ),
              int.parse(vars.level!) < 2
                  ? homeMaterialButton(() {
                      Navigator.pushNamed(context, '/home/stateGovList');
                    }, "State Government", MediaQuery.of(context).size.width)
                  : const SizedBox(
                      height: 0,
                    ),
              int.parse(vars.level!) < 3
                  ? homeMaterialButton(() {
                      Navigator.pushNamed(context, '/home/distProgCordList');
                    }, "District Programme Coordinator",
                      MediaQuery.of(context).size.width)
                  : const SizedBox(
                      height: 0,
                    ),
              int.parse(vars.level!) < 4
                  ? homeMaterialButton(() {
                      Navigator.pushNamed(context, '/home/progOfficerList');
                    }, "Programme Officer", MediaQuery.of(context).size.width)
                  : const SizedBox(
                      height: 0,
                    ),
              int.parse(vars.level!) < 5
                  ? homeMaterialButton(() {
                      Navigator.pushNamed(context, '/home/priList');
                    }, "Panchayati Raj Institution",
                      MediaQuery.of(context).size.width)
                  : const SizedBox(
                      height: 0,
                    ),
              homeMaterialButton(() {
                Navigator.pushNamed(context, '/home/wageSeekerList');
              }, "Wage Seeker", MediaQuery.of(context).size.width),
            ],
          ),
        ),
      ),
    );
  }
}
