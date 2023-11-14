import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: (){},//when onpressed is set to null, button is disabled
          icon: Icon(Icons.lightbulb),//wrap with direction and make direction ltr to change pos of text and icon
          label: Text("let's begin"),
          //child: Text("let's begin"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            fixedSize: Size(300,80),
            textStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            primary: Colors.orange,//colour of button
            onPrimary: Colors.black,//colour of content of button
            elevation: 7,
            shadowColor: Colors.orange,
            side: BorderSide(color: Colors.black,width: 2),//describing border
            //alignment: Alignment.bottomCenter
            shape: StadiumBorder()

          ),
        ),
      ),
    );
  }
}
