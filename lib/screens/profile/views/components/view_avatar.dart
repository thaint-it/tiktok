import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/components/avatar.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/auth/user_data.dart';
import 'package:tiktok_clone/screens/profile/views/components/change_avatar.dart';

class ChangeAvatar extends StatefulWidget {
  const ChangeAvatar({super.key, required this.userData});

  final UserData userData;

  @override
  State<ChangeAvatar> createState() => _ChangeAvatarState();
}

class _ChangeAvatarState extends State<ChangeAvatar> {
  final ImagePicker _picker = ImagePicker();
  // pick image from galp-87y6iuhguyp-  ery
  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Call image cropper to crop the image in circular mode
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressQuality: 100,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop',
          ),
        ],
      );
      if (croppedFile != null) {
        if (mounted) {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (ctx) => CropAvatar(avatar: File(croppedFile.path)));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            // Detect taps outside the modal
            onTap: () => {Navigator.of(context).pop()},
            child: Container(
              color: Colors.black87, // Semi-transparent background
              child: Center(
                child: GestureDetector(
                  // Prevents tap event propagation on modal content
                  onTap: () {}, // Do nothing when modal itself is tapped
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Avatar(
                          size: 160,
                          url: widget.userData.avatar,
                          name: widget.userData.username,
                          isNetwork: true,
                        ),
                        const SizedBox(
                          height: defaultPadding * 2,
                        ),
                        ElevatedButton(
                            onPressed: pickImageFromGallery,
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              backgroundColor: Colors.grey.shade700,
                            ),
                            child: Text(
                              "Change photo",
                              style: TextStyle(color: whiteColor),
                            )),
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
