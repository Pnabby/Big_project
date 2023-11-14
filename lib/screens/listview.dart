import 'package:flutter/material.dart';

class Listview extends StatelessWidget {
  Listview({super.key});

  List<String> products = ["Bed", "Sofa", "Chair"];
  List<String> productDetails =["King size bed", "King size sofa", "Wooden"];
  List<int> price = [300,2500,1860];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My title"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,//this centers all elements of the stack
          children: [
            Container(
              width: 300,
              height: 200,
              color: Colors.green,

            ),
            Positioned(//this allows us to specify the position of a particular content
              bottom: 0,
              child: Container(
                width: 200,
                height: 100,
                color: Colors.yellow,
              ),
            )
          ],
        ),
      ),
    );
  }
}

