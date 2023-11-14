import 'package:flutter/material.dart';
import 'package:second/details.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  var email;
  void update_text(val){
    setState(() {
      email = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form"),
        centerTitle: true,
      ),
      body:Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              onChanged: (val){
                update_text(val);
              },
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder()
              ),
            ),
            Text("Product name is $email")
          ],
        ),
      )
   );
  }

  OutlinedButton myBtn(BuildContext context) {
    return OutlinedButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder:(context){
                  return Details();
                },
              )
         );//to switch between screens
        },
        child: Text(
            "Submit Form".toUpperCase(),
            style:const TextStyle(fontWeight: FontWeight.bold),
        ),
        //style: OutlinedButton.styleFrom(minimumSize: const Size(200, 500),),
    );
  }
}
