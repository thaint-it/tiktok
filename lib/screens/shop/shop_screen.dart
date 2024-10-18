import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: ()=>{},
              child: Text('Open Modal'),
            ),
          ),

        ],
      ),
    );
  }
}
