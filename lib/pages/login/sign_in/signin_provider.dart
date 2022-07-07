import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_mvvm_structure/pages/login/sign_in/signin.dart';
import 'package:flutter_mvvm_structure/pages/login/sign_in/signin_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../app/utils/shared_pref.dart';
import '../../dash_board_page/dash_board_page.dart';

enum SignInTypeStatus {
   initial,success,waiting,failure
}

final FirebaseAuth auth = FirebaseAuth.instance;
final facebookLogin = FacebookLogin();

class SignInProvider extends ChangeNotifier {
   SignInScreenState? state;
   final GoogleSignIn googleSignIn;
   final FirebaseAuth firebaseAuth;
   final FirebaseFirestore firebaseFirestore;
   final SharedPreferences prefs;

   SignInTypeStatus _status = SignInTypeStatus.initial;

   SignInTypeStatus get status => _status;


   SignInProvider(
       {
          required this.firebaseAuth,
          required this.googleSignIn,
          required this.prefs,
          required this.firebaseFirestore,}
       );



   String getUserFirebaseId() {
      return getPrefStringValue(KEY_ID);
   }

   Future<bool> signinWithGoogle({dynamic state}) async {
      _status = SignInTypeStatus.waiting;
      notifyListeners();
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
         GoogleSignInAuthentication googleAuth = await googleUser.authentication;
         final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
         );
         User? firebaseUser = (await FirebaseAuth.instance.signInWithCredential(
             credential))
             .user;

         if (firebaseUser != null) {
            final QuerySnapshot result = await firebaseFirestore
                .collection("Users").where("id", isEqualTo: firebaseUser.uid).get();
            final List<DocumentSnapshot> documents = result.docs;
            if (documents.isEmpty) {
               // Writing data to server because here is a new user
               firebaseFirestore.collection("Users").doc(firebaseUser.uid).set({
                  "Email": firebaseUser.email,
                  "Username": firebaseUser.displayName,
                  "photoUrl": firebaseUser.photoURL,
                  "id": firebaseUser.uid,
               });

               // Write data to local storage
               User currentUser = firebaseUser;
               await setPrefStringValue(KEY_ID      , currentUser.uid);
               await setPrefStringValue(KEY_USERNAME, currentUser.displayName ?? "");
               await setPrefStringValue(KEY_PHOTOURL, currentUser.photoURL ?? "");
               await setPrefStringValue(KEY_EMAIL, currentUser.email ?? "");
            } else {
               // Already sign up, just get data from firestore
               DocumentSnapshot documentSnapshot = documents[0];
               // ignore: non_constant_identifier_names
               SignInScreenModel SignInType = SignInScreenModel.fromDocument(documentSnapshot);
               // Write data to local
               await setPrefStringValue(KEY_ID      , SignInType.id);
               await setPrefStringValue(KEY_USERNAME, SignInType.Username);
               await setPrefStringValue(KEY_PHOTOURL, SignInType.photoUrl);
               await setPrefStringValue(KEY_EMAIL, SignInType.Email ?? "");
            }
            await setPrefBoolValue(KEY_SOCIAL_LOGIN,true);
            _status = SignInTypeStatus.success;
            Navigator.push(state.context, MaterialPageRoute(builder: (context) => const DashboardPage()));
            notifyListeners();
           // Navigator.push(state.context, MaterialPageRoute(builder: (context) => DashboardPage()));
            return true;
         } else {
            await setPrefBoolValue(KEY_SOCIAL_LOGIN,false);
            _status = SignInTypeStatus.failure;
            notifyListeners();
            return false;
         }
      }
      else {
         await setPrefBoolValue(KEY_SOCIAL_LOGIN,false);
         _status = SignInTypeStatus.failure;
         print("====>USER NOT GET USER");
         notifyListeners();
         return false;
      }
   }


   Future<bool> signinWithFacebook({dynamic state}) async {
      _status = SignInTypeStatus.waiting;
      notifyListeners();
      final result = await facebookLogin.logIn(['email']);
      final token = result.accessToken.token;
      final graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token'));
      final profile = json.decode(graphResponse.body);
      if(profile!=null){
         print("GET INTRO PAGE =+++++++>>>>>>>${facebookLogin.isLoggedIn}");
         print("PROFILE OF FACEBOOK EMAIL===>${profile["email"]}");
         print("PROFILE OF FACEBOOK NAME===>${profile["picture"]["data"]["url"]}");
         print("PROFILE OF FACEBOOK ID===>${profile["id"]}");
         final QuerySnapshot result = await firebaseFirestore
             .collection("Users")
             .where("id", isEqualTo: profile["id"])
             .get();
         final List<DocumentSnapshot> documents = result.docs;
         if (documents.isEmpty) {
            // Writing data to server because here is a new user
            firebaseFirestore.collection("Users").doc(profile["id"]).set({
               "Email": profile["email"],
               "Username": profile["name"],
               "photoUrl": profile["picture"]["data"]["url"],
               "id": profile["id"],
            });

            // Write data to local storage
            await setPrefStringValue(KEY_EMAIL, profile["email"] ?? "");
            await setPrefStringValue(KEY_ID      , profile["id"]??"");
            await setPrefStringValue(KEY_USERNAME,profile["name"]?? "");
            await setPrefStringValue(KEY_PHOTOURL,profile["picture"]["data"]["url"]?? "");
         } else {
            // Already sign up, just get data from firestore
            DocumentSnapshot documentSnapshot = documents[0];
            // ignore: non_constant_identifier_names
            SignInScreenModel SignInType = SignInScreenModel.fromDocument(documentSnapshot);
            // Write data to local
            await setPrefStringValue(KEY_ID      , SignInType.id);
            await setPrefStringValue(KEY_USERNAME, SignInType.Username);
            await setPrefStringValue(KEY_PHOTOURL, SignInType.photoUrl);
            await setPrefStringValue(KEY_EMAIL, SignInType.Email);
         }
         await setPrefBoolValue(KEY_SOCIAL_LOGIN,true);
         _status = SignInTypeStatus.success;
         notifyListeners();
        // Navigator.push(state.context, MaterialPageRoute(builder: (context) => DashboardPage()));
         return true;
      }else{
         await setPrefBoolValue(KEY_SOCIAL_LOGIN,false);
         _status = SignInTypeStatus.failure;
         print("====>USER NOT GET USER");
         notifyListeners();
         return false;
      }
   }

   Future signInWithApple({dynamic state}) async {
      _status = SignInTypeStatus.waiting;
      final appleIdCredential = await SignInWithApple.getAppleIDCredential(
         scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
         ],
      );
      final oAuthProvider = OAuthProvider('apple.com');
      final credential =
      oAuthProvider.credential(
         idToken: appleIdCredential.identityToken,
         accessToken: appleIdCredential.authorizationCode,
      );
      // use the credential to sign in to firebase
      UserCredential firebaseUser = await FirebaseAuth.instance.signInWithCredential(credential);
      // ignore: unnecessary_null_comparison
      if(firebaseUser.user!.uid !=null){
         print("PROFILE OF FACEBOOK EMAIL===>${firebaseUser.user!.email}");
         print("PROFILE OF FACEBOOK NAME===>${firebaseUser.user!.displayName}");
         print("PROFILE OF FACEBOOK ID===>${firebaseUser.user!.uid}");
         final QuerySnapshot result = await firebaseFirestore
             .collection("Users")
             .where("id", isEqualTo:firebaseUser.user!.uid)
             .get();
         final List<DocumentSnapshot> documents = result.docs;
         if (documents.isEmpty) {
            // Writing data to server because here is a new user
            firebaseFirestore.collection("Users").doc(firebaseUser.user!.uid).set({
               "Email": firebaseUser.user!.email,
               "Username":firebaseUser.user!.displayName,
               "photoUrl":firebaseUser.user!.photoURL,
               "id":firebaseUser.user!.uid,
            });

            // Write data to local storage
            await setPrefStringValue(KEY_EMAIL,firebaseUser.user!.email ?? "");
            await setPrefStringValue(KEY_ID, firebaseUser.user?.uid ?? "");
            await setPrefStringValue(KEY_USERNAME,firebaseUser.user!.displayName?? "");
            await setPrefStringValue(KEY_PHOTOURL,firebaseUser.user!.photoURL?? "");
         } else {
            // Already sign up, just get data from firestore
            DocumentSnapshot documentSnapshot = documents[0];
            // ignore: non_constant_identifier_names
            SignInScreenModel SignInScreen = SignInScreenModel.fromDocument(documentSnapshot);
            // Write data to local
            await setPrefStringValue(KEY_ID      , SignInScreen.id);
            await setPrefStringValue(KEY_USERNAME, SignInScreen.Username);
            await setPrefStringValue(KEY_PHOTOURL, SignInScreen.photoUrl);
            await setPrefStringValue(KEY_EMAIL, SignInScreen.Email);
         }
         await setPrefBoolValue(KEY_SOCIAL_LOGIN,true);
         _status = SignInTypeStatus.success;
         notifyListeners();
        // Navigator.push(state.context, MaterialPageRoute(builder: (context) => DashboardPage()));
         return true;
      }
      else{
         await setPrefBoolValue(KEY_SOCIAL_LOGIN,false);
         _status = SignInTypeStatus.failure;
         print("fiubndjfdhgtgddgnutgt====>USER NOT GET USER");
         notifyListeners();
         return false;
      }
   }

   // ignore: non_constant_identifier_names
   Future<bool> Logout() async {
      print("GOOGLE LOGOUT IS CALLED");
      print("GET INTRO PAGE ${await getPrefStringValue(KEY_ID)}");
      if (await googleSignIn.isSignedIn() && getPrefStringValue(KEY_ID).toString()!="") {
         _status = SignInTypeStatus.waiting;
         notifyListeners();
         await googleSignIn.disconnect();
         await googleSignIn.signOut();
         _status = SignInTypeStatus.success;
         notifyListeners();
         return true;
      } else if (await facebookLogin.isLoggedIn && getPrefStringValue(KEY_ID).toString()!="") {
         _status = SignInTypeStatus.waiting;
         notifyListeners();
         await facebookLogin.logOut();
         _status = SignInTypeStatus.success;
         return true;
      }
      else if (await SignInWithApple.isAvailable() &&getPrefStringValue(KEY_ID).toString()!="") {
         _status = SignInTypeStatus.waiting;
         notifyListeners();
         await firebaseAuth.signOut();
         _status = SignInTypeStatus.success;
         notifyListeners();
         return true;
      }
      else if (getPrefStringValue(KEY_ID).toString()!="") {
         _status = SignInTypeStatus.waiting;
         notifyListeners();
         await firebaseAuth.signOut();
         _status = SignInTypeStatus.success;
         notifyListeners();
         return true;
      }
      else{
         return false;
      }
   }
}
