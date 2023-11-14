import 'dart:html';

import 'package:flutter/material.dart';

void main()=> runApp(StatelessClass());
class StatelessClass extends StatelessWidget {
  const StatelessClass({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(

      ),
    );
  }
}

class StatefulClass extends StatefulWidget {
  const StatefulClass({super.key});

  @override
  State<StatefulClass> createState() => _StatefulClassState();
}

class _StatefulClassState extends State<StatefulClass> {
  bool liked = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text("Nike shoes"),
          trailing: IconButton(
            icon:liked? (Icon(Icons.favorite_border)) : (Icon(Icons.favorite)),//simple if and else
            onPressed: (){
              setState(() {
                liked = !liked;
              });
            },
          ),
        )
      ],
    );
  }
}

