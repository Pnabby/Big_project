//import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:second/SCREEN/Dashboard/movement.dart';
import 'package:second/SCREEN/Login.dart';
import 'package:second/firebase_auth_implementation/firebase_auth_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool obscure = true;
  final bool _islogin = true;
  bool _loading = false;
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  var fname,lname,email,phone,pswd,cpswd;

  //function for user details
  //----------------------------------------------------------------------
  /*Future addUserDetails(
      String firstname,String lastname,String email, String phone
      )async{
    await FirebaseFirestore.instance.collection("Users").add({
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
    });
  }*/
  Future<void> addUserDetailsToFirebase(String firstName, String lastName, String email, String phone) async {
    final data = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
    };

    final response = await http.post(
      Uri.parse("https://us-central1-flutter-login-app-783c2.cloudfunctions.net/addUserDetails"), // Replace with your actual Cloud Function URL
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('User details added to Firestore');
    } else {
      print('Error adding user details to Firestore: ${response.reasonPhrase}');
    }
  }

  //----------------------------------------------------------------------
  handleSubmit() async{
    //will add ability to check if email address has already been used
    if(
    !(email == null) && !(pswd == null) && pswd==cpswd
    && !(fname==null||lname==null||phone==null)
    ) {
        final f_name = _firstnameController.value.text.trim();
        final l_name = _lastnameController.value.text.trim();
        final phone = _phoneController.value.text.trim();
        final emaill = _emailController.value.text.trim();
        final password = _passwordController.value.text;


        setState(() {
          _loading = true;
        });

        //create account
        print("registering!!!!!");
        await FirebaseAuthService().registerWithEmailAndPassword(
            emaill, password);
        final user = FirebaseAuth.instance.currentUser;
        if(user != null) {
          await user?.updateDisplayName("$fname $lname");
          //final fullname = user.displayName;

          //add user details
          //addUserDetails(f_name, l_name, emaill, phone);
          addUserDetailsToFirebase(f_name, l_name, emaill, phone);
        }

        setState(() {
          _loading = false;
        });
        await ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registered successfully'),
              duration: Duration(seconds: 2),
            )
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));

    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all the required details'),
          duration: Duration(seconds: 3),
        )
      );
    }
    //later add the errors


  }
  void update_fname(val){
    setState(() {
      fname = val;
    });
  }
  void update_lname(val){
    setState(() {
      lname = val;
    });
  }
  void update_email(val){
    setState(() {
      email = val;
    });
  }
  void update_phone(val){
    setState(() {
      phone = val;
    });
  }
  void update_pswd(val){
    setState(() {
      pswd = val;
    });
  }
  void update_cpswd(val){
    setState(() {
      cpswd = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple[50],
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.purple,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Sign Up",
          style: TextStyle(color: Colors.purple),
        ),
      ),
      body: SingleChildScrollView(
      child:
      Column(
        children: [
          SizedBox(height: 20,),

          //Firstname
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _firstnameController,
              onChanged: (val){
                update_fname(val);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Firstname",
                  border: OutlineInputBorder()
              ),
            ),
          ),
          SizedBox(height: 20,),

          //lastname
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _lastnameController,
              onChanged: (val){
                update_lname(val);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Lastname",
                  border: OutlineInputBorder()
              ),
            ),
          ),
          SizedBox(height: 20,),

          //Email
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailController,
              validator: (value){
                if (value==null||value.isEmpty){
                  return "Please enter email";
                }
                return null;
              },
              onChanged: (val){
                update_email(val);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email",
                  border: OutlineInputBorder()
              ),
            ),
          ),
          SizedBox(height: 20,),

          //phone
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _phoneController ,
              onChanged: (val){
                update_phone(val);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  labelText: "Phone number",
                  border: OutlineInputBorder()
              ),
            ),
          ),
          SizedBox(height: 20,),

          //pswd
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: obscure,
              controller: _passwordController,
              validator: (value){
                if(value == null||value.isEmpty){
                  return "enter password";
                }
                return null;
              },
              onChanged: (val){
                update_pswd(val);
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                      icon: obscure?
                      Icon(Icons.visibility_off):Icon(Icons.visibility),
                      onPressed: (){
                        setState(() {
                          obscure = !obscure;
                        });
                      }
                  ),
                  labelText: "Password",
                  border: OutlineInputBorder()
              ),
            ),
          ),
          SizedBox(height: 20,),

          //cpswd
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: obscure,
              onChanged: (val){
                update_cpswd(val);
              },
              decoration: InputDecoration(
                  prefixIcon:Icon(Icons.lock) ,
                  suffixIcon: IconButton(
                      icon: obscure?
                      Icon(Icons.visibility_off):Icon(Icons.visibility),
                      onPressed: (){
                        setState(() {
                          obscure = !obscure;
                        });
                      }
                  ),
                  labelText: "Confirm Password",
                  border: OutlineInputBorder()
              ),
            ),
          ),
          SizedBox(height: 20,),
          Text(
              "I already have an account",
            style: TextStyle(color: Colors.blueAccent,fontSize:15),

          ),
          SizedBox(height: 50,),
          ElevatedButton(
            onPressed: (){
              handleSubmit();
            },
            child: _loading?const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )

            :Text("Sign Up"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              minimumSize: Size(400, 50),
              elevation: 10,
            ),
          )
        ],
      ),
    ),
    );
  }
}
