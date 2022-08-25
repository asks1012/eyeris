import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:eyeris/pages/vars.dart';
import 'package:eyeris/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nanoid/nanoid.dart';

class wageSeeker extends StatefulWidget {
  const wageSeeker({Key? key}) : super(key: key);

  @override
  State<wageSeeker> createState() => _wageSeekerState();
}

class _wageSeekerState extends State<wageSeeker> {
  DateTime? pickedDate;
  TextEditingController dateInput = TextEditingController();
  @override
  void initState() {
    super.initState();
    dateInput.text = "";
    myempid.text = "--";
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController myempid = TextEditingController();
  bool loader = false;
  bool obscure = true;
  bool autoValidate = false;
  String empid = "--";
  var id = "";
  String fname = "",
      lname = "",
      phone = "",
      dob = "",
      address = "",
      pincode = "",
      mobile = "";
  @override
  Widget build(BuildContext context) {
    final snackbar = ScaffoldMessenger.of(context);
    bool isChild(DateTime birthDate) {
      DateTime today = DateTime.now();
      print(today);
      DateTime adultDate = DateTime(
        birthDate.year + 18,
        birthDate.month,
        birthDate.day,
      );
      return today.isBefore(adultDate);
    }

    Future<int> genID() async {
      setState(() {
        loader = true;
        empid = "--";
      });
      id = "";
      id = customAlphabet('1234567890', 10);
      id = "WS$id";
      final uri = Uri.parse("$url/checkWSID");
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
            "Create Wage Seeker",
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

                  // For Date of Birth
                  TextFormField(
                    controller: dateInput,
                    readOnly: true,
                    onTap: () async {
                      pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate!);
                        print(formattedDate);
                        setState(() {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      counterText: "",
                      icon: Icon(
                        Icons.calendar_month,
                        size: 30,
                      ),
                      labelText: 'Date of Birth',
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.myTheme)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      if (isChild(pickedDate!)) {
                        return 'Must be 18 years old';
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

                  // For Wage Seeker ID
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
                      labelText: 'Generated Wage Seeker ID',
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

                  // For Pincode
                  TextFormField(
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      counterText: "",
                      icon: Icon(
                        Icons.location_on,
                        size: 30,
                      ),
                      labelText: 'Pincode',
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.myTheme)),
                    ),
                    onChanged: (temp1) {
                      pincode = temp1;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      } else if (!RegExp('^[0-9]{6}\$').hasMatch(value)) {
                        return 'Enter valid Pincode';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // For Address
                  TextFormField(
                    minLines: 6,
                    maxLines: 6,
                    maxLength: 200,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      counterText: "",
                      icon: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.transparent,
                      ),
                      hintText: 'Address',
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Palette.myTheme)),
                    ),
                    onChanged: (temp1) {
                      address = temp1;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // IRIS capture button
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.amber,
                    minWidth: MediaQuery.of(context).size.width,
                    height: 45,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Capture IRIS  ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.not_interested_rounded,
                            color: Colors.red,
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please Generate Worker ID")),
                        );
                        return;
                      }
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loader = true;
                        });
                        final uri = Uri.parse("$url/registerWS");
                        try {
                          var response = await post(
                            uri,
                            body: {
                              "fname": fname,
                              "lname": lname,
                              "dob": dateInput.text,
                              "phone": phone,
                              "empid": empid,
                              "pincode": pincode,
                              "address": address,
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
