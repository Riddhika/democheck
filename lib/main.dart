import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/utils/app_constant.dart';
import 'pages/login/sign_in/signin_provider.dart';
import 'pages/splash_screen/splash_screen.dart';

void mainDelegate()async {

WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();

  //todo crash App
  // FirebaseCrashlytics.instance.crash();
  runApp(MyApp());
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({Key? key, this.prefs}) : super(key: key);
// pinal added
  final SharedPreferences? prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    opHeaderColor(color: AppConstant.colorWhite);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>
            SignInProvider(
              firebaseAuth: FirebaseAuth.instance,
              googleSignIn: GoogleSignIn(
                  scopes: [
                    "email",
                    "https://www.googleapis.com/auth/userinfo.profile"
                  ]
              ),
              prefs: prefs!,
              firebaseFirestore: firebaseFirestore,
            )
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen() /*DashboardPage()*/,
      ),
    );
  }
}
