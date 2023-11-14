import 'package:flutter/material.dart';
import 'package:second/SCREEN/Login.dart';
import 'package:second/SCREEN/Signup.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Container(

          //width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 100,),
            Text(
                "Welcome to my First App",
              style: TextStyle(color: Colors.black, fontSize: 23,fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                },
                child: Text(
                    "SIGN IN",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  minimumSize: Size(150, 50),
                  shape: StadiumBorder(),
                  elevation: 10,
                )

            ),
            SizedBox(height: 15,),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                },
                child: Text(
                    "SIGN UP",
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  minimumSize: Size(150, 50),
                  shape: StadiumBorder(),
                  elevation: 10,
                ),
            ),
            SizedBox(height: 20,),
            //for my bottom icons
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.call)),
                    Text("Contact us")
                  ],
                ),
                SizedBox(width: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.help)),
                    Text("FAQs")
                  ],
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}
