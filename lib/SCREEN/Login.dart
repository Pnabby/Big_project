import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:second/SCREEN/Dashboard/Home.dart';
import 'package:second/SCREEN/Dashboard/movement.dart';
import 'package:second/firebase_auth_implementation/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;
  bool obscure = true;
  var email,name;
  var pswd;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  User? _user;
  handleloginsubmit()async{
    //if(!(email == null) && !(pswd == null)){
      final emaill = _emailController.value.text.trim();
      final password = _passwordController.value.text;
      setState(() {
        loading = true;
      });
      try{
        await FirebaseAuthService().signInWithEmailAndPassword(
            emaill, password);
        final user = FirebaseAuth.instance.currentUser;
        if(user != null){
          name = user.displayName;


          print(user.email);
        }
        setState(() {
          loading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>Movement(
          firstName: name,
        )));
        //Navigator.pop(context);
      }
      catch(error){
        print(error);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please check your email and password.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
      finally{
        setState(() {
          loading = false;
        });
      }
    //}
  }
  void update_email(val){
    setState(() {
      email = val;
    });
  }
  void update_password(val){
    setState(() {
      pswd = val;
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
            "Sign In",
          style: TextStyle(color: Colors.purple),
        ),
      ),
      body:SingleChildScrollView(child:
      Column(
        children: [
          SizedBox(height: 150,),
          Text(
              "SIGN IN",
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.purple

            ),
          ),
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailController,
              onChanged: (val){
                update_email(val);
              },
              decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder()
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: obscure,
              controller: _passwordController,
              onChanged: (val){
                update_password(val);
              },
              decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.key),
                  suffixIcon: IconButton(
                      icon: obscure?
                      Icon(Icons.visibility_off):Icon(Icons.visibility),
                      onPressed: (){
                        setState(() {
                          obscure = !obscure;
                        });
                      }
                  ),
                  border: OutlineInputBorder()
              ),
            ),
          ),
          //i will add a remember me checkbox here
          SizedBox(height: 20,),
          Text(
              "I forgot my password",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 15,
              ),

          ),
          SizedBox(height: 120,),
          ElevatedButton(
              onPressed: (){
                handleloginsubmit();
              },
              child: loading?const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ):
              Text("Proceed"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                minimumSize: Size(350, 50),
                elevation: 10,
              ),
          )

        ],
      ),
      ),
    );
  }
}
