import 'dart:convert';
import 'dart:io';

import 'package:eyeris/pages/location.dart';
import 'package:eyeris/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eyeris/pages/vars.dart' as vars;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongolib;

class wageSeekerList extends StatefulWidget {
  const wageSeekerList({Key? key}) : super(key: key);

  @override
  State<wageSeekerList> createState() => _wageSeekerListState();
}

class _wageSeekerListState extends State<wageSeekerList> {
  Future<Widget> getRecords() async {
    var db = await mongolib.Db.create(
        "mongodb+srv://eyeris:UHgKx1WwkMiPBMRJ@eyeris.yqu1m.mongodb.net/EYEris");
    await db.open();
    var allusers = await db.collection("workers").find().toList();
    List<Widget> items = [];
    int i;
    for (i = 0; i < allusers.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 5,
              )
            ],
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name : ' +
                  allusers[i]['fname'] +
                  ' ' +
                  allusers[i]['lname']),
              Text('Worker ID : ' + allusers[i]['empid']),
              Text('DOB : ' + allusers[i]['dob']),
              Text('Phone : ' + allusers[i]['phone']),
              Text('Pincode : ' + allusers[i]['pincode']),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Palette.myTheme),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () async {
                  final snackbar = ScaffoldMessenger.of(context);
                  try {
                    final ImagePicker picker = ImagePicker();
                    final XFile? photo =
                        await picker.pickImage(source: ImageSource.camera);
                    // await Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => LocationFind()));
                    if (photo != null) {
                      File imageFile = File(photo.path);
                      final imageBytes = imageFile.readAsBytesSync();
                      String imageEncoded = base64Encode(imageBytes);
                      print("----------------");
                      var uri = Uri.parse("${vars.url}/markattendance");
                      http.Response response = await http.post(
                        uri,
                        body: {"imageString": imageEncoded},
                      );

                      print("Response: " + response.body);
                      if (response.body == "0") {
                        snackbar.showSnackBar(const SnackBar(
                            content: Text("Attendance Successful")));
                      } else if (response.body == "1") {
                        snackbar.showSnackBar(
                            SnackBar(content: Text("Attendance Unsuccessful")));
                      }
                      print(response.body);
                    } else {
                      // snackbar
                      //     .showSnackBar(SnackBar(content: Text(response.body)));
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
                child: const Text("Take Attendance"),
              )
            ],
          ),
        ),
      );
    }
    db.close();
    return SingleChildScrollView(
      child: Column(
        children: items,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wage Seekers",
          style: TextStyle(color: Palette.myTheme),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Palette.myTheme,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home/wageSeekerList/wageSeeker');
              },
              icon: const Icon(
                Icons.add,
                color: Palette.myTheme,
              ))
        ],
      ),
      body: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data as Widget;
              return data;
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: getRecords(),
      ),
    );
  }
}
