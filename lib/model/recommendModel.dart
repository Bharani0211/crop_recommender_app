import 'dart:convert';

List<RecommendationModel> recommendationModelFromJson(String str) =>
    List<RecommendationModel>.from(
        json.decode(str).map((x) => RecommendationModel.fromJson(x)));

String recommendationModelToJson(List<RecommendationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecommendationModel {
  RecommendationModel({
    this.recommendationId,
    this.createdAt,
    this.data,
  });

  String? recommendationId;
  DateTime? createdAt;
  List<Datum>? data;

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      RecommendationModel(
        recommendationId: json["recommendation_id"],
        createdAt: DateTime.parse(json["created_at"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recommendation_id": recommendationId,
        "created_at": createdAt!.toIso8601String(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.naiveBayes,
    this.knn,
    this.decisionTree,
    this.randomForest,
    this.logisticRegression,
  });

  DecisionTree? naiveBayes;
  DecisionTree? knn;
  DecisionTree? decisionTree;
  DecisionTree? randomForest;
  DecisionTree? logisticRegression;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        naiveBayes: json["naive_bayes"] == null
            ? null
            : DecisionTree.fromJson(json["naive_bayes"]),
        knn: json["knn"] == null ? null : DecisionTree.fromJson(json["knn"]),
        decisionTree: json["decision_tree"] == null
            ? null
            : DecisionTree.fromJson(json["decision_tree"]),
        randomForest: json["random_forest"] == null
            ? null
            : DecisionTree.fromJson(json["random_forest"]),
        logisticRegression: json["logistic_regression"] == null
            ? null
            : DecisionTree.fromJson(json["logistic_regression"]),
      );

  Map<String, dynamic> toJson() => {
        "naive_bayes": naiveBayes == null ? null : naiveBayes!.toJson(),
        "knn": knn == null ? null : knn!.toJson(),
        "decision_tree": decisionTree == null ? null : decisionTree!.toJson(),
        "random_forest": randomForest == null ? null : randomForest!.toJson(),
        "logistic_regression":
            logisticRegression == null ? null : logisticRegression!.toJson(),
      };
}

class DecisionTree {
  DecisionTree({
    required this.crop,
    required this.accuracy,
  });

  String? crop;
  String? accuracy;

  factory DecisionTree.fromJson(Map<String, dynamic> json) => DecisionTree(
        crop: json["crop"],
        accuracy: json["accuracy"],
      );

  Map<String, dynamic> toJson() => {
        "crop": crop,
        "accuracy": accuracy,
      };
}
