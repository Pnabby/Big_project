import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:second/firebase_options.dart';
import 'package:second/form.dart';
import 'package:second/SCREEN/Entry.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();//ensures initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyStatelessClass());
}

//stateless class
class MyStatelessClass extends StatelessWidget {
  const MyStatelessClass({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyStatefulClass(), //calling the stateful class in the stateless class
      ),
    );
  }
}

//stateful class
class MyStatefulClass extends StatefulWidget {
  const MyStatefulClass({super.key});

  @override
  State<MyStatefulClass> createState() => _MyStatefulClassState();
}

class _MyStatefulClassState extends State<MyStatefulClass> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Testing",
      theme: ThemeData.light(),
      home: Login_Page(),
    );
  }
}

