// ignore_for_file: unused_import, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/api/auth.dart';
import 'package:tiktok_clone/components/bottom_sheet_header.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/models/auth/user.dart';
import 'package:tiktok_clone/models/auth/user_data.dart';
import 'package:tiktok_clone/providers/user_data_provider.dart';
import 'package:tiktok_clone/storage/storage.dart';
import 'package:tiktok_clone/utils/storage_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<_LoginScreenState> loginWidgetKey = GlobalKey();
  final formKey = GlobalKey<FormState>();

  late AuthService _authService = getIt<AuthService>();
  late StorageService _storageService = getIt<StorageService>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  void initializeControllers() {
    emailController = TextEditingController(text: "")
      ..addListener(controllerListener);
    passwordController = TextEditingController(text: "")
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  void controllerListener() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty && password.isEmpty) return;

    // if (AppRegex.emailRegex.hasMatch(email) &&
    //     AppRegex.passwordRegex.hasMatch(password)) {
    //   fieldValidNotifier.value = true;
    // } else {
    //   fieldValidNotifier.value = false;
    // }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  Future<void> handleRegister() async {
    String email = emailController.text;
    String password = passwordController.text;

    try {
      final response = await _authService.login(
          user: UserLogin(email: email, password: password));
      if (response != null) {
        _storageService.setToken(response.jwtToken);
        _storageService.setRFToken(response.refreshToken);
        _storageService.setUser(response.user);
        if (mounted) {
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          final user = response.user;
          userProvider.setUser(UserData(
              id: user.id,
              tiktokId: user.tiktokId,
              email: user.email,
              username: user.username,
              avatar: user.avatar));
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Container(
          color: whiteColor,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BottomSheetHeader(),
                const SizedBox(height: defaultPadding * 3),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 32),
                ),
                const SizedBox(height: defaultPadding * 2),
                Form(
                    key: formKey,
                    child: Column(children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email or TikTok ID",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.1, color: Colors.grey.shade600),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.1, color: Colors.grey.shade600),
                          ),
                        ),
                        style: TextStyle(fontSize: 14, color: blackColor),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.1, color: Colors.grey.shade600),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.1, color: Colors.grey.shade600),
                          ),
                        ),
                        obscureText: true,
                        style: TextStyle(fontSize: 14, color: blackColor),
                      ),
                      const SizedBox(
                        height: defaultPadding * 2,
                      ),
                      ElevatedButton(
                        onPressed: handleRegister,
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                            ),
                            backgroundColor: Colors.pink,
                            minimumSize: Size(double.infinity, 40)),
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      )
                    ]))
              ])),
    ));
  }
}
