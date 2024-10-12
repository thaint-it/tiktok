import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:tiktok_clone/api/auth.dart';
import 'package:tiktok_clone/api/message.dart';
import 'package:tiktok_clone/api/post.dart';
import 'package:tiktok_clone/components/avatar.dart';
import 'package:tiktok_clone/components/circle.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/models/activities/activities.dart';
import 'package:tiktok_clone/models/message/message.dart';
import 'package:tiktok_clone/providers/message_provider.dart';
import 'package:tiktok_clone/providers/user_data_provider.dart';
import 'package:tiktok_clone/screens/message/views/components/user-online.dart';
import 'package:tiktok_clone/screens/message/views/activity.dart';
import 'package:tiktok_clone/screens/message/views/detail_message.dart';
import 'package:tiktok_clone/screens/message/views/fl_activity.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  AuthService authService = getIt<AuthService>();
  PostService postService = getIt<PostService>();
  MessageService messageService = getIt<MessageService>();

  late List<Message> messageCategories = [];
  FollowerActivity? followerActivityCategory;
  Activity? activityCategory;

  Future<void> fetchData() async {
    try {
      final response = await authService.fetchUsers();
      MessageProvider messageProvider =
          Provider.of<MessageProvider>(context, listen: false);
      messageProvider.setUser(response);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> fetchMessageCategories() async {
    try {
      final response = await messageService.messageCatogories();
      setState(() {
        messageCategories = response!;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> fetchFLCategories() async {
    try {
      final response = await authService.followerCategory();
      setState(() {
        followerActivityCategory = response!;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> fetchActivityCategories() async {
    try {
      final response = await postService.activityCategory();
      setState(() {
        activityCategory = response!;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> getNofifyCount() async {
    final count = await authService.notifyCount();
    final messageProvider =
        Provider.of<MessageProvider>(context, listen: false);
    messageProvider.setNotifyCount(count);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    fetchMessageCategories();
    fetchFLCategories();
    fetchActivityCategories();
  }

  String getActivityMessage(String action,String? content) {
    switch (action) {
      case "LIKE":
        return "liked your video.";
      case "FAVORITE":
        return "added your video to Favorites.";
      case "COMMENT":
        return "commented: $content";
    }
    return "";
  }

  void handleNavigate(item, String type) {
    switch (type) {
      case "FOLLOWER":
        Navigator.of(context)
            .push(SwipeablePageRoute(
          canOnlySwipeFromEdge: false,
          builder: (BuildContext context) => FollowActivityScreen(),
        ))
            .then((_) {
          fetchFLCategories();
          fetchActivityCategories();
          getNofifyCount();
        });
      case "ACTIVITY":
        Navigator.of(context)
            .push(SwipeablePageRoute(
          canOnlySwipeFromEdge: false,
          builder: (BuildContext context) => ActivityScreen(),
        ))
            .then((_) {
          fetchFLCategories();
          fetchActivityCategories();
           getNofifyCount();
        });
      case "MESSAGE":
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final targetUser = item.fromUser!.id == userProvider.user!.id
            ? item.toUser!
            : item.fromUser!;
        Navigator.of(context).push(SwipeablePageRoute(
          canOnlySwipeFromEdge: false,
          builder: (BuildContext context) =>
              DetailMessageScreen(user: targetUser),
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    Widget category(item, String avatar, bool isNetworkAvatar, String name,
        String notify, bool isRead, String type) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
        child: InkWell(
            onTap: () => {handleNavigate(item, type)},
            child: Row(
              children: [
                Stack(
                  children: [
                    Avatar(
                      size: 28,
                      url: avatar,
                      name: name,
                      isNetwork: isNetworkAvatar,
                    ),
                    // if (item.isOnline == true)
                    //   Positioned(right: 0, bottom: 2, child: Cirlce(size: 16))
                  ],
                ),
                const SizedBox(width: defaultPadding),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: isRead ? Colors.black87 : Colors.black,
                          fontWeight:
                              isRead ? FontWeight.w400 : FontWeight.w500,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: defaultPadding / 8,
                    ),
                    Text(
                      notify,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: isRead ? FontWeight.w400 : FontWeight.w500,
                        color: isRead ? Colors.black87 : Colors.black,
                      ),
                    ),
                  ],
                )),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 18,
                  color: Colors.black54,
                ),
              ],
            )),
      );
    }

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          forceMaterialTransparency: true,
          backgroundColor: whiteColor,
          leading: Padding(
              padding: const EdgeInsets.only(left: defaultPadding),
              child: SvgPicture.asset("assets/icons/user.svg",
                  colorFilter:
                      ColorFilter.mode(Colors.black, BlendMode.srcIn))),
          leadingWidth: 40,
          centerTitle: true,
          title: Center(
              child: TextButton(
                  onPressed: () => {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Inbox",
                        style: TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      Cirlce(size: 10)
                    ],
                  ))),
          actions: [
            IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, searchScreenRoute);
              },
              icon: SvgPicture.asset(
                "assets/icons/search.svg",
                width: 24,
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
            )
          ],
        ),
        body: SafeArea(
            child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Container(
              height: 150,
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding),
              child: UserOnline(),
            )),
            SliverToBoxAdapter(
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Column(
                      children: [
                        if (followerActivityCategory != null &&
                            followerActivityCategory!.follower!.id != null)
                          category(
                              followerActivityCategory,
                              "assets/avatars/follower.jpg",
                              false,
                              "New Followers",
                              "${followerActivityCategory!.follower!.firstName!} started follwing you",
                              followerActivityCategory!.isRead!,
                              "FOLLOWER"),
                        if (activityCategory != null &&
                            activityCategory!.user!.id != null)
                          category(
                              activityCategory,
                              "assets/avatars/notify.jpg",
                              false,
                              "Activity",
                              "${activityCategory!.user!.firstName!} ${getActivityMessage(activityCategory!.action!, activityCategory!.content)}",
                              activityCategory!.isRead!,
                              "ACTIVITY"),
                        if (messageCategories.isNotEmpty)
                          ...messageCategories
                              .asMap()
                              .entries
                              .where((entry) =>
                                  entry.value.id != userProvider.user!.id)
                              .map((entry) {
                            Message item = entry.value;
                            final isMe =
                                item.fromUser!.id == userProvider.user!.id;
                            final avatar = isMe
                                ? item.toUser!.avatar!
                                : item.fromUser!.avatar!;
                            final name = isMe
                                ? item.toUser!.firstName!
                                : item.fromUser!.firstName!;
                            return category(item, avatar, true, name,
                                item.content!, item.isRead!, "MESSAGE");
                          })
                      ],
                    ))),
          ],
        )));
  }
}
