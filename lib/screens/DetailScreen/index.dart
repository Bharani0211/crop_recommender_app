import 'package:crop_recommender/components/pdfApi.dart';
import 'package:crop_recommender/model/recommendModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  static String routeName = "/detailScreen";
  const DetailScreen({Key? key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
    getdata();
    data = getRecommendation();
  }

  late String username;
  late String email;
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('username'));
    print(prefs.getString('email'));
    setState(() {
      username = prefs.getString('username')!;
      email = prefs.getString('email')!;
    });
  }

  convertTime(String time) {
    String d;
    int hour;
    d = time;
    hour = int.parse(d.substring(0, 2));
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
    final Map<String, int>? map =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>?;
    final int? value = map!["index"];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 16,
          onPressed: () {
            print(ModalRoute.of(context)!.settings.name);
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Detail screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<RecommendationModel>>(
              future: data!,
              builder: (BuildContext context,
                  AsyncSnapshot<List<RecommendationModel>> snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            left: 8.0,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "CSV file uploaded on:",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                " ${snapshot.data![value!].createdAt!.toString().substring(0, 10)}, ",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              (int.parse(snapshot.data![value].createdAt!
                                              .toString()
                                              .substring(11, 13)) >=
                                          1) &&
                                      (int.parse(snapshot
                                              .data![value].createdAt!
                                              .toString()
                                              .substring(11, 13)) <=
                                          11)
                                  ? Text(
                                      "at ${convertTime(snapshot.data![value].createdAt!.toString().substring(11, 16))}",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )
                                  : Text(
                                      "at ${convertTime(snapshot.data![value].createdAt!.toString().substring(11, 16))}",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            left: 8.0,
                          ),
                          child: Text(
                            "ID : ${snapshot.data![value].recommendationId}",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DataTable(
                          columns: <DataColumn>[
                            DataColumn(
                                label: Text("Algorithm"),
                                numeric: false,
                                onSort: (i, b) {},
                                tooltip: "Name of the algorithm"),
                            DataColumn(
                                label: Text("Crop"),
                                numeric: false,
                                onSort: (i, b) {},
                                tooltip: "Name of the crop"),
                            DataColumn(
                                label: Text("Accuracy"),
                                numeric: false,
                                onSort: (i, b) {
                                  print("$i $b");
                                  setState(() {});
                                },
                                tooltip: "Accuracy of the crop"),
                          ],
                          rows: <DataRow>[
                            DataRow(cells: <DataCell>[
                              DataCell(Text("Naive Bayes")),
                              DataCell(Text(
                                  "${snapshot.data![value].data![0].naiveBayes!.crop}")),
                              DataCell(Text(
                                  "${snapshot.data![value].data![0].naiveBayes!.accuracy}")),
                            ]),
                            DataRow(cells: <DataCell>[
                              DataCell(Text("KNN")),
                              DataCell(Text(
                                  "${snapshot.data![value].data![1].knn!.crop}")),
                              DataCell(Text(
                                  "${snapshot.data![value].data![1].knn!.accuracy}")),
                            ]),
                            DataRow(cells: <DataCell>[
                              DataCell(Text("Decision tree")),
                              DataCell(Text(
                                  "${snapshot.data![value].data![2].decisionTree!.crop}")),
                              DataCell(Text(
                                  "${snapshot.data![value].data![2].decisionTree!.accuracy}")),
                            ]),
                            DataRow(cells: <DataCell>[
                              DataCell(Text("Random forest")),
                              DataCell(Text(
                                  "${snapshot.data![value].data![3].randomForest!.crop}")),
                              DataCell(Text(
                                  "${snapshot.data![value].data![3].randomForest!.accuracy}")),
                            ]),
                            DataRow(cells: <DataCell>[
                              DataCell(Text("Logistic regression")),
                              DataCell(Text(
                                  "${snapshot.data![value].data![4].logisticRegression!.crop}")),
                              DataCell(Text(
                                  "${snapshot.data![value].data![4].logisticRegression!.accuracy}")),
                            ]),
                          ],
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 28.0,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.black87,
                                primary: Colors.black,
                                minimumSize: Size(150, 45),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              onPressed: () async {
                                var algo = [
                                  "Naive Bayes",
                                  "KNN",
                                  "Decision tree",
                                  "Random forest",
                                  "Logistic regression"
                                ];
                                var crop = [
                                  "${snapshot.data![value].data![0].naiveBayes!.crop}",
                                  "${snapshot.data![value].data![1].knn!.crop}",
                                  "${snapshot.data![value].data![2].decisionTree!.crop}",
                                  "${snapshot.data![value].data![3].randomForest!.crop}",
                                  "${snapshot.data![value].data![4].logisticRegression!.crop}",
                                ];
                                var accuracy = [
                                  "${snapshot.data![value].data![0].naiveBayes!.accuracy}",
                                  "${snapshot.data![value].data![1].knn!.accuracy}",
                                  "${snapshot.data![value].data![2].decisionTree!.accuracy}",
                                  "${snapshot.data![value].data![3].randomForest!.accuracy}",
                                  "${snapshot.data![value].data![4].logisticRegression!.accuracy}",
                                ];
                                var time = snapshot.data![value].createdAt!
                                    .toIso8601String();

                                var recommendation_id =
                                    "${snapshot.data![value].recommendationId}";
                                final data = [
                                  algo,
                                  crop,
                                  accuracy,
                                ];
                                final times = [
                                  time,
                                  DateTime.now().toIso8601String()
                                ];
                                final pdfFile = await PdfApi.generatePdf(data,
                                    times, username, email, recommendation_id);

                                PdfApi.openFile(pdfFile);
                              },
                              child: Text(
                                "Download report",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
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
          ],
        ),
      ),
    );
  }
}
