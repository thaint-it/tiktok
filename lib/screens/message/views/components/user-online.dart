import 'package:flutter/material.dart';
import 'package:tiktok_clone/components/avatar.dart';
import 'package:tiktok_clone/components/circle.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/auth/user.dart';
import 'package:tiktok_clone/models/auth/user_data.dart';

class UserActive {
  final String? avatar;
  final String? username;
  final bool? isOnline;
  UserActive({this.avatar, this.username, this.isOnline});
}

class UserOnline extends StatelessWidget {
  const UserOnline({super.key, required this.user, this.users});
  final UserData user;
  final List<User>? users;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: defaultPadding),
          child: Column(
            children: [
              Stack(children: [
                InkWell(
                  onTap: () => {},
                  child: Avatar(
                    size: 32,
                    url: user.avatar,
                    isNetwork: true,
                  ),
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.cyan, shape: BoxShape.circle),
                            child: Icon(
                              Icons.add,
                              size: 18,
                              color: whiteColor,
                            ))))
              ]),
              const SizedBox(height: defaultPadding / 2),
              Text(
                "create",
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(color: blackColor, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        ...users!
            .asMap()
            .entries
            .where((entry) => entry.value.id != user.id)
            .map((item) {
          User user = item.value;
          int index = item.key;
          return Padding(
              padding: EdgeInsets.only(
                  right: (index < users!.length ? defaultPadding : 0)),
              child: SizedBox(
                width: 70,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          child: Avatar(
                            size: 32,
                            url: user.avatar,
                            isNetwork: true,
                          ),
                        ),
                        if (index < 4)
                          Positioned(
                              right: 3, bottom: 3, child: Cirlce(size: 16))
                      ],
                    ),
                    const SizedBox(
                      height: defaultPadding / 2,
                    ),
                    Text(
                      user.username!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: blackColor, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ));
        })
      ],
    );
  }
}
