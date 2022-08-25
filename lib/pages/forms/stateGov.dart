import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:eyeris/pages/vars.dart';
import 'package:eyeris/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nanoid/nanoid.dart';

class stateGov extends StatefulWidget {
  const stateGov({Key? key}) : super(key: key);

  @override
  State<stateGov> createState() => _stateGovState();
}

class _stateGovState extends State<stateGov> {
  @override
  void initState() {
    super.initState();
    myempid.text = "--";
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController myempid = TextEditingController();
  bool loader = false;
  bool obscure = true;
  bool autoValidate = false;
  String empid = "--";
  var id = "";
  String fname = "", lname = "", password = "", phone = "", state = "";
  @override
  Widget build(BuildContext context) {
    final snackbar = ScaffoldMessenger.of(context);
    Future<int> genID() async {
      setState(() {
        loader = true;
        empid = "--";
      });
      id = "";
      id = customAlphabet('1234567890', 5);
      id = "ST$id";
      final uri = Uri.parse("$url/checkEmpID");
      try {
        var response = await post(uri, body: {"empid": id});
        if (response.body == "0") {
          setState(() {
            empid = id;
            myempid.text = empid;
            loader = false;
          });
        } else if (response.body == "1") {
          genID();
        } else {
          snackbar
              .showSnackBar(const SnackBar(content: Text("Exception Occured")));
          setState(() {
            loader = false;
          });
        }
      } catch (e) {
        snackbar
            .showSnackBar(const SnackBar(content: Text("Exception Occured")));
        setState(() {
          loader = false;
        });
      }
      return 0;
    }

    return ModalProgressHUD(
      inAsyncCall: loader,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Create State Govt. Employee",
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
              )),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              autovalidateMode: autoValidate
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),

                  // For First Name
                  TextFormField(
                    maxLength: 70,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      counterText: "",
                      icon: Icon(
                        Icons.person,
                        size: 30,
                      ),
                      labelText: 'Firstname',
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.myTheme)),
                    ),
                    onChanged: (temp1) {
                      fname = temp1;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (!RegExp('^[a-zA-Z ]+\$').hasMatch(value)) {
                        return 'Enter valid Firstname';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // For Last Name
                  TextFormField(
                    maxLength: 70,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      counterText: "",
                      icon: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.transparent,
                      ),
                      labelText: 'Lastname',
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.myTheme)),
                    ),
                    onChanged: (temp1) {
                      lname = temp1;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (!RegExp('^[a-zA-Z ]+\$').hasMatch(value)) {
                        return 'Enter valid Lastname';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // For State Name
                  TextFormField(
                    maxLength: 70,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      counterText: "",
                      icon: Icon(
                        Icons.location_on,
                        size: 30,
                      ),
                      labelText: 'State',
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.myTheme)),
                    ),
                    onChanged: (temp1) {
                      state = temp1;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (!RegExp('^[a-zA-Z ]+\$').hasMatch(value)) {
                        return 'Enter valid State';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // For Mobile Number
                  TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      counterText: "",
                      icon: Icon(
                        Icons.phone,
                        size: 30,
                      ),
                      labelText: 'Phone Number',
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.myTheme)),
                    ),
                    onChanged: (temp1) {
                      phone = temp1;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (!RegExp('^[0-9]{10}\$').hasMatch(value)) {
                        return 'Enter valid Phone Number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // For Employee ID
                  TextFormField(
                    controller: myempid,
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10),
                      counterText: "",
                      icon: const Icon(
                        Icons.person_pin_rounded,
                        size: 30,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            genID();
                          },
                          icon: const Icon(
                            Icons.replay_outlined,
                            color: Palette.myTheme,
                          )),
                      labelText: 'Generated Employee ID',
                      errorBorder: const OutlineInputBorder(),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.myTheme)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // For Password
                  TextFormField(
                    obscureText: obscure,
                    maxLength: 70,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10),
                      counterText: "",
                      icon: const Icon(
                        Icons.key,
                        size: 30,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        icon: obscure
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                      labelText: 'Password',
                      errorBorder: const OutlineInputBorder(),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.myTheme)),
                    ),
                    onChanged: (temp1) {
                      password = temp1;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (!RegExp('^.{8,}\$').hasMatch(value)) {
                        return 'Password must be atleast 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Submit button
                  MaterialButton(
                    height: 45,
                    color: Palette.myTheme,
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      setState(() {
                        autoValidate = true;
                      });
                      if (empid == "--") {
                        print(myempid.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please Generate Employee ID")),
                        );
                        return;
                      }
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loader = true;
                        });
                        var bytes = utf8.encode(password);
                        var hashPassword = sha256.convert(bytes).toString();
                        final uri = Uri.parse("$url/registerStateEmp");
                        try {
                          var response = await post(
                            uri,
                            body: {
                              "fname": fname,
                              "lname": lname,
                              "state": state,
                              "phone": phone,
                              "empid": empid,
                              "password": hashPassword
                            },
                          );
                          if (response.body == '0') {
                            setState(() {
                              loader = false;
                            });
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return WillPopScope(
                                  onWillPop: (() async => false),
                                  child: AlertDialog(
                                    actionsPadding: const EdgeInsets.all(0),
                                    actionsAlignment: MainAxisAlignment.center,
                                    titlePadding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 20),
                                    title: const Center(
                                      child: Text(
                                        "Account created successfully",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.grey.shade100,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Back",
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            setState(() {
                              loader = false;
                            });
                            snackbar.showSnackBar(
                              SnackBar(
                                content: Text("Error : ${response.statusCode}"),
                              ),
                            );
                          }
                        } catch (e) {
                          setState(() {
                            loader = false;
                          });
                          snackbar.showSnackBar(
                            const SnackBar(
                              content: Text("Exception Occured"),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
