import 'package:flutter/material.dart';
import 'package:tiktok_clone/api/auth.dart';
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/api/post.dart';
import 'package:tiktok_clone/components/avatar.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/entry_point.dart';
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/models/activities/activities.dart';
import 'package:tiktok_clone/screens/post/views/post.dart';
import 'package:tiktok_clone/utils/utils.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  late List<Activity> activities = [];
  PostService postService = getIt<PostService>();
  AuthService authService = getIt<AuthService>();

  // Giả lập tải video ban đầu
  Future<void> fetchData() async {
    List<Activity>? activitiesData = await postService.activities();
    setState(() {
      activities = activitiesData!;
    });
  }

  // Giả lập tải video ban đầu
  Future<void> readNotify() async {
    await authService.readNotify({"type": "ACTIVITY"});
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    readNotify();
  }

  String getActivityMessage(String action, String? content) {
    switch (action) {
      case "LIKE":
        return "liked your video.";
      case "FAVORITE":
        return "added your video to Favorites.";
      case "COMMENT":
        return "commented: $content";
      case "REPLY_COMMENT":
        return "replied comment: $content";
    }
    return "";
  }

  viewPost(int id) {
    // Navigate to ScreenThree with the desired page index (e.g., 2 for Page 3)
    Navigator.of(context)
        .pushReplacement(
      MaterialPageRoute(
        builder: (context) => EntryPointScreen(
            initialIdex: 0, postId: id,), // Switch to HomeScreen and set active tab
      ),
    );
    //     .then((_) {
    //   if (mounted) {
    //     // After navigating back to HomeScreen, push ScreenThree with the specified page index
    //     Navigator.of(context).push(
    //       MaterialPageRoute(
    //         builder: (context) => PostScreen(
    //           id: id,
    //         ), // Navigate to Page 2
    //       ),
    //     );
    //   }
    // });
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
                "All Activity",
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
                            Activity item = entry.value;
                            final user = item.user!;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding / 2),
                              child: InkWell(
                                  onTap: () => {viewPost(item.post!.id!)},
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
                                            getActivityMessage(item.action!, item.content),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                        ],
                                      )),
                                      SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: AspectRatio(
                                              aspectRatio: 1,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          defaultPadding / 2)),
                                                  child: Image.network(
                                                    Utils.resolveUrl(
                                                        Endpoints.baseURL,
                                                        item.post!.thumbnail!),
                                                    fit: BoxFit.cover,
                                                  ))))
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
