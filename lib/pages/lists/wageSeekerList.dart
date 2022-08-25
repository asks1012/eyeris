import 'package:eyeris/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class wageSeekerList extends StatefulWidget {
  const wageSeekerList({Key? key}) : super(key: key);

  @override
  State<wageSeekerList> createState() => _wageSeekerListState();
}

class _wageSeekerListState extends State<wageSeekerList> {
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
    );
  }
}
