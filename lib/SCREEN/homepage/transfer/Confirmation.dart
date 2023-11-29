import 'package:flutter/material.dart';


class Confirmation extends StatefulWidget {
  final fullname;
  final payId;
  const Confirmation({required this.fullname,required this.payId});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  final TextEditingController amount_controller = TextEditingController();
  final TextEditingController ref_controller = TextEditingController();
  bool fav = false;//later add check to see if among favourite
  @override
  Widget build(BuildContext context) {
    //should contain full name, pay id and user name
    //should have a textbox to enter amount
    // set pin
    return Scaffold(
      appBar: AppBar(
        title: Text("Review and Send"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal[800],
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(minWidth: double.infinity,minHeight: 120),
              child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.fullname,
                      style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.bold ),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("PAY ID: ",
                          style: TextStyle(color: Colors.white,fontSize:16,),
                        ),
                        Text(widget.payId,
                          style: TextStyle(color: Colors.white,fontSize:16,),
                        ),
                      ],
                    )
                  ],
                ),
            ),
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter Amount"
                ),
                controller: amount_controller,
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height:10),
            Container(
              margin: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Enter Reference (optional)"
                ),
                controller: ref_controller,
              ),
            ),
            SizedBox(height: 5,),
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add to favourites",style: TextStyle(fontSize: 17,color: Colors.grey[800]),),
                  Switch(
                    activeColor: Colors.teal,
                      value: fav,
                      onChanged: (value){
                        setState(() {
                          fav = value;
                        });
                      }
                  )
                ],
              ),
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(15),
                    child: ElevatedButton(onPressed: (){},
                        child:Text("Confirm and transfer",style: TextStyle(fontSize: 20),),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal[800]),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//20231018141458897