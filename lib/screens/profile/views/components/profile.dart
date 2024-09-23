
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiktok_clone/components/avatar.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/auth/user_data.dart';
import 'package:tiktok_clone/screens/profile/views/components/view_avatar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.userData});
  final UserData userData;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late UserData userData;

  @override
  void initState() {
    super.initState();
    userData = widget.userData;
  }

  @override
  void didUpdateWidget(covariant Profile oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if the new props are different from the old ones
    if (widget.userData != oldWidget.userData) {
      setState(() {
        userData = widget.userData; // Update internal state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          child: Stack(children: [
            InkWell(
              onTap: () => {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (ctx) => ChangeAvatar(userData: userData))
              },
              child: Avatar(
                size: 60,
                url: userData.avatar,
                name: userData.username,
                isNetwork: true,
              ),
            ),
            Positioned(
                right: 5,
                bottom: 0,
                child: Container(
                    width: 32,
                    height: 32,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.cyan, shape: BoxShape.circle),
                        child: Icon(
                          Icons.add,
                          // size: 24,
                          color: whiteColor,
                        ))))
          ]),
        ),
        const SizedBox(height: defaultPadding),
        Text('@${userData?.username}',
            style: TextStyle(
                fontSize: 16, color: blackColor, fontWeight: FontWeight.bold)),
        const SizedBox(height: defaultPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "0",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: blackColor),
                    ),
                    Text(
                      "Đã follow",
                      style: TextStyle(fontSize: 12, color: blackColor80),
                    )
                  ],
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "0",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: blackColor),
                    ),
                    Text(
                      "Follower",
                      style: TextStyle(fontSize: 12, color: blackColor80),
                    )
                  ],
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "0",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: blackColor),
                    ),
                    Text(
                      "Thích",
                      style: TextStyle(fontSize: 12, color: blackColor80),
                    )
                  ],
                ))
          ],
        ),
        const SizedBox(height: defaultPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            IntrinsicWidth(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(defaultPadding),
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: blackColor,
                      minimumSize: const Size(double.infinity, 32),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(defaultBorderRadious)),
                      ),
                    ),
                    onPressed: () => {},
                    child: Text("Sửa hồ sơ"))),
            const SizedBox(width: defaultPadding / 2),
            IntrinsicWidth(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(defaultPadding),
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: blackColor,
                      minimumSize: const Size(double.infinity, 32),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(defaultBorderRadious)),
                      ),
                    ),
                    onPressed: () => {},
                    child: Text("Chia sẻ hồ sơ"))),
            const SizedBox(width: defaultPadding / 2),
            IntrinsicWidth(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(defaultPadding),
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: blackColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(defaultBorderRadious)),
                      ),
                    ),
                    onPressed: () => {},
                    child: SvgPicture.asset(
                      "assets/icons/add-friend.svg",
                      colorFilter:
                          ColorFilter.mode(blackColor, BlendMode.srcIn),
                    ))),
          ],
        ),
        const SizedBox(
          height: defaultPadding,
        )
      ],
    );
  }
}
