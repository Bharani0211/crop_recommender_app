import 'package:crop_recommender/screens/AboutUs/index.dart';
import 'package:crop_recommender/screens/ContactUs/index.dart';
import 'package:crop_recommender/screens/FeedbackForm/index.dart';
import 'package:crop_recommender/screens/MyProfile/index.dart';
import 'package:crop_recommender/screens/My_recommendation/index.dart';
import 'package:crop_recommender/screens/UploadCSV/index.dart';
import 'package:crop_recommender/screens/login/index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getdata();
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('_id', "null");
    preferences.setString('access_token', "null");
    preferences.setString('username', "null");
  }

  String? username;
  String? email;
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('username'));
    print(prefs.getString('email'));
    setState(() {
      username = prefs.getString('username');
      email = prefs.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, $username!"),
        actions: [],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white60,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 40, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$username",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "$email",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ModalRoute.of(context)!.settings.name != "/home" ||
                    ModalRoute.of(context)!.settings.name != "/"
                ? Container(
                    color: Colors.grey[300],
                    child: ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Colors.green[500],
                      ),
                      title: Text('Home'),
                      onTap: () {
                        print(ModalRoute.of(context)!.settings.name);
                        Navigator.pop(context);
                      },
                    ),
                  )
                : ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.green[500],
                    ),
                    title: Text('Home'),
                    onTap: () {
                      print(ModalRoute.of(context)!.settings.name);
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                    },
                  ),
            ListTile(
              leading: Icon(
                Icons.history,
                color: Colors.green[500],
              ),
              title: Text('My Recommendation'),
              onTap: () {
                print(ModalRoute.of(context)!.settings.name);
                Navigator.pop(context);
                Navigator.pushNamed(context, MyRecommendation.routeName);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.upload_file,
                color: Colors.green[500],
              ),
              title: Text('Upload CSV'),
              onTap: () {
                print(ModalRoute.of(context)!.settings.name);
                Navigator.pop(context);
                Navigator.pushNamed(context, UploadCSV.routeName);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.call,
                color: Colors.green[500],
              ),
              title: Text('About Us'),
              onTap: () {
                print(ModalRoute.of(context)!.settings.name);
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.green[500],
              ),
              title: Text('My Profile'),
              onTap: () {
                print(ModalRoute.of(context)!.settings.name);
                Navigator.pop(context);
                Navigator.pushNamed(context, MyProfile.routeName);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.mail,
                color: Colors.green[500],
              ),
              title: Text('Contact Us'),
              onTap: () {
                print(ModalRoute.of(context)!.settings.name);
                Navigator.pop(context);
                Navigator.pushNamed(context, ContactUs.routeName);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.feed,
                color: Colors.green[500],
              ),
              title: Text('Feedback form'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, FeedBackForm.routeName);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.green[500],
              ),
              title: Text('Logout'),
              onTap: () {
                logout();
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to Crop recommender app",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "App which recommends the desired crop of your soil you have..",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Types of Algorithm we use:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                          child: Text(
                            "1) KNN Prediction",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 20.0),
                          child: Text(
                              "A k-nearest-neighbor algorithm, often abbreviated k-nn, is an approach to data classification that estimates how likely a data point is to be a member of one group or the other depending on what group the data points nearest to it are in."),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 6.0,
                            left: 8.0,
                          ),
                          child: Text(
                            "2) Logistic regression",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 20.0),
                          child: Text(
                              "Logistic regression is a statistical analysis method used to predict a data value based on prior observations of a data set. A logistic regression model predicts a dependent data variable by analyzing the relationship between one or more existing independent variables."),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 6.0,
                            left: 8.0,
                          ),
                          child: Text(
                            "3) Decision tree",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 20.0),
                          child: Text(
                            "Decision Tree algorithm belongs to the family of supervised learning algorithms. The goal of using a Decision Tree is to create a training model that can use to predict the class or value of the target variable by learning simple decision rules inferred from prior data(training data).",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 6.0,
                            left: 8.0,
                          ),
                          child: Text(
                            "4) Naive Bayes",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 20.0),
                          child: Text(
                            "A naive Bayes classifier is an algorithm that uses Bayes' theorem to classify objects. Naive Bayes classifiers assume strong, or naive, independence between attributes of data points. Popular uses of naive Bayes classifiers include spam filters, text analysis and medical diagnosis. These classifiers are widely used for machine learning because they are simple to implement.",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 6.0,
                            left: 8.0,
                          ),
                          child: Text(
                            "5) Random forest",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 20.0),
                          child: Text(
                            "Random forest is a flexible, easy to use machine learning algorithm that produces, even without hyper-parameter tuning, a great result most of the time. It is also one of the most used algorithms, because of its simplicity and diversity (it can be used for both classification and regression tasks).",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
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
                    Navigator.pushNamed(context, UploadCSV.routeName);
                  },
                  child: Text(
                    "TRY OUT!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
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
