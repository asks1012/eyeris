import 'package:eyeris/pages/home.dart';
import 'package:eyeris/pages/login.dart';
import 'package:eyeris/pages/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongolib;

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool loader = true;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future checkLogin() async {
    final navigator = Navigator.of(context);
    try {
      var db = await mongolib.Db.create(
          "mongodb+srv://eyeris:UHgKx1WwkMiPBMRJ@eyeris.yqu1m.mongodb.net/EYEris");
      await db.open();
      var coll = db.collection("vars");
      var l = await coll.findOne();
      url = l!['url'];
      db.close();
    } catch (e) {
      url = "";
    }

    const storage = FlutterSecureStorage();
    level = await storage.read(key: "level");
    empid = await storage.read(key: "empid");
    String? password = await storage.read(key: "password");
    if (url.isNotEmpty &&
        level != null &&
        level!.isNotEmpty &&
        empid != null &&
        password != null &&
        empid!.isNotEmpty &&
        password.isNotEmpty) {
      final uri = Uri.parse("$url/login");
      try {
        var response = await post(uri,
            body: {"empid": empid, "password": password, "level": level});
        if (int.parse(response.body) > 0) {
          setState(() {
            loader = false;
          });
          navigator.pop();
          navigator.push(MaterialPageRoute(builder: (context) => const Home()));
        } else {
          setState(() {
            loader = false;
          });
          navigator.pop();
          navigator
              .push(MaterialPageRoute(builder: (context) => const Login()));
        }
      } catch (e) {
        setState(() {
          loader = false;
        });
        navigator.pop();
        navigator.push(MaterialPageRoute(builder: (context) => const Login()));
      }
    } else {
      setState(() {
        loader = false;
      });
      navigator.pop();
      navigator.push(MaterialPageRoute(builder: (context) => const Login()));
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: loader,
        child: Container(),
      ),
    );
  }
}
