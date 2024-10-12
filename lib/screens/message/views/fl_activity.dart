import 'package:flutter/material.dart';
import 'package:tiktok_clone/api/auth.dart';
import 'package:tiktok_clone/components/avatar.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/models/activities/activities.dart';

class FollowActivityScreen extends StatefulWidget {
  const FollowActivityScreen({super.key});

  @override
  State<FollowActivityScreen> createState() => _FollowActivityScreenState();
}

class _FollowActivityScreenState extends State<FollowActivityScreen> {
  late List<FollowerActivity> activities = [];
  AuthService authService = getIt<AuthService>();

  // Giả lập tải video ban đầu
  Future<void> fetchData() async {
    List<FollowerActivity>? activitiesData =
        await authService.followerActivities();
    setState(() {
      activities = activitiesData!;
    });
  }

    // Giả lập tải video ban đầu
  Future<void> readNotify() async {
    await authService.readNotify({"type": "FOLLOWER"});
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    readNotify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: 48,
          forceMaterialTransparency: true,
          backgroundColor: whiteColor,
          leading: IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black54,
              )),
          leadingWidth: 20,
          centerTitle: false,
          title: Align(
              alignment: Alignment.center,
              child: Text(
                "New Followers",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(5), // Height of the bottom border
            child: Container(
              color: Colors.grey, // Border color
              height: 0.5, // Border height
            ),
          ),
        ),
        body: SafeArea(
            child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Column(
                      children: [
                        if (activities.isNotEmpty)
                          ...activities.asMap().entries.map((entry) {
                            FollowerActivity item = entry.value;
                            final user = item.follower!;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding / 2),
                              child: InkWell(
                                  onTap: () => {},
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Avatar(
                                            size: 28,
                                            url: user.avatar,
                                            name: user.firstName,
                                            isNetwork: true,
                                          ),
                                          // if (item.isOnline == true)
                                          //   Positioned(right: 0, bottom: 2, child: Cirlce(size: 16))
                                        ],
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
                                            user.firstName!,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: defaultPadding / 8,
                                          ),
                                          Text(
                                            "started following you.",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                        ],
                                      )),
                                      ElevatedButton(
                                          onPressed: () => {},
                                          style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal:
                                                          defaultPadding/2),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(2)),
                                              ),
                                              backgroundColor: Colors.pink,
                                              minimumSize: Size(80, 30)),
                                          child: Text(
                                            "Follow back",
                                            style: TextStyle(color: whiteColor),
                                          ))
                                    ],
                                  )),
                            );
                          })
                      ],
                    ))),
          ],
        )));
  }
}
