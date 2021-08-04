import 'dart:convert';
import 'dart:io';
import 'package:crop_recommender/model/loginModel.dart';
import 'package:crop_recommender/screens/Home/index.dart';
import 'package:crop_recommender/screens/signup/index.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  static const String color = "#00FF00";

  signInMethod(String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonResponse;
    try {
      var response = await http.post(
        Uri.https("crop-recommender-system.herokuapp.com", "login"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({"email": email, "password": password}),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);

        print(
            "Before \nToken: ${preferences.getString('access_token')} \n id: ${preferences.getString('_id')}");
        preferences.setString('access_token', jsonResponse["access_token"]);
        preferences.setString('_id', jsonResponse["_id"]);
        preferences.setString('email', jsonResponse['email']);
        preferences.setString('username', jsonResponse['username']);

        preferences.setString('area', jsonResponse['area']);
        preferences.setString('village_taluk', jsonResponse['village_taluk']);
        preferences.setString('district', jsonResponse['district']);
        preferences.setString('state', jsonResponse['state']);

        print("SignIn response: $jsonResponse");
        print(
            "Login succesful\nToken : ${preferences.getString('access_token')} \n id: ${preferences.getString('_id')}");
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        print("Login finished");
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

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: screenHeight * 1,
        width: screenWidth * 1,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      'assets/images/signin.png',
                      height: screenHeight * 0.3,
                      width: screenWidth * 0.85,
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Welcome back!",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                    SizedBox(
                      height: 40,
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
                        obscureText: _obscureText,
                        controller: passTextController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'passsword shouldnt be empty';
                          }
                          return null;
                        },
                        style: _inputTextStyle(context),
                        decoration: InputDecoration(
                          border: _outerBorder(context),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: _obscureText
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: _toggle,
                          ),
                          hintStyle: _hintTextStyle(context),
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
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState!.validate()) {
                            // progressDialog.show();
                            showLoaderDialog(context);
                            signInMethod(
                              emailTextController.text,
                              passTextController.text,
                            );
                          }
                        });
                      },
                      child: Text(
                        "Login",
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
                        Navigator.pushNamed(context, SignupPage.routeName);
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
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 15), child: Text("Logging In...")),
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
          title: const Text('Login failed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please enter the correct username and password'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Retry!'),
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
