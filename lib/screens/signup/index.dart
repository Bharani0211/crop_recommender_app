import 'dart:convert';
import 'dart:io';
import 'package:crop_recommender/model/loginModel.dart';
import 'package:crop_recommender/screens/login/index.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  static String routeName = "/signup";
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController passTextController = TextEditingController();
  final TextEditingController confPassTextController = TextEditingController();
  final TextEditingController areaTextController = TextEditingController();
  final TextEditingController villagetalukTextController =
      TextEditingController();
  final TextEditingController districtTextController = TextEditingController();
  final TextEditingController stateTextController = TextEditingController();

  bool _obscurePasswordText = true;
  bool _obscureConfPasswordText = true;

  signUpMethod(String email, String username, String password, String area,
      String villageTaluk, String district, String state) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonResponse;
    try {
      var response = await http.post(
        Uri.https("crop-recommender-system.herokuapp.com", "signup"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({
          "email": email,
          "username": username,
          "password": password,
          "area": area,
          "village_taluk": villageTaluk,
          "district": district,
          "state": state
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);

        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        print("SignUp finished");
        return loginModelFromJson(response.body);
      } else if (response.statusCode == 404) {
        Navigator.pop(context);
        _showMyDialog();
        emailTextController.text = "";
        passTextController.text = "";
      }
    } catch (e) {
      print(e);
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight * 1,
          width: screenWidth * 1,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Image.asset(
                          'assets/images/signUp.png',
                          height: screenHeight * 0.3,
                          width: screenWidth * 0.85,
                        ),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Welcome, Create your new account!",
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            controller: emailTextController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email shouldnt be empty';
                              }
                              if (!value.contains("@")) {
                                return "Invalid mail address";
                              }
                              return null;
                            },
                            style: _inputTextStyle(context),
                            decoration: InputDecoration(
                              border: _outerBorder(context),
                              hintStyle: _hintTextStyle(context),
                              hintText: 'Email',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            controller: usernameTextController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Username shouldnt be empty';
                              }
                              // if (!value.contains("@")) {
                              //   return "Invalid mail address";
                              // }
                              return null;
                            },
                            style: _inputTextStyle(context),
                            decoration: InputDecoration(
                              border: _outerBorder(context),
                              hintStyle: _hintTextStyle(context),
                              hintText: 'Username',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            obscureText: _obscurePasswordText,
                            controller: passTextController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                passTextController.text = value;
                                return 'passsword shouldnt be empty';
                              }
                              return null;
                            },
                            style: _inputTextStyle(context),
                            decoration: InputDecoration(
                              border: _outerBorder(context),
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: _obscurePasswordText
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                                onPressed: _togglePass,
                              ),
                              hintStyle: _hintTextStyle(context),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            obscureText: _obscureConfPasswordText,
                            controller: confPassTextController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Confirm pasword shouldnt be empty';
                              }
                              if (passTextController.text != value) {
                                return "Pasword's not matching";
                              }
                              return null;
                            },
                            style: _inputTextStyle(context),
                            decoration: InputDecoration(
                              border: _outerBorder(context),
                              hintText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon: _obscureConfPasswordText
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                                onPressed: _toggleConfPass,
                              ),
                              hintStyle: _hintTextStyle(context),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            controller: areaTextController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Area shouldnt be empty';
                              }
                              return null;
                            },
                            style: _inputTextStyle(context),
                            decoration: InputDecoration(
                              border: _outerBorder(context),
                              hintStyle: _hintTextStyle(context),
                              hintText: 'Area',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            controller: villagetalukTextController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Village taluk shouldnt be empty';
                              }
                              return null;
                            },
                            style: _inputTextStyle(context),
                            decoration: InputDecoration(
                              border: _outerBorder(context),
                              hintStyle: _hintTextStyle(context),
                              hintText: 'Village Taluk',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            controller: districtTextController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'District shouldnt be empty';
                              }
                              return null;
                            },
                            style: _inputTextStyle(context),
                            decoration: InputDecoration(
                              border: _outerBorder(context),
                              hintStyle: _hintTextStyle(context),
                              hintText: 'District',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            controller: stateTextController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'State shouldnt be empty';
                              }
                              return null;
                            },
                            style: _inputTextStyle(context),
                            decoration: InputDecoration(
                              border: _outerBorder(context),
                              hintStyle: _hintTextStyle(context),
                              hintText: 'State',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              onPrimary: Colors.black87,
                              primary: Colors.black,
                              minimumSize: Size(150, 45),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              )),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                // progressDialog.show();
                                showLoaderDialog(context);
                                signUpMethod(
                                  emailTextController.text,
                                  usernameTextController.text,
                                  passTextController.text,
                                  areaTextController.text,
                                  villagetalukTextController.text,
                                  districtTextController.text,
                                  stateTextController.text,
                                );
                              }
                            });
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Dont have account? "),
                                Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: constraints.maxHeight /
                                        constraints.maxWidth *
                                        7.5,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _togglePass() {
    setState(() {
      _obscurePasswordText = !_obscurePasswordText;
    });
  }

  void _toggleConfPass() {
    setState(() {
      _obscureConfPasswordText = !_obscureConfPasswordText;
    });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 15),
              child: Text("Creating account...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _inputTextStyle(BuildContext context) {
    return TextStyle(
        fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400);
  }

  _hintTextStyle(BuildContext context) {
    return TextStyle(
        fontSize: 15, color: Colors.black45, fontWeight: FontWeight.w400);
  }

  _outerBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green,
        width: 10.0,
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('SignUp failed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please try again later!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
