import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:test_mongo/screen/home_page.dart';

// DBConnection db = DBConnection.getInstance();
var db = Db("mongodb://10.0.2.2:27017/test");

final FirebaseAuth auth = FirebaseAuth.instance;
final Future<FirebaseApp> _initialization = Firebase.initializeApp();
User authUser = auth.currentUser;

final uid = authUser.uid;
void main() async {
  await db.open();
  // await db.open();
  // await DBConnection.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        // Initialize FlutterFire
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            // return SomethingWentWrong();
            print('Something went wrong in Flutter Fire');
          }
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MyHomePage();
          }
          // Otherwise, show something whilst waiting for initialization to complete
          //TODO: Change for splash just in case
          return Container();
        },
      ),
    );
  }
}
