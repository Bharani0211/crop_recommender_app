import 'dart:convert';
import 'dart:io';

import 'package:crop_recommender/screens/Home/index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ContactUs extends StatefulWidget {
  static String routeName = "/contact_us";
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController msgTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  String? username;
  String? email;
  String? id;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('username'));
    print(prefs.getString('email'));
    setState(() {
      username = prefs.getString('username');
      email = prefs.getString('email');

      emailTextController.text = email!;
      usernameTextController.text = username!;
    });
  }

  Future<int> postContactUsDetails(String name, String msg) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('_id');
    final url = 'https://crop-recommender-system.herokuapp.com/contactus';
    print(url);
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(
          {"_id": id, "username": username, "name": name, "message": msg},
        ));
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      print(response.body);
      return response.statusCode;
    }
    Navigator.pop(context);
    _showMyDialog();
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      "Tell us about any bugs in detail format!",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: TextFormField(
                            enabled: false,
                            controller: emailTextController,
                            validator: (value) {
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
                            enabled: false,
                            controller: usernameTextController,
                            validator: (value) {
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
                            controller: nameTextController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name shouldnt be empty';
                              }
                              return null;
                            },
                            style: _inputTextStyle(context),
                            decoration: InputDecoration(
                              border: _outerBorder(context),
                              hintStyle: _hintTextStyle(context),
                              hintText: 'Name',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: TextFormField(
                            maxLines: 13,
                            controller: msgTextController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Messsage shouldnt be empty';
                              }
                              return null;
                            },
                            style: _inputTextStyle(context),
                            decoration: InputDecoration(
                              border: _outerBorder(context),
                              hintStyle: _hintTextStyle(context),
                              hintText: 'Message',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
                            if (_formKey.currentState!.validate()) {
                              showLoaderDialog(context);
                              postContactUsDetails(nameTextController.text,
                                  msgTextController.text);
                            }
                          },
                          child: Text(
                            "Post",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 15),
              child: Text("Posting bug report...")),
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
          title: const Text('Posting bug report failed.'),
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
