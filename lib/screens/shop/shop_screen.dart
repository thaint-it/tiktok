import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  bool _isModalVisible = false;

  // Function to open the modal
  void _showModal() {
    setState(() {
      _isModalVisible = true;
    });
  }

  // Function to close the modal
  void _closeModal() {
    setState(() {
      _isModalVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _showModal,
              child: Text('Open Modal'),
            ),
          ),

          // Fullscreen Modal Overlay
          if (_isModalVisible)
            GestureDetector(
              // Detect taps outside the modal
              onTap: _closeModal,
              child: Container(
                color: Colors.black87, // Semi-transparent background
                child: Center(
                  child: GestureDetector(
                    // Prevents tap event propagation on modal content
                    onTap: () {}, // Do nothing when modal itself is tapped
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.person, size: 40),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Handle button tap without closing modal
                            },
                            child: Text('Do Something'),
                          ),
                          SizedBox(height: 20),
                          Text('Tap outside the modal to close'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
