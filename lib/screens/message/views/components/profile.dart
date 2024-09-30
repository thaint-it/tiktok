import 'package:flutter/material.dart';
import 'package:tiktok_clone/components/avatar.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/auth/user.dart';

class MessageProfile extends StatelessWidget {
  const MessageProfile({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2),
      child: Center(
        child: Column(
          children: [
            Avatar(
              size: 48,
              url: user.avatar,
              isNetwork: true,
              name: user.username,
            ),
            const SizedBox(height: defaultPadding / 4),
            Text("@${user.tiktokId}"),
            const SizedBox(height: defaultPadding / 4),
            Text("126 following - 416 followers"),
            const SizedBox(height: defaultPadding / 2),
            ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: defaultPadding),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    backgroundColor: Colors.pink,
                    minimumSize: Size(100, 30)),
                child: Text(
                  "Follow back",
                  style: TextStyle(color: whiteColor),
                ))
          ],
        ),
      ),
    );
  }
}
