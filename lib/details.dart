import 'package:flutter/material.dart';
import 'package:second/form.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("leading"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);//this is to remove current screen
          },
        ),
      ),
      body: Center(
        child: Text("Detials Screen"),
      ),
    );
  }
}
