import 'package:eyeris/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongolib;

class stateGovList extends StatefulWidget {
  const stateGovList({Key? key}) : super(key: key);

  @override
  State<stateGovList> createState() => _stateGovListState();
}

class _stateGovListState extends State<stateGovList> {
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "State Govt. Employees",
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
                Navigator.pushNamed(context, '/home/stateGovList/stateGov');
              },
              icon: const Icon(
                Icons.add,
                color: Palette.myTheme,
              ))
        ],
      ),
    );
  }
}
