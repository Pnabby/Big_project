import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  var _background = Colors.white10;
  var purple = Colors.purple;
  String nickname = "Nickname";
  final List<String> items = [
    "Upgrade Account",
    "Locate Us",
    "Advertise",
    "Logout",
  ];
  final List<Widget> _icons = [
    Icon(Icons.upgrade_outlined,color: Colors.purple,),
    Icon(Icons.location_on_outlined,color: Colors.purple,),
    Icon(Icons.announcement_outlined, color: Colors.purple),
    Icon(Icons.logout_outlined,color: Colors.purple,)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: _background,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              if (index==3){
                FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            },
            child: ListTile(
              title: Text(items[index]),
              leading: _icons[index] ,
              trailing: Icon(Icons.arrow_forward_ios_outlined,color: purple,),

            ),
          );
        },
      ),

    );;
  }
}
