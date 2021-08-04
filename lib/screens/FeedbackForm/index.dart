import 'dart:convert';
import 'dart:io';

import 'package:crop_recommender/screens/Home/index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_star_rating/simple_star_rating.dart';
import 'package:http/http.dart' as http;

class FeedBackForm extends StatefulWidget {
  static String routeName = "/feedback_form";
  const FeedBackForm({Key? key}) : super(key: key);

  @override
  _FeedBackFormState createState() => _FeedBackFormState();
}

class _FeedBackFormState extends State<FeedBackForm> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController thoughtsTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getdata();
  }

  String? id;
  String? username;
  String? email;
  double? rating;

  getdata() async {
    // print("HElllo");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('username'));
    print(prefs.getString('email'));
    setState(() {
      emailTextController.text = prefs.getString('email')!;
      usernameTextController.text = prefs.getString('username')!;
    });
  }

  Future<int> postFeedbackDetails(String thought, double rating) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url = 'https://crop-recommender-system.herokuapp.com/feedback';
    print(url);
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(
          {
            "_id": prefs.getString('_id'),
            "username": prefs.getString('username'),
            "thoughts": thought,
            "rating": rating,
          },
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Feedback Form"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 16,
          onPressed: () {
            print(ModalRoute.of(context)!.settings.name);
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    "What do you think of our App?",
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
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Rate our app :",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SimpleStarRating(
                            allowHalfRating: true,
                            starCount: 10,
                            isReadOnly: false,
                            rating: 6,
                            size: 30,
                            onRated: (rate) {
                              setState(() {
                                rating = rate!;
                              });
                            },
                            spacing: 5,
                          ),
                        ],
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
                          maxLines: 8,
                          controller: thoughtsTextController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Thoughts shouldnt be empty';
                            }
                            return null;
                          },
                          style: _inputTextStyle(context),
                          decoration: InputDecoration(
                            border: _outerBorder(context),
                            hintStyle: _hintTextStyle(context),
                            hintText: 'Thoughts',
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
                            postFeedbackDetails(
                                thoughtsTextController.text, rating!);
                          }
                        },
                        child: Text(
                          "Submit",
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
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 15),
              child: Text("Posting feedback...")),
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
          title: const Text('Posting feedback failed'),
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
