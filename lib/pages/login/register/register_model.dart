// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);
import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    required this.status,
    required this.responseData,
  });

  bool status;
  ResponseData responseData;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    status: json["status"],
    responseData: ResponseData.fromJson(json["responseData"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "responseData": responseData.toJson(),
  };
}

class ResponseData {
  ResponseData({
    required this.challenge,
    required this.message,
    required this.data,
    required this.token,
    required this.login,
    required this.trainingData,
  });

  Challenge challenge;
  String message;
  Data data;
  String token;
  String login;
  TrainingData trainingData;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    challenge: Challenge.fromJson(json["challenge"]),
    message: json["message"],
    data: Data.fromJson(json["data"]),
    token: json["token"],
    login: json["login_type"],
    trainingData: TrainingData.fromJson(json["trainingData"]),
  );

  Map<String, dynamic> toJson() => {
    "challenge": challenge.toJson(),
    "message": message,
    "data": data.toJson(),
    "token": token,
    "login_type": login,
    "trainingData": trainingData.toJson(),
  };
}

class Challenge {
  Challenge({
    required this.isDaily,
    required this.active,
    required this.name,
    required this.noOfDays,
    required this.id,
    required this.logData,
  }) {
    // TODO: implement
    throw UnimplementedError();
  }

  String isDaily;
  String active;
  String name;
  String noOfDays;
  String id;
  List<dynamic> logData;

  factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
    isDaily: json["is_daily"],
    active: json["active"],
    name: json["name"],
    noOfDays: json["no_of_days"],
    id: json["id"],
    logData: List<dynamic>.from(json["logData"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "is_daily": isDaily,
    "active": active,
    "name": name,
    "no_of_days": noOfDays,
    "id": id,
    "logData": List<dynamic>.from(logData.map((x) => x)),
  };
}

class Data {
  Data({
    required this.userStatus,
    required this.showNotification,
    required this.muteNotification,
    required this.id,
    required this.email,
    required this.username,
    required this.deviceType,
    required this.deviceToken,
    this.personalInfo,
  });

  String userStatus;
  String showNotification;
  String muteNotification;
  String id;
  String email;
  String username;
  String deviceType;
  String deviceToken;
  dynamic personalInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userStatus: json["userStatus"],
    showNotification: json["show_notification"],
    muteNotification: json["mute_notification"],
    id: json["id"],
    email: json["email"],
    username: json["username"],
    deviceType: json["device_type"],
    deviceToken: json["device_token"],
    personalInfo: json["personalInfo"],
  );

  Map<String, dynamic> toJson() => {
    "userStatus": userStatus,
    "show_notification": showNotification,
    "mute_notification": muteNotification,
    "id": id,
    "email": email,
    "username": username,
    "device_type": deviceType,
    "device_token": deviceToken,
    "personalInfo": personalInfo,
  };
}

class TrainingData {
  TrainingData();

  factory TrainingData.fromJson(Map<String, dynamic> json) => TrainingData(
  );

  Map<String, dynamic> toJson() => {
  };
}
