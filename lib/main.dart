import 'package:crop_recommender/screens/Home/index.dart';
import 'package:crop_recommender/screens/Routes.dart';
import 'package:crop_recommender/screens/login/index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: non_constant_identifier_names
var access_token;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if (preferences.getString("access_token") == null) {
    if (preferences.getString("access_token") == "null") {
      preferences.setString('_id', "null");
      preferences.setString('access_token', "null");
      preferences.setString('username', "null");
    }
  }
  access_token = preferences.getString("access_token");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crop recommender',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: access_token == "null" || access_token == null
          ? LoginScreen()
          : HomeScreen(),
      routes: routes,
    );
  }
}
