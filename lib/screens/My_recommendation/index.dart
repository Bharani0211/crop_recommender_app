import 'dart:convert';
import 'dart:io';
import 'package:crop_recommender/model/recommendModel.dart';
import 'package:crop_recommender/screens/DetailScreen/index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class MyRecommendation extends StatefulWidget {
  static String routeName = "/recommendation";
  MyRecommendation({Key? key}) : super(key: key);

  @override
  _MyRecommendationState createState() => _MyRecommendationState();
}

class _MyRecommendationState extends State<MyRecommendation> {
  String? id;
  Future<List<RecommendationModel>>? data;

  Future<List<RecommendationModel>> getRecommendation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('_id'));
    setState(() {
      id = prefs.getString('_id');
      print(id);
    });
    Map<String, String> headers = new Map();
    final url = 'https://crop-recommender-system.herokuapp.com/result/$id';
    print(url);
    http.Response response = await http.get(
      Uri.parse(url),
    );
    print("From Model: ${recommendationModelFromJson(response.body)}");
    print(data);
    print(recommendationModelFromJson(response.body));
    return recommendationModelFromJson(response.body);
  }

  @override
  void initState() {
    super.initState();
    data = getRecommendation();
  }

  convertTime(String time) {
    String d;
    int hour;
    d = time;
    hour = int.parse(d.substring(0, 2));
    if (hour == 12) {
      return hour.toString() + time.substring(2) + " PM";
    }
    if (hour >= 13 && hour <= 23) {
      hour = hour - 12;
      return hour.toString() + time.substring(2) + " PM";
    }
    if (hour >= 1 && hour <= 11) {
      hour = hour - 12;
      return hour.toString() + time.substring(2) + " AM";
    }
    return d;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          iconSize: 16,
          onPressed: () {
            print(ModalRoute.of(context)!.settings.name);
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("My Recommendations"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<RecommendationModel>>(
          future: data!,
          builder: (BuildContext context,
              AsyncSnapshot<List<RecommendationModel>> snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, DetailScreen.routeName,
                            arguments: {"index": index});
                        print(index.runtimeType);
                      },
                      child: Card(
                        color: Colors.green[200],
                        child: ListTile(
                          title: Row(
                            children: [
                              Text(
                                "CSV file uploaded on:",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                " ${snapshot.data![index].createdAt!.toString().substring(0, 10)}, ",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              (int.parse(snapshot.data![index].createdAt!
                                              .toString()
                                              .substring(11, 13)) >=
                                          1) &&
                                      (int.parse(snapshot
                                              .data![index].createdAt!
                                              .toString()
                                              .substring(11, 13)) <=
                                          11)
                                  ? Text(
                                      "at ${convertTime(snapshot.data![index].createdAt!.toString().substring(11, 16))}",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    )
                                  : Text(
                                      "at ${convertTime(snapshot.data![index].createdAt!.toString().substring(11, 16))}"),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(
                              right: 8.0,
                              left: 10.0,
                              bottom: 8.0,
                              top: 4.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Recommendation ID: "),
                                Text(
                                  "${snapshot.data![index].recommendationId}",
                                  style: TextStyle(
                                    fontSize: 12.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
