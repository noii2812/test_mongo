import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_mongo/main.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List list = [];

  Future getList() async {
    // db.open();
    db.collection("category").find().forEach((element) {
      setState(() {});
      list.add(element);
    });
    // return list;
  }

  Future insertDoc() async {
    await db.collection("category").insert({"name": "millk"});
  }

  Future deleteDoc() async {
    var val = await db.collection("category").deleteOne({"name": "milk"});
    print(val.writeError);
  }

  @override
  void initState() {
    // getList();
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Column(
        children: [
          Text('name'),
          TextField(
            controller: nameController,
          ),
          Text('age'),
          TextField(
            controller: ageController,
          ),
          InkWell(
            onTap: () {
              FirebaseFirestore.instance.collection('people').add({
                'name': '${nameController.text}',
                "age": ageController.text
              }).whenComplete(() {
                setState(() {
                  nameController.clear();
                  ageController.clear();
                });
              });
            },
            child: Container(
              width: 150,
              height: 50,
              color: Colors.yellow,
              child: Center(child: Text("ADD User")),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('people').snapshots(),
              builder: (context, snapshot) {
                print(snapshot.data.docs);
                return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (_, index) => ListTile(
                          title: Text('name'),
                          subtitle: Text('age'),
                        ));
              }
            ),
          )
        ],
      ),
    );
  }
}
