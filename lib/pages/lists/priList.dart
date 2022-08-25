import 'package:eyeris/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class priList extends StatefulWidget {
  const priList({Key? key}) : super(key: key);

  @override
  State<priList> createState() => _priListState();
}

class _priListState extends State<priList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PRI Employees",
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
                Navigator.pushNamed(context, '/home/priList/pri');
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
