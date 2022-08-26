import 'package:eyeris/pages/forms/distProgCord.dart';
import 'package:eyeris/pages/forms/pri.dart';
import 'package:eyeris/pages/forms/progOfficer.dart';
import 'package:eyeris/pages/forms/stateGov.dart';
import 'package:eyeris/pages/forms/wageSeeker.dart';
import 'package:eyeris/pages/home.dart';
import 'package:eyeris/pages/lists/distProgCordList.dart';
import 'package:eyeris/pages/lists/priList.dart';
import 'package:eyeris/pages/lists/progOfficerList.dart';
import 'package:eyeris/pages/lists/stateGovList.dart';
import 'package:eyeris/pages/lists/wageSeekerList.dart';
import 'package:eyeris/pages/login.dart';
import 'package:eyeris/pages/splash.dart';
import 'package:eyeris/pages/viewAttendance.dart';
import 'package:eyeris/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const Splash(),
        '/home': (context) => const Home(),
        '/login': (context) => const Login(),
        '/home/stateGovList': (context) => const stateGovList(),
        '/home/stateGovList/stateGov': (context) => const stateGov(),
        '/home/distProgCordList': (context) => const distProgCordList(),
        '/home/distProgCordList/distProgCord': (context) =>
            const distProgCord(),
        '/home/progOfficerList': (context) => const progOfficerList(),
        '/home/progOfficerList/progOfficer': (context) => const progOfficer(),
        '/home/priList': (context) => const priList(),
        '/home/priList/pri': (context) => const pri(),
        '/home/wageSeekerList': (context) => const wageSeekerList(),
        '/home/wageSeekerList/wageSeeker': (context) => const wageSeeker(),
        '/home/viewAttendance': (context) => const viewAttendance(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.redHatDisplayTextTheme(),
        primarySwatch: Palette.myTheme,
      ),
    );
  }
}
