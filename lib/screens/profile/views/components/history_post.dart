import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/comment/comment.dart';
import 'package:tiktok_clone/models/history_post_model.dart';

class HistoryPost extends StatefulWidget {
  const HistoryPost({super.key});

  @override
  State<HistoryPost> createState() => _HistoryPostState();
}

class _HistoryPostState extends State<HistoryPost> {
  List<HistoryPostModel> posts = [
    // HistoryPostModel(
    //     thumbnail: "assets/posts/1.jpg", id: 1, viewCount: 5555, pined: true),
    // HistoryPostModel(
    //     thumbnail: "assets/posts/2.jpg", id: 1, viewCount: 1222, pined: true),
    // HistoryPostModel(thumbnail: "assets/posts/3.jpg", id: 1, viewCount: 854),
    // HistoryPostModel(thumbnail: "assets/posts/4.jpg", id: 1, viewCount: 1111),
    // HistoryPostModel(thumbnail: "assets/posts/5.jpg", id: 1, viewCount: 999),
    // HistoryPostModel(thumbnail: "assets/posts/6.jpg", id: 1, viewCount: 777),
  ];

  void doSomething() {}

  @override
  Widget build(BuildContext context) {
    return posts.isNotEmpty
        ? GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 2,
                childAspectRatio: 0.5625,
                crossAxisSpacing: 2),
            itemBuilder: (context, index) => Container(
                color: blackColor,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(posts[index].thumbnail, fit: BoxFit.cover),
                    Positioned(
                        bottom: 10,
                        left: 10,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/icons/play-outline.svg",
                              width: 16,
                              colorFilter:
                                  ColorFilter.mode(whiteColor, BlendMode.srcIn),
                            ),
                            const SizedBox(
                              width: defaultPadding / 2,
                            ),
                            Text(
                              posts[index].viewCount.toString(),
                              style: TextStyle(color: whiteColor),
                            )
                          ],
                        )),
                    posts[index].pined == true
                        ? Positioned(
                            left: 10,
                            top: 10,
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                color: Colors.red,
                                child: Text(
                                  "Đã ghim",
                                  style: TextStyle(color: whiteColor),
                                )))
                        : SizedBox()
                  ],
                )))
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding * 3),
            child: Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/icons/imgs.svg",
                    width: 48,
                    colorFilter:
                        ColorFilter.mode(blackColor60, BlendMode.srcIn),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text("Share a throwback video"),
                  const SizedBox(height: defaultPadding / 2),
                  ElevatedButton(
                      onPressed: doSomething,
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: defaultPadding),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                          backgroundColor: Colors.pink,
                          minimumSize: Size(100, 30)),
                      child: Text(
                        "Upload",
                        style: TextStyle(color: whiteColor),
                      ))
                ],
              ),
            ));
  }
}
