import 'package:crop_recommender/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("About Us"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 16,
            onPressed: () {
              print(ModalRoute.of(context)!.settings.name);
              Navigator.pop(context);
            },
          ),
        ),
        // drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text("Our Team",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Text(
                            "Disha K",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.blue[900],
                            ),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          GestureDetector(
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "Email: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.0),
                                    ),
                                    Text(
                                      "dish17is@cmrit.ac.in",
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                    // emailtext("pguru040@gmail.com"),
                                  ],
                                ),
                              ),
                              onTap: () {
                                print("clicked");
                                Mailto("dish17is@cmrit.ac.in");
                              }),
                          SizedBox(
                            height: 4.0,
                          ),
                          GestureDetector(
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    "Phone: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  Text("+91 9880342359")
                                  // CallerTextAboutUs("7899424065"),
                                ],
                              ),
                            ),
                            onTap: () {
                              call("+91 9880342359");
                            },
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            children: [
                              Text(
                                "Address: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Text("CMR Institute Of Technology"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Text(
                            "Bharanidharan K",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.blue[900],
                            ),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          GestureDetector(
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "Email: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.0),
                                    ),
                                    Text(
                                      "bhar17is@cmrit.ac.in",
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                    // emailtext("pguru040@gmail.com"),
                                  ],
                                ),
                              ),
                              onTap: () {
                                print("clicked");
                                Mailto("bhar17is@cmrit.ac.in");
                              }),
                          SizedBox(
                            height: 4.0,
                          ),
                          GestureDetector(
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    "Phone: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  Text("+91 7829771518")
                                  // CallerTextAboutUs("7899424065"),
                                ],
                              ),
                            ),
                            onTap: () {
                              call("+91 7829771518");
                            },
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            children: [
                              Text(
                                "Address: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Text("CMR Institute Of Technology"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Text(
                            "Pooja",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.blue[900],
                            ),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          GestureDetector(
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "Email: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.0),
                                    ),
                                    Text(
                                      "pooa17is@cmrit.ac.in",
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                    // emailtext("pguru040@gmail.com"),
                                  ],
                                ),
                              ),
                              onTap: () {
                                print("clicked");
                                Mailto("pooa17is@cmrit.ac.in");
                              }),
                          SizedBox(
                            height: 4.0,
                          ),
                          GestureDetector(
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "Phone: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                    Text("+91 9880342359")
                                    // CallerTextAboutUs("7899424065"),
                                  ],
                                ),
                              ),
                              onTap: () {
                                call("+91 9880342359");
                              }),
                          SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            children: [
                              Text(
                                "Address: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Text("CMR Institute Of Technology"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                    child: Text("Guided by",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Text(
                            "Mrs. Anu Jose | Assistant Professor",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.blue[900],
                            ),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          GestureDetector(
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "Email: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15.0),
                                    ),
                                    Text(
                                      "anu.j@cmrit.ac",
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                    // emailtext("pguru040@gmail.com"),
                                  ],
                                ),
                              ),
                              onTap: () {
                                print("clicked");
                                Mailto("anu.j@cmrit.ac");
                              }),
                          SizedBox(
                            height: 4.0,
                          ),
                          GestureDetector(
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    "Phone: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  Text("+91 8095833222"),
                                  // CallerTextAboutUs("7899424065"),
                                ],
                              ),
                            ),
                            onTap: () {
                              call("+91 8095833222");
                            },
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Row(
                            children: [
                              Text(
                                "Address: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Text("CMR Institute Of Technology"),
                            ],
                          ),
                        ],
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

  void call(String no) {
    Utils.openPhoneCall(phoneNumber: no);
  }
}

void Mailto(String s) {
  Utils.openEmail(
      toEmail: s, subject: "From Crop recommender system", body: "content");
}
