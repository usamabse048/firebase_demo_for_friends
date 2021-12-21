import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String name = "";
  String age = "";
  String churchDocumentId = "";
  final _formKey = GlobalKey<FormState>();

  Future<void> sendData() async {
    String id = firestore.collection("User").doc().id;
    await firestore
        .collection("Users")
        .doc(id)
        .set({"name": name, "age": age, "id": id});
  }

  // TextEditingController _nameController = TextEditingController();
  // TextEditingController _ageController = TextEditingController();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("Name"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                // controller: _nameController,
                onChanged: (value) {
                  name = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Age"),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                // controller: _ageController,
                onChanged: (value) {
                  age = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    sendData();
                  },
                  child: const Text("Submit"))
            ],
          )),
    ));
  }
}
