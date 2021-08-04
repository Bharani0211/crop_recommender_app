import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UploadCSV extends StatefulWidget {
  static String routeName = "/upload_csv";
  const UploadCSV({Key? key}) : super(key: key);

  @override
  _UploadCSVState createState() => _UploadCSVState();
}

class _UploadCSVState extends State<UploadCSV> {
  final TextEditingController linkTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getdata();
  }

  String? id;
  String? drive_folder_id;
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('_id'));
    setState(() {
      id = prefs.getString('_id');
    });
  }

  uploadCSV(String folderId) async {
    try {
      var response = await http.post(
        Uri.https("crop-recommender-system.herokuapp.com", "upload"),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode({"folder_id": folderId, "_id": id}),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        // ignore: await_only_futures
        Navigator.pop(context);
        _showDialog();
        linkTextController.text = "";
        return response.body;
      } else if (response.statusCode == 404) {
        Navigator.pop(context);
        _showFailedDialog();
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
      appBar: AppBar(
        title: Text("Upload CSV"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 16,
          onPressed: () {
            print(ModalRoute.of(context)!.settings.name);
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.25,
              decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          "Steps to upload your CSV data.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 25.0),
                    child: Text(
                      "a) Upload the CSV data to your google drive.",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 25.0),
                    child: Text(
                      "b) Make that CSV file as sharable.",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 25.0),
                    child: Text(
                      "c) Change the sharable link type to (Anyone with link can\n     view).",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 25.0),
                    child: Text(
                      "d) Copy the link and paste the link here.",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 25.0),
                    child: Text(
                      "e) And click upload data button.",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "(Note: Result of the data that you have uploaded will be displayed in my recommendations page.",
              style: TextStyle(
                height: 1.2,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                child: TextFormField(
                  autofocus: false,
                  controller: linkTextController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Link shouldnt be empty';
                    }
                    return null;
                  },
                  style: _inputTextStyle(context),
                  decoration: InputDecoration(
                    border: _outerBorder(context),
                    hintStyle: _hintTextStyle(context),
                    hintText: 'Google drive link',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.black87,
                    primary: Colors.black,
                    minimumSize: Size(150, 40),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onPressed: () {
                  setState(() {
                    if (_formKey.currentState!.validate()) {
                      // progressDialog.show();
                      // showLoaderDialog(context);
                      drive_folder_id =
                          linkTextController.text.substring(32, 65);
                      print(id);
                      print(drive_folder_id);
                      uploadCSV(drive_folder_id!);
                      showLoaderDialog(context);
                    }
                  });
                },
                child: Text(
                  "Upload data",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
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
              child: Text("Uploading CSV file!")),
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

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uploading CSV file is done!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Check your results later in my recommendations screen!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok!'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showFailedDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Uploadind CSV file failed'),
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
