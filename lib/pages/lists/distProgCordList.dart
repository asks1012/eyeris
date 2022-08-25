import 'package:eyeris/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class distProgCordList extends StatefulWidget {
  const distProgCordList({Key? key}) : super(key: key);

  @override
  State<distProgCordList> createState() => _distProgCordListState();
}

class _distProgCordListState extends State<distProgCordList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "DPC Employees",
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
                Navigator.pushNamed(
                    context, '/home/distProgCordList/distProgCord');
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
