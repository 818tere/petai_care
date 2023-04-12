// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

ImageModel imageModelFromJson(String str) =>
    ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  ImageModel({
    required this.version,
    required this.requestId,
    required this.timestamp,
    required this.images,
  });

  String version;
  String requestId;
  int timestamp;
  List<Image> images;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        version: json["version"],
        requestId: json["requestId"],
        timestamp: json["timestamp"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "requestId": requestId,
        "timestamp": timestamp,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    required this.uid,
    required this.name,
    required this.inferResult,
    required this.message,
    required this.matchedTemplate,
    required this.validationResult,
    required this.fields,
    required this.title,
  });

  String uid;
  String name;
  String inferResult;
  String message;
  MatchedTemplate matchedTemplate;
  ValidationResult validationResult;
  List<Title> fields;
  Title title;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        uid: json["uid"],
        name: json["name"],
        inferResult: json["inferResult"],
        message: json["message"],
        matchedTemplate: MatchedTemplate.fromJson(json["matchedTemplate"]),
        validationResult: ValidationResult.fromJson(json["validationResult"]),
        fields: List<Title>.from(json["fields"].map((x) => Title.fromJson(x))),
        title: Title.fromJson(json["title"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "inferResult": inferResult,
        "message": message,
        "matchedTemplate": matchedTemplate.toJson(),
        "validationResult": validationResult.toJson(),
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
        "title": title.toJson(),
      };
}

class Title {
  Title({
    required this.name,
    required this.bounding,
    this.valueType,
    required this.inferText,
    required this.inferConfidence,
  });

  String name;
  Bounding bounding;
  String? valueType;
  String inferText;
  double inferConfidence;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        name: json["name"],
        bounding: Bounding.fromJson(json["bounding"]),
        valueType: json["valueType"],
        inferText: json["inferText"],
        inferConfidence: json["inferConfidence"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "bounding": bounding.toJson(),
        "valueType": valueType,
        "inferText": inferText,
        "inferConfidence": inferConfidence,
      };
}

class Bounding {
  Bounding({
    required this.top,
    required this.left,
    required this.width,
    required this.height,
  });

  int top;
  int left;
  int width;
  int height;

  factory Bounding.fromJson(Map<String, dynamic> json) => Bounding(
        top: json["top"],
        left: json["left"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "top": top,
        "left": left,
        "width": width,
        "height": height,
      };
}

class MatchedTemplate {
  MatchedTemplate({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory MatchedTemplate.fromJson(Map<String, dynamic> json) =>
      MatchedTemplate(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ValidationResult {
  ValidationResult({
    required this.result,
  });

  String result;

  factory ValidationResult.fromJson(Map<String, dynamic> json) =>
      ValidationResult(
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
      };
}
