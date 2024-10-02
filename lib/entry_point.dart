import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/components/custom_icon.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:animations/animations.dart';
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/models/auth/user.dart';
import 'package:tiktok_clone/providers/message_provider.dart';
import 'package:tiktok_clone/providers/user_data_provider.dart';
import 'package:tiktok_clone/screens/auth/views/non_auth.dart';
import 'package:tiktok_clone/screens/message/views/message.dart';
import 'package:tiktok_clone/screens/post/views/create_post.dart';
import 'package:tiktok_clone/screens/post/views/post.dart';
import 'package:tiktok_clone/screens/profile/views/components/change_account.dart';
import 'package:tiktok_clone/screens/profile/views/profile.dart';
import 'package:tiktok_clone/screens/shop/shop_screen.dart';
import 'package:tiktok_clone/storage/storage.dart';
import 'package:tiktok_clone/utils/storage_helper.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
  final ImagePicker _picker = ImagePicker();
  WebSocketChannel? channel;
  StorageService storageService = getIt<StorageService>();
  int unreadMessage = 10;

  UserProvider? userProvider;

  Future<void> initSignal() async {
    User? user = await storageService.getUser();
    if (user != null) {
      print("init signal ${user.id}");
      channel = WebSocketChannel.connect(
        Uri.parse(
            'ws://${Endpoints.socketURL}/ws/messages/${user.id}/'), // Update with your server URL
      );
      // Lấy messageProvider mà không lắng nghe thay đổi
      final messageProvider =
          Provider.of<MessageProvider>(context, listen: false);
      messageProvider.setChannel(channel = channel);
      channel!.stream.listen((message) {
        // // Handle incoming messages
        final data = jsonDecode(message);
        print("recieve new message $data");

        final users = messageProvider.users;
        if (users != null &&
            (data['type'] == "CONNECTED" || data['type'] == "DISCONNECTED")) {
          messageProvider.updateUserOnlineStatus(
              data['id'], data['type'] == "CONNECTED");
        }
        // You can also update your UI here
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initSignal();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider!.watchUserChange((newUser) {
      initSignal();
    });
  }

  @override
  void dispose() {
    channel!.sink.close();
    StorageHelper.authTokenNotifier.removeListener(() {});
    super.dispose();
  }

  List<AppBarItem> homeAppBarItems = [
    AppBarItem(text: "Friends", isSelected: false),
    AppBarItem(text: "Following", isSelected: false),
    AppBarItem(text: "For you", isSelected: true),
  ];

  late List<Widget> _pages;

  int selectedIndex = 0;

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

  // pick image from galp-87y6iuhguyp-  ery
  Future<void> pickVideoFromGallery() async {
    // showModalBottomSheet(
    //       context: context,
    //       isScrollControlled: true,
    //       builder: (ctx) => CreatePostScreen(video: File("dsadsa")),useSafeArea: false);
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (ctx) => CreatePostScreen(video: File(pickedFile.path)));
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
        MessageScreen(),
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
                if (index != 2 && index != selectedIndex) {
                  setState(() {
                    selectedIndex = index;
                  });
                } else {
                  pickVideoFromGallery();
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
                  // icon: svgIcon("assets/icons/chat.svg",
                  //     color: appBarIconColor()),
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      svgIcon("assets/icons/chat.svg",
                          color: appBarIconColor()),
                      if (unreadMessage > 0)
                        Positioned(
                          right: -10,
                          top: -10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8)),
                            constraints:
                                BoxConstraints(minWidth: 12, minHeight: 10),
                            child: Center(
                              child: Text(
                                unreadMessage.toString(),
                                style:
                                    TextStyle(color: whiteColor, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
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
