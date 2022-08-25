import 'dart:convert';
import 'package:eyeris/pages/home.dart';
import 'package:eyeris/pages/vars.dart';
import 'package:eyeris/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  bool isChecked = false;
  bool obscure = true;
  bool loader = false;
  String empid = "", password = "";

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loader,
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).viewPadding.top + 50,
                ),
                Image.asset(
                  "assets/login.png",
                  height: 150,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Login",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    autovalidateMode: autoValidate
                        ? AutovalidateMode.onUserInteraction
                        : AutovalidateMode.disabled,
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              size: 30,
                            ),
                            labelText: 'Employee ID',
                            enabledBorder: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(),
                          ),
                          onChanged: (temp2) {
                            empid = temp2;
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
                        TextFormField(
                          obscureText: obscure,
                          decoration: InputDecoration(
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
                            prefixIcon: const Icon(
                              Icons.key,
                              size: 30,
                            ),
                            labelText: 'Password',
                            enabledBorder: const UnderlineInputBorder(),
                            focusedBorder: const UnderlineInputBorder(),
                          ),
                          onChanged: (temp1) {
                            password = temp1;
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
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            const Text("Accept "),
                            const Text(
                              "Terms and Conditions",
                              style: TextStyle(color: Palette.myTheme),
                            )
                          ],
                        ),
                        MaterialButton(
                          height: 45,
                          color: Palette.myTheme,
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            setState(() {
                              autoValidate = true;
                            });
                            final navigator = Navigator.of(context);
                            if (!_formKey.currentState!.validate() ||
                                isChecked == false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Accept Terms and Conditions")),
                              );
                              return;
                            }
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loader = true;
                              });
                              final snackbar = ScaffoldMessenger.of(context);
                              var bytes = utf8.encode(password);
                              var hash_password = sha256.convert(bytes).toString();
                              final uri = Uri.parse("$url/verifyLogin");
                              try {
                                var response = await post(
                                  uri,
                                  body: {"empid": empid, "password": hash_password},
                                );
                                if (int.parse(response.body) > 0) {
                                  const storage = FlutterSecureStorage();
                                  await storage.deleteAll();
                                  await storage.write(
                                      key: "empid", value: empid);
                                  await storage.write(
                                      key: "password", value: hash_password);
                                  await storage.write(
                                      key: "level", value: response.body);
                                  level = response.body;
                                  setState(() {
                                    loader = false;
                                  });
                                  navigator.pop();
                                  navigator.push(
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                  );
                                } else if (response.body == '0') {
                                  setState(() {
                                    loader = false;
                                  });
                                  snackbar.showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Incorrect EmployeeID / Password"),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    loader = false;
                                  });
                                  snackbar.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Error : ${response.statusCode}"),
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
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Center(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Palette.myTheme),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
