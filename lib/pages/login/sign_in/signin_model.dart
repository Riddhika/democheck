import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: empty_catches
// ignore_for_file: non_constant_identifier_names

class SignInScreenModel {
  String? id;
  String? photoUrl;
  String? Username;
  String? FirstName;
  String? LastName;
  String? Email;
  String? Password;
  String? ConformPassword;

  SignInScreenModel({ this.id,  this.photoUrl,  this.Username,this.FirstName,this.LastName,this.Email,this.Password,this.ConformPassword});

  Map<String, dynamic> toJson() {
    return {
      "Username": Username,
      "photoUrl": photoUrl,
      "FirstName": FirstName,
      "LastName": LastName,
      "Email": Email,
      "Password": Password,
      "ConformPasswod": ConformPassword,
    };
  }

  factory SignInScreenModel.fromDocument(DocumentSnapshot doc) {
    String photoUrl = "";
    String UserName = "";
    String FirstName = "";
    String LastName = "";
    String Email = "";
    String Password = "";
    String ConformPassword="";
    try {
      photoUrl = doc.get("photoUrl");
    } catch (e) {}
    try {
      UserName = doc.get("Username");
    } catch (e) {}
    try {
      FirstName = doc.get("FirstName");
    } catch (e) {}
    try {
      LastName = doc.get("LastName");
    } catch (e) {}
    try {
      Email = doc.get("Email");
    } catch (e) {}
    try {
      Password = doc.get("Password");
    } catch (e) {}
    try {
      ConformPassword = doc.get("ConformPasswod");
    } catch (e) {}
    return SignInScreenModel(
      id: doc.id,
      photoUrl: photoUrl,
      Username: UserName,
      FirstName:FirstName,
      LastName:LastName,
      Email: Email,
      Password: Password,
      ConformPassword: ConformPassword,
    );
  }
}
