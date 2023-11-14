import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:second/SCREEN/homepage/transfer.dart';

class Home extends StatefulWidget {
  final String firstName;
  const Home({required this.firstName});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;
  //colors
  var _purple = Colors.teal.shade700;
  var _background = Colors.white12;
  var button_color = Colors.purple;
  var container_colour = Colors.white;
  var _iconcolor = Colors.blue.shade800;
  bool obs = true;
  String nickname = "Nickname";
  String myuser= "Username";
  String obsbalance ="* * * *";
  double userbalance = 0.00;
  @override
  void initState(){
    super.initState();
    getUserBalance();
  }

  Future<void> getUserBalance() async {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getUserBalance');

    try {
      final HttpsCallableResult result = await callable.call();
      final Map<String, dynamic> data = result.data as Map<String, dynamic>;

      final double balance = data['balance'] as double;

      // Return the balance value
      setState(() {
        userbalance = balance;
      });
      print("balance is $balance");
    } catch (e) {
      print('Error getting user balance: $e');
      // Return a default value or handle the error as needed
      throw e; // Re-throw the error or return a default value
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation:0,
        backgroundColor: Colors.teal.shade800,
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //profile icon
            InkWell(
              onTap: (){

              },
              child: Container(
                height: 40,
                width: 40,
                //color: Colors.grey,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/profile.jpg")
                    ),
                    color: Colors.grey,
                    shape: BoxShape.circle,


                ),
                child: SizedBox(height: 50,width: 50,),
              ),
            ),
            SizedBox(width: 15),
            Text(
              nickname,
              style: TextStyle(
                  color: Colors.black54
              ),
            )
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: getUserBalance,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //welcome container
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _purple
                ),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                constraints: BoxConstraints(minWidth: double.infinity),
                height: 165,
                //color: Colors.purple[200],
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Welcome back,",
                      style: TextStyle(fontSize: 15,color: Colors.black45),
                    ),
                    Text(
                        widget.firstName,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text(obs?
                            "Balance: $obsbalance":
                            "Balance: $userbalance",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        IconButton(
                            onPressed: (){
                              setState(() {obs=!obs;});
                        },  icon: obs? Icon(Icons.visibility_off_outlined,color: Colors.white):
                              Icon(Icons.visibility_outlined,color: Colors.white,)
                        ),
                      ],
                    )
                  ],
                ) ,
              ),

              //transaction container
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                constraints: BoxConstraints(minWidth: double.infinity),
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children:<Widget> [
                        Expanded(child: Container(
                          height: 50,
                          child: OutlinedButton(onPressed: (){},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.account_balance_outlined,color: _iconcolor,),
                                  Text("Deposit",style: TextStyle(color: Colors.black,)),
                                ],
                              )),
                        )),
                        SizedBox(width: 20),
                        Expanded(child: Container(
                          height: 50,
                          child: OutlinedButton(onPressed: (){},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.monetization_on_outlined,color: _iconcolor),
                                  Text("Withdraw",style: TextStyle(color: Colors.black)),
                                ],
                              )),
                        ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children:<Widget> [
                        Expanded(child: Container(
                          height: 50,
                          child: OutlinedButton(onPressed: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => Transfer()));
                          },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.swap_horiz_outlined,color:_iconcolor),
                                  Text("Transfer",style: TextStyle(color: Colors.black),),
                                ],
                              )),
                        )),
                        SizedBox(width: 20),
                        Expanded(child: Container(
                          height: 50,
                          child: OutlinedButton(onPressed: (){},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.credit_card_outlined,color: _iconcolor),
                                  Text("Pay",style: TextStyle(color: Colors.black)),
                                ],
                              )),
                        ))
                      ],
                    )
                  ],
                ),
              ),

              //picks for you container
              InkWell(
                onTap: (){},
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.only(top:5,bottom: 20,left:20,right: 20),
                  constraints: BoxConstraints(minWidth: double.infinity),
                  height: 180,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("TOP PICKS FOR YOU",style: TextStyle(color: _purple)),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(top:5,bottom: 20,left:20,right: 20),
                constraints: BoxConstraints(minWidth: double.infinity,minHeight: 180),
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text("RECENT ACTIVITY",style: TextStyle(color: _purple)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
