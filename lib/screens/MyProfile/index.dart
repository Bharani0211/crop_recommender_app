import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  static String routeName = "/my_profile";
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController passTextController = TextEditingController();
  final TextEditingController confPassTextController = TextEditingController();
  final TextEditingController areaTextController = TextEditingController();
  final TextEditingController villagetalukTextController =
      TextEditingController();
  final TextEditingController districtTextController = TextEditingController();
  final TextEditingController stateTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 16,
          onPressed: () {
            print(ModalRoute.of(context)!.settings.name);
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, left: 15, right: 15),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey[350],
                        radius: 70,
                        child: Icon(
                          Icons.person,
                          size: 70,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: TextFormField(
                          enabled: false,
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
                          enabled: false,
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
                          // setState(() {
                          //   if (_formKey.currentState!.validate()) {
                          //     // progressDialog.show();
                          //     showLoaderDialog(context);
                          //     signUpMethod(
                          //       emailTextController.text,
                          //       usernameTextController.text,
                          //       passTextController.text,
                          //       areaTextController.text,
                          //       villagetalukTextController.text,
                          //       districtTextController.text,
                          //       stateTextController.text,
                          //     );
                          //   }
                          // });
                        },
                        child: Text(
                          "Update",
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
              child: Text("Updating your account...")),
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

  @override
  void initState() {
    super.initState();
    getdata();
  }

  String? username;
  String? email;
  String? area;
  String? villageTaluk;
  String? district;
  String? state;

  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('username'));
    print(prefs.getString('email'));
    setState(() {
      username = prefs.getString('username');
      email = prefs.getString('email');
      area = prefs.getString('area');
      villageTaluk = prefs.getString('village_taluk');
      district = prefs.getString('district');
      state = prefs.getString('state');

      emailTextController.text = email! + "  (Non editable)";
      usernameTextController.text = username! + "  (Non editable)";
      areaTextController.text = area!;
      villagetalukTextController.text = villageTaluk!;
      districtTextController.text = district!;
      stateTextController.text = state!;
    });
  }
}
