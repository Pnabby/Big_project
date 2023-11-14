import 'dart:ffi';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 7.0,
        backgroundColor: Colors.blueAccent,
        title: Text("My title"),
      ),
      body: Container(

        width: 400.0,
        height: 250.0,
        padding: EdgeInsets.all(20.0),//EdgeInsets.only is used if padding is to be added to one side
        margin: EdgeInsets.all(20.0),
        alignment: Alignment.center,//the alignment is for the content of the container
        //constraints:
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
          /*border: Border.all(
            color: Colors.grey,
            width: 6.0,
            style: BorderStyle.solid,
          ),*/
          boxShadow: [
            BoxShadow(
              blurRadius: 7,
              spreadRadius: 5,
              offset: Offset(4,4),
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
                "Hello world!!",
              style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.brown),
                ),
                onPressed: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text("logout")

            )
          ],
        ),
      )
    );
  }
}

int getNumber(){
  Random random = new Random();
  var number = random.nextInt(10);
  return number;
}