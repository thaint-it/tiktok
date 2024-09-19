import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/providers/user_data_provider.dart';
import 'package:tiktok_clone/screens/auth/views/non_auth.dart';
import 'package:tiktok_clone/screens/profile/views/components/content.dart';
import 'package:tiktok_clone/screens/profile/views/components/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PageController pageController = PageController();
  int selectedIndex = 0;
  List<String> items = [
    "assets/icons/filter.svg",
    "assets/icons/lock.svg",
    "assets/icons/bookmark.svg",
    "assets/icons/hidden-like.svg"
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return userProvider.user != null
        ? Scaffold(
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: Profile(userData: userProvider.user!)),
                  SliverAppBar(
                    pinned: true,
                    title: null,
                    titleSpacing: 0,
                    backgroundColor: Colors.white,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5,
                                      color:
                                          blackColor))), // Background color of the app bar
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...items.asMap().entries.map((entry) {
                                return Expanded(
                                  child: TextButton(
                                      onPressed: () => {
                                            setState(() {
                                              selectedIndex = entry.key;
                                            })
                                          },
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(0),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            bottom: defaultPadding / 2,
                                            left: defaultPadding / 2,
                                            right: defaultPadding / 2),
                                        decoration: selectedIndex == entry.key
                                            ? BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: 1,
                                                        color: blackColor)))
                                            : BoxDecoration(),
                                        child: SvgPicture.asset(
                                          entry.value,
                                          width: 24,
                                          colorFilter: ColorFilter.mode(
                                              blackColor, BlendMode.srcIn),
                                        ),
                                      )),
                                );
                              }),
                            ],
                          )),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Content(
                          selectedIndex: selectedIndex,
                          onIndexChanged: (value) => {
                                if (value != selectedIndex)
                                  {
                                    setState(() {
                                      selectedIndex = value;
                                    })
                                  }
                              })),
                ],
              ),
            ),
          )
        : NonAuthScreen();
  }
}
