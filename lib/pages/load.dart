import 'dart:isolate';

import 'package:eyeris/pages/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class Load extends StatefulWidget {
  const Load({Key? key}) : super(key: key);

  @override
  State<Load> createState() => _LoadState();
}

class _LoadState extends State<Load> {
  bool isLogin = false;
  bool checked = false;
  checkLogin() async {
    final storage = new FlutterSecureStorage();
    String? empid = await storage.read(key: "empid");
    String? password = await storage.read(key: "password");
    if (empid!.isNotEmpty && password!.isNotEmpty) {
      final uri = Uri.parse("$url/login");
      var response =
          await post(uri, body: {"empid": empid, "password": password});
      if (response.body == '0') {
        print("reached");
        setState(() {
          isLogin = true;
          checked = true;
        });
      }
    } else {
      setState(() {
        checked = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin;
    print(isLogin);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
