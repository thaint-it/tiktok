import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Align(
            alignment: Alignment.center,
            child: DefaultTextStyle(
                style: TextStyle(),
                child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Log in to Tiktok",
                            style: TextStyle(fontSize: 18, color: blackColor))
                      ],
                    )))));
  }
}
