import 'dart:convert';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/api/auth.dart';
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/api/notification.dart';
import 'package:tiktok_clone/api/post.dart';
import 'package:tiktok_clone/components/custom_icon.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:animations/animations.dart';
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/models/activities/activities.dart';
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
  const EntryPointScreen(
      {super.key,
      this.notificationAppLaunchDetails,
      this.initialIdex = 0,
      this.postId});
  final int initialIdex;
  final int? postId;

  final NotificationAppLaunchDetails? notificationAppLaunchDetails;
  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

  @override
  State<EntryPointScreen> createState() => _EntryPointScreenState();
}

class _EntryPointScreenState extends State<EntryPointScreen> {
  final ImagePicker _picker = ImagePicker();
  WebSocketChannel? channel;
  StorageService storageService = getIt<StorageService>();
  AuthService authService = getIt<AuthService>();
  PostService postService = getIt<PostService>();
  NoticationService noticationService = getIt<NoticationService>();
  int unreadMessage = 10;

  UserProvider? userProvider;

  Future<void> initSignal() async {
    User? user = await storageService.getUser();
    if (user != null) {
      channel = WebSocketChannel.connect(
        Uri.parse(
            'ws://${Endpoints.socketURL}/ws/notification/${user.id}/'), // Update with your server URL
      );
      // Lấy messageProvider mà không lắng nghe thay đổi
      final messageProvider =
          Provider.of<MessageProvider>(context, listen: false);
      messageProvider.setChannel(channel = channel);
      channel!.stream.listen((message) {
        // // Handle incoming messages
        final data = jsonDecode(message);

        final users = messageProvider.users;
        switch (data['type']) {
          case "CONNECTED":
          case "DISCONNECTED":
            messageProvider.updateUserOnlineStatus(
                data['id'], data['type'] == "CONNECTED");
          case "LIKE":
          case "FAVORITE":
          case "COMMENT":
          case "REPLY_COMMENT":
            messageProvider.setNotifyCount(messageProvider.notifyCount + 1);
            pushNotitication(data['id']);
        }
      });
    }
    if (mounted) {
      FocusScope.of(context).unfocus();
    }
  }

  Future<void> pushNotitication(id) async {
    Activity activity=await postService.activityById(id);
    noticationService.showNotificationWithAttachment(activity);
  }

  Future<void> getNofifyCount() async {
    final count = await authService.notifyCount();
    final messageProvider =
        Provider.of<MessageProvider>(context, listen: false);
    messageProvider.setNotifyCount(count);
  }

  @override
  void initState() {
    // This will hide the keyboard
    super.initState();
    setState(() {
      selectedIndex = widget.initialIdex;
    });
    userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider!.watchUserChange((newUser) {
      if (newUser != null) {
        getNofifyCount();
        initSignal();
      }
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
    final ms = Provider.of<MessageProvider>(context);

    if (userProvider.user == null) {
      _pages = [
        PostScreen(id: widget.postId),
        NonAuthScreen(),
        NonAuthScreen(),
        NonAuthScreen(),
        NonAuthScreen()
      ];
    } else {
      _pages = [
        PostScreen(id: widget.postId),
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
                } else if (index == 2) {
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
                      if (ms.notifyCount > 0)
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
                                ms.notifyCount.toString(),
                                style:
                                    TextStyle(color: whiteColor, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  activeIcon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      svgIcon("assets/icons/chat.svg",
                          color: appBarIconColor(isActive: true)),
                      if (ms.notifyCount > 0)
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
                                ms.notifyCount.toString(),
                                style:
                                    TextStyle(color: whiteColor, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

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
