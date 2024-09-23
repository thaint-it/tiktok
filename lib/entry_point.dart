import 'package:provider/provider.dart';
import 'package:tiktok_clone/components/custom_icon.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:animations/animations.dart';
import 'package:tiktok_clone/providers/user_data_provider.dart';
import 'package:tiktok_clone/screens/auth/views/non_auth.dart';
import 'package:tiktok_clone/screens/post/views/post.dart';
import 'package:tiktok_clone/screens/profile/views/components/change_account.dart';
import 'package:tiktok_clone/screens/profile/views/profile.dart';
import 'package:tiktok_clone/screens/shop/shop_screen.dart';
import 'package:tiktok_clone/utils/storage_helper.dart';

class AppBarItem {
  String text;
  bool isSelected;
  AppBarItem({required this.text, this.isSelected = false});
}

class EntryPointScreen extends StatefulWidget {
  const EntryPointScreen({super.key});

  @override
  State<EntryPointScreen> createState() => _EntryPointScreenState();
}

class _EntryPointScreenState extends State<EntryPointScreen> {
  List<AppBarItem> homeAppBarItems = [
    AppBarItem(text: "Bạn bè", isSelected: false),
    AppBarItem(text: "Đã Follow", isSelected: false),
    AppBarItem(text: "Đề xuất", isSelected: true),
  ];

  late List<Widget> _pages;

  int selectedIndex = 0;

  @override
  void dispose() {
    StorageHelper.authTokenNotifier.removeListener(() {});
    super.dispose();
  }

  appBarIconColor({isActive = false}) {
    if (selectedIndex == 0) {
      return isActive ? whiteColor : whileColor80;
    } else {
      return isActive ? blackColor : blackColor;
    }
  }

  void showChangAccount() {
    showModalBottomSheet(context: context, builder: (ctx) => ChangeAccount());
  }

  buildAppbar(UserProvider userProvider) {
    switch (selectedIndex) {
      case 0:
        return AppBar(
          toolbarHeight: 40,
          forceMaterialTransparency: true,
          backgroundColor: Colors.black,
          leading: const SizedBox(),
          leadingWidth: 0,
          centerTitle: false,
          title: Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset(
              "assets/icons/live.svg",
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              width: 24,
            ),
          ),
          actions: [
            ...homeAppBarItems.asMap().entries.map((entry) {
              AppBarItem item = entry.value;
              return TextButton(
                onPressed: () => {},
                child: Column(
                  children: [
                    Text(item.text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: item.isSelected
                                ? FontWeight.bold
                                : FontWeight.normal)),
                    item.isSelected
                        ? Container(height: 2, width: 30, color: Colors.white)
                        : SizedBox(height: 2)
                  ],
                ),
              );
            }),
            Align(
              alignment: Alignment.topCenter,
              child: IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, searchScreenRoute);
                },
                icon: SvgPicture.asset(
                  "assets/icons/search.svg",
                  height: 24,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            )
          ],
        );
      default:
        return AppBar(
          toolbarHeight: 40,
          forceMaterialTransparency: true,
          backgroundColor: whiteColor,
          leading: const SizedBox(),
          centerTitle: true,
          title: Center(
              child: TextButton(
                  onPressed: showChangAccount,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        userProvider.user?.username ?? "Profile",
                        style: TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: defaultPadding / 2,
                      ),
                      SvgPicture.asset("assets/icons/down-outline.svg",
                          width: 14,
                          colorFilter:
                              ColorFilter.mode(blackColor, BlendMode.srcIn))
                    ],
                  ))),
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, searchScreenRoute);
              },
              icon: SvgPicture.asset(
                "assets/icons/menu.svg",
                width: 24,
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
            )
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if (userProvider.user == null) {
      _pages = [
        PostScreen(),
        NonAuthScreen(),
        NonAuthScreen(),
        NonAuthScreen(),
        NonAuthScreen()
      ];
    } else {
      _pages = [
        PostScreen(),
        ShopScreen(),
        Container(),
        Container(),
        ProfileScreen()
      ];
    }

    SvgPicture svgIcon(String src, {Color? color, double? height}) {
      return SvgPicture.asset(
        src,
        height: height ?? 24,
        colorFilter: ColorFilter.mode(
            color ??
                Theme.of(context).iconTheme.color!.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
            BlendMode.srcIn),
      );
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: selectedIndex == 0 ? blackColor : whiteColor,
        appBar: buildAppbar(userProvider),
        body: PageTransitionSwitcher(
          duration: defaultDuration,
          transitionBuilder: (child, animation, secondAnimation) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondAnimation,
              child: child,
            );
          },
          child: _pages.length > 0 ? _pages[selectedIndex] : Container(),
        ),
        bottomNavigationBar: Container(
          color: selectedIndex == 0 ? Colors.black : Colors.white,
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedIndex,
              unselectedItemColor: appBarIconColor(),
              selectedItemColor: appBarIconColor(isActive: true),
              showUnselectedLabels: true,
              selectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: appBarIconColor(isActive: true)),
              unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                  color: appBarIconColor()),
              backgroundColor: selectedIndex == 0 ? Colors.black : Colors.white,
              onTap: (index) {
                if (index != selectedIndex) {
                  setState(() {
                    selectedIndex = index;
                  });
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/home.svg",
                      color: appBarIconColor()),
                  activeIcon: svgIcon("assets/icons/home.svg",
                      color: appBarIconColor(isActive: true)),
                  label: "Trang chủ",
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/shop.svg",
                      color: appBarIconColor()),
                  activeIcon: svgIcon("assets/icons/shop.svg",
                      color: appBarIconColor(isActive: true)),
                  label: "Cửa hàng",
                ),
                BottomNavigationBarItem(
                  icon: CustomIcon(isLightTheme: selectedIndex != 0),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/chat.svg",
                      color: appBarIconColor()),
                  activeIcon: svgIcon("assets/icons/chat.svg",
                      color: appBarIconColor(isActive: true)),
                  label: "Hộp thư",
                ),
                BottomNavigationBarItem(
                  icon: svgIcon("assets/icons/user.svg",
                      color: appBarIconColor()),
                  activeIcon: svgIcon("assets/icons/user.svg",
                      color: appBarIconColor(isActive: true)),
                  label: "Hồ sơ",
                ),
              ]),
        ));
  }
}
