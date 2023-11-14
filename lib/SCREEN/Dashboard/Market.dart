import 'package:flutter/material.dart';

class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Market"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.purple[200],
        elevation: 2,
      ),
    );
  }
}
