import 'package:crop_recommender/screens/AboutUs/index.dart';
import 'package:crop_recommender/screens/ContactUs/index.dart';
import 'package:crop_recommender/screens/DetailScreen/index.dart';
import 'package:crop_recommender/screens/FeedbackForm/index.dart';
import 'package:crop_recommender/screens/Home/index.dart';
import 'package:crop_recommender/screens/MyProfile/index.dart';
import 'package:crop_recommender/screens/My_recommendation/index.dart';
import 'package:crop_recommender/screens/UploadCSV/index.dart';
import 'package:crop_recommender/screens/login/index.dart';
import 'package:crop_recommender/screens/signup/index.dart';
import 'package:flutter/cupertino.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  SignupPage.routeName: (context) => SignupPage(),
  MyRecommendation.routeName: (context) => MyRecommendation(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ContactUs.routeName: (context) => ContactUs(),
  FeedBackForm.routeName: (context) => FeedBackForm(),
  MyProfile.routeName: (context) => MyProfile(),
  UploadCSV.routeName: (context) => UploadCSV(),
  DetailScreen.routeName: (context) => DetailScreen(),
};
