import 'dart:convert';
import 'dart:io';

import 'package:eyeris/pages/viewWorkerAttendance.dart';
import 'package:eyeris/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongolib;

class viewAttendance extends StatefulWidget {
  const viewAttendance({Key? key}) : super(key: key);

  @override
  State<viewAttendance> createState() => _viewAttendanceState();
}

class _viewAttendanceState extends State<viewAttendance> {
  List getCoordinates(String site) {
    List coord = [];
    if (site == "Bhubneswar") {
      //Bhubneshwar, odisha
      coord[0] = 20.15;
      coord[1] = 85.52;
    } else if (site == "Cuttack") {
      //Cuttack
      coord[0] = 20.28;
      coord[1] = 85.54;
    } else if (site == "Chatrapur") {
      //chatrapur
      coord[0] = 19.21;
      coord[1] = 85.03;
    } else {
      //Hyderabad
      coord[0] = 17.3850;
      coord[1] = 78.4867;
    }
    return coord;
  }

  String dropdownValue = "Site-Name";
  Future<Widget> getRecords() async {
    var db = await mongolib.Db.create(
        "mongodb+srv://eyeris:UHgKx1WwkMiPBMRJ@eyeris.yqu1m.mongodb.net/EYEris");
    await db.open();
    var allusers = await db.collection("workers").find().toList();
    List<Widget> items = [];
    int i;
    for (i = 0; i < allusers.length; i++) {
      items.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const viewWorkerAttendance())));
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
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
              ],
            ),
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
          return Center(
            child: Stack(
              children: const [
                Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                )),
                Positioned(
                    bottom: 0,
                    top: 60,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text("Loading..."),
                    ))
              ],
            ),
          );
        },
        future: getRecords(),
      ),
    );
  }
}
