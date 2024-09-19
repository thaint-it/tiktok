import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/history_post_model.dart';

class LockPost extends StatefulWidget {
  const LockPost({super.key});

  @override
  State<LockPost> createState() => _LockPostState();
}

class _LockPostState extends State<LockPost> {
  List<HistoryPostModel> posts = [
    // HistoryPostModel(thumbnail: "assets/posts/c1.jpg", id: 1, viewCount: 5555),
    // HistoryPostModel(thumbnail: "assets/posts/c2.jpg", id: 1, viewCount: 1222),
    // HistoryPostModel(thumbnail: "assets/posts/c3.jpg", id: 1, viewCount: 854),
    // HistoryPostModel(thumbnail: "assets/posts/c4.jpg", id: 1, viewCount: 854),
    // HistoryPostModel(thumbnail: "assets/posts/c5.jpg", id: 1, viewCount: 5555),
  ];
  @override
  Widget build(BuildContext context) {
    return posts.isNotEmpty? GridView.builder(
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
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: SvgPicture.asset(
                      "assets/icons/lock.svg",
                      width: 16,
                      colorFilter:
                          ColorFilter.mode(whiteColor, BlendMode.srcIn),
                    ))
              ],
            ))):Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding*3, horizontal: defaultPadding*2),
            child: Center(
              child: Column(
                children: [
                  Text("Private videos", style: TextStyle(color: blackColor,fontWeight: FontWeight.bold, fontSize: 16),),
                  const SizedBox(height: defaultPadding/2,),
                  Text("To make your video only visible to you, set them to 'Private' in settings.", textAlign: TextAlign.center,),
                ],
              ),
            ));
  }
}
