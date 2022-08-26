import 'dart:math';

import 'package:eyeris/pages/location.dart';
import 'package:eyeris/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongolib;

class viewWorkerAttendance extends StatefulWidget {
  const viewWorkerAttendance({Key? key}) : super(key: key);

  @override
  State<viewWorkerAttendance> createState() => _viewWorkerAttendanceState();
}

class _viewWorkerAttendanceState extends State<viewWorkerAttendance> {
  Widget getRecords() {
    List<Widget> items = [];
    int i;
    for (i = 1; i <= 4; i++) {
      items.add(Row(children: [
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.green),
          height: 30,
          width: 30,
          child: Center(
              child: Text(
            (i * 1).toString(),
            style: TextStyle(color: Colors.white),
          )),
        ),
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.green),
          height: 30,
          width: 30,
          child: Center(
              child: Text(
            (i * 2).toString(),
            style: TextStyle(color: Colors.white),
          )),
        ),
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.green),
          height: 30,
          width: 30,
          child: Center(
              child: Text(
            (i * 3).toString(),
            style: TextStyle(color: Colors.white),
          )),
        ),
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.green),
          height: 30,
          width: 30,
          child: Center(
              child: Text(
            (i * 4).toString(),
            style: TextStyle(color: Colors.white),
          )),
        ),
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.green),
          height: 30,
          width: 30,
          child: Center(
              child: Text(
            (i * 5).toString(),
            style: TextStyle(color: Colors.white),
          )),
        ),
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.green),
          height: 30,
          width: 30,
          child: Center(
              child: Text(
            (i * 6).toString(),
            style: TextStyle(color: Colors.white),
          )),
        ),
        Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.green),
          height: 30,
          width: 30,
          child: Center(
              child: Text(
            (i * 7).toString(),
            style: TextStyle(color: Colors.white),
          )),
        ),
      ]));
      if (i == 4) {
        items.add(
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: Colors.red),
                height: 30,
                width: 30,
                child: Center(
                    child: Text(
                  (29).toString(),
                  style: TextStyle(color: Colors.white),
                )),
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: Colors.red),
                height: 30,
                width: 30,
                child: Center(
                    child: Text(
                  (30).toString(),
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ],
          ),
        );
      }
    }

    return Column(
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ID : WS4432976581",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(""),
              Text("Location : Nacharam,567890"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          "Nov",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        )
                      ],
                    ),
                    color: Palette.myTheme,
                  ),
                  Text("   "),
                  MaterialButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          "2021",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        )
                      ],
                    ),
                    color: Palette.myTheme,
                  )
                ],
              ),
              getRecords(),
              Text("Total Days of Work : 30"),
              Text("Total Days Present : 28"),
              Text("Total Pay(600/Day) : " + (28 * 600).toString()),
              MaterialButton(
                color: Palette.myTheme,
                onPressed: () {
                },
                child: Text(
                  "Generate Report",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
