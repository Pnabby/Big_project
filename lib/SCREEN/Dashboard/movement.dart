import 'package:flutter/material.dart';
import 'package:second/SCREEN/Dashboard/Help.dart';
import 'package:second/SCREEN/Dashboard/Home.dart';
import 'package:second/SCREEN/Dashboard/Market.dart';
import 'package:second/SCREEN/Dashboard/More.dart';
import 'package:second/SCREEN/Dashboard/Settings.dart';

class Movement extends StatefulWidget {
  final String firstName;
  const Movement({required this.firstName});


  @override
  State<Movement> createState() => _MovementState();
}

class _MovementState extends State<Movement> {
  // Declare a variable to store the current index of the bottom navigation bar
  int _selectedIndex = 0;
  late  final List<Widget>_pages;
  var _selectcolor = Colors.teal.shade800;


  // Declare a list of pages that correspond to each item of the bottom navigation bar
  @override
  void initState() {
    super.initState();
     _pages = [
      Home(firstName: widget.firstName),
      // This is a widget that shows the home page
      Market(),
      // This is a widget that shows the market page
      Help(),
      // This is a widget that shows the help page
      Settings(),
      // This is a widget that shows the settings page
      More(),
      // This is a widget that shows the more page
    ];
  }


  void ontap(int index ){
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      // Use the current index to show the corresponding page in the body of the scaffold
      body:IndexedStack(index: _selectedIndex,children: _pages,),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 40,
        selectedItemColor: _selectcolor,
        //unselectedItemColor: Colors.purple[400],
        selectedFontSize: 16,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white12,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,color: (_selectedIndex == 0)? _selectcolor:Colors.grey,),
            label: 'Home',
            //backgroundColor: Colors.orange
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.sell_outlined, color: (_selectedIndex == 1)? _selectcolor:Colors.grey),
            label: 'Market',
            //backgroundColor: Colors.orange
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined,color: (_selectedIndex == 2)? _selectcolor:Colors.grey),
            label: 'Help',
            //backgroundColor: Colors.orange
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined,color: (_selectedIndex == 3)? _selectcolor:Colors.grey),
            label: 'Settings',
            //backgroundColor: Colors.orange
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz_outlined,color: (_selectedIndex == 4)? _selectcolor:Colors.grey),
            label: 'More',
          )



        ],
        // Add an onTap property and pass a function that takes an index as a parameter
        onTap: ontap

            /*(index) {
          // Use setState to update the current index and perform any actions you want based on the index
          setState(() {
            _currentIndex = index;
            switch (index) {
              case 0:
              // Navigate to the home page using Navigator.push or Navigator.pushNamed methods
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                break;
              case 1:
              // Navigate to the market page using Navigator.push or Navigator.pushNamed methods
                Navigator.push(context, MaterialPageRoute(builder: (context) => Market()));
                break;
              case 2:
              // Navigate to the help page using Navigator.push or Navigator.pushNamed methods
                Navigator.push(context, MaterialPageRoute(builder: (context) => Help()));
                break;
              case 3:
              // Navigate to the settings page using Navigator.push or Navigator.pushNamed methods
                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                break;
              case 4:
              // Navigate to the more page using Navigator.push or Navigator.pushNamed methods
                Navigator.push(context, MaterialPageRoute(builder: (context) => More()));
                break;
              default:
              // Do nothing or show an error message if the index is invalid
                print('Invalid index');
                break;
            }
          });
        },*/
      ),

    );

  }
}
