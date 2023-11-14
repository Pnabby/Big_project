import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class Transfer extends StatefulWidget {
  const Transfer({super.key});

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {

  String payId = " ";
  String _scanBarcode =" ";
  bool got_data = false;
  bool selected = true;
  var textselect = 1;
  @override
  void initState(){
    super.initState();
    getPayId();
  }
  Future<void> getPayId() async {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getPayId');

    try {
      final HttpsCallableResult result = await callable.call();
      final Map<String, dynamic> data = result.data as Map<String, dynamic>;

      final String payid = data['payid'] as String;

      // Return the balance value
      setState(() {
        payId = payid;
        got_data = true;
      });
      print("payid is $payid");
    } catch (e) {
      print('Error getting user balance: $e');
      // Return a default value or handle the error as needed
      throw e; // Re-throw the error or return a default value
    }
  }
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
//barcode scanner flutter ant
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  //recieve widget
  late Widget receiveContent = //Text("hello");
  Column(
    children: [
      Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Text("Users can scan with app to transfer coins",
            style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            QrImageView(
              padding: EdgeInsets.all(8),
              data: payId,
              version: QrVersions.auto,
              size: 250,
            ),
            SizedBox(height: 2),
            Text("@username",
              style: TextStyle(fontSize: 17,),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: (){}, child: Text("Save QR Code",
                  style: TextStyle(color: Colors.teal,fontSize: 15),
                )),
                TextButton(onPressed: (){}, child: Text("Share QR Code",
                  style: TextStyle(color: Colors.teal,fontSize: 15),
                ))

              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 10,),

      //payidbox
      Container(
        height: 70,
        constraints: BoxConstraints(minWidth: double.infinity),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text("PAY ID: ",style: TextStyle(fontSize: 17,color: Colors.teal),),
                Text(payId,style: TextStyle(fontSize: 17),),
              ],
            ),

            IconButton(onPressed: (/*copy button*/){}, icon: Icon(Icons.copy_outlined,color: Colors.teal,))
          ],
        ),
      )
    ],
  );

  //send widget
  Widget sendContent = SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Send to a User",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            ],
          ),
          SizedBox(height: 30,),
          TextField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: "Enter Pay ID",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(backgroundColor: Colors.teal,),
                      onPressed: (){},
                      child: Text("Continue", style: TextStyle(fontSize: 17,color: Colors.black),)),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),

          TextButton(onPressed: (){},
              child:Text("Scan QR code",style: TextStyle(color: Colors.teal),)),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Recent",style: TextStyle(fontSize: 15,color: Colors.teal),),
            ],
          )
          
          // for now we use pay id, username and phone number

        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Transfer",style: TextStyle(fontSize: 25),),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
              constraints: BoxConstraints(minWidth: double.infinity),
              color: Colors.teal,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 80,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: selected?Colors.teal.shade900:Colors.teal
                        ),
                        onPressed: (){
                          setState(() {
                            selected = true;
                          });
                      }, child: Text("Receive",
                        style: TextStyle(
                            color: Colors.white, fontSize: 17),
                      ),
                      ),

                    ),
                  ),
                  //SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                        height: 80,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: selected?Colors.teal:Colors.teal.shade900
                          ),
                          onPressed: (){
                            setState(() {
                              selected = false;
                            });
                        }, child: Text("Send",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 20,),
            if(got_data)...[
            selected ? receiveContent : sendContent,
            ]else...[
              SizedBox(height: 100,),
              SizedBox(width: 100,height:100,
                child: CircularProgressIndicator(
                  color: Colors.teal,
                  strokeWidth: 2,
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
