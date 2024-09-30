import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:tiktok_clone/api/auth.dart';
import 'package:tiktok_clone/api/auth.dart';
import 'package:tiktok_clone/api/auth.dart';
import 'package:tiktok_clone/components/avatar.dart';
import 'package:tiktok_clone/components/circle.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/models/auth/user.dart';
import 'package:tiktok_clone/models/message/message.dart';
import 'package:tiktok_clone/providers/user_data_provider.dart';
import 'package:tiktok_clone/screens/message/views/components/user-online.dart';
import 'package:tiktok_clone/screens/message/views/detail_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<Message> messages = [
    Message(
        user: User(username: "New followers"),
        content: "Rooney started following you."),
    Message(
        user: User(username: "Activity"),
        content: "Cristiano Ronaldo liked your video."),
  ];
  List<User> users = [];
  AuthService authService = getIt<AuthService>();
  Future<void> fetchData() async {
    try {
      final response = await authService.fetchUsers();
      setState(() {
        users = response!;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

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
              child: UserOnline(user: userProvider.user!, users: users),
            )),
            SliverToBoxAdapter(
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Column(
                      children: [
                        ...users.asMap().entries.where((entry)=>entry.value.id!=userProvider.user!.id).map((entry) {
                          final item = entry.value;
                          final index=entry.key;
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding / 2),
                              child: InkWell(
                                  onTap: () => {
                                        Navigator.of(context)
                                            .push(SwipeablePageRoute(
                                          canOnlySwipeFromEdge: false,
                                          builder: (BuildContext context) =>
                                              DetailMessageScreen(user: item),
                                        ))
                                      },
                                  child: Row(
                                    children: [
                                      Avatar(
                                        size: 28,
                                        url: item.avatar,
                                        name: item.username,
                                        isNetwork:true,
                                      ),
                                      const SizedBox(width: defaultPadding),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.firstName!,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: defaultPadding / 8,
                                          ),
                                          Text(
                                            "${item.firstName} ${index%2==0?"started following you.":"liked your video."}",
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      )),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 18,
                                        color: Colors.black,
                                      ),
                                    ],
                                  )));
                        })
                      ],
                    ))),
          ],
        )));
  }
}
