import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/api/auth.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/models/auth/user.dart';
import 'package:tiktok_clone/models/auth/user_data.dart';
import 'package:tiktok_clone/providers/user_data_provider.dart';
import 'package:tiktok_clone/storage/storage.dart';

class CropAvatar extends StatefulWidget {
  const CropAvatar({super.key, required this.avatar});
  final File? avatar;

  @override
  State<CropAvatar> createState() => _CropAvatarState();
}

class _CropAvatarState extends State<CropAvatar> {
  late AuthService _authService = getIt<AuthService>();
  late StorageService _storageService = getIt<StorageService>();

  Future<void> changeAvatar() async {
    try {
      if (mounted) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final user = userProvider.user!;
        final response = await _authService.changeAvatar(
            userId: user.id, avatar: widget.avatar!);
        if (response != null) {
          user.avatar = response.avatar;
          _storageService.setUser(User(
              id: user.id,
              avatar: user.avatar,
              userId: user.userId,
              email: user.email,
              username: user.username,
              bio: user.bio));
          userProvider.setUser(user);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }

        print("response ${response!.avatar} ");
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - defaultPadding * 2;
    return Container(
      color: whiteColor,
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.only(
          top: defaultPadding * 4,
          left: defaultPadding,
          right: defaultPadding,
          bottom: defaultPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Crop",
            style: TextStyle(color: blackColor),
          ),
          Expanded(
              child: Container(
            child: Center(
              child: Container(
                width: screenWidth,
                height: screenWidth, // Make it full width and height
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Circle shape
                  image: DecorationImage(
                    image:
                        FileImage(widget.avatar!), // Display the selected image
                    fit: BoxFit.cover, // Ensure the image covers the circle
                  ),
                ),
              ),
            ),
          )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: OutlinedButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 0.5, color: Colors.grey),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(defaultPadding / 2)),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: blackColor),
                    )),
              ),
              const SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () => changeAvatar(),
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(defaultPadding / 2)),
                        ),
                        backgroundColor: Colors.pink,
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(color: whiteColor),
                      )))
            ],
          )
        ],
      ),
    );
  }
}
