import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/history_post_model.dart';

class BookmarkPost extends StatefulWidget {
  const BookmarkPost({super.key});

  @override
  State<BookmarkPost> createState() => _BookmarkPostState();
}

class _BookmarkPostState extends State<BookmarkPost> {
  List<HistoryPostModel> posts = [
    HistoryPostModel(thumbnail: "assets/posts/1.jpg", id: 1, viewCount: 5555),
    HistoryPostModel(thumbnail: "assets/posts/2.jpg", id: 1, viewCount: 333),
    HistoryPostModel(thumbnail: "assets/posts/3.jpg", id: 1, viewCount: 854),
    HistoryPostModel(thumbnail: "assets/posts/4.jpg", id: 1, viewCount: 854),
    HistoryPostModel(thumbnail: "assets/posts/5.jpg", id: 1, viewCount: 5555),
    HistoryPostModel(thumbnail: "assets/posts/6.jpg", id: 1, viewCount: 12232),
    HistoryPostModel(thumbnail: "assets/posts/7.jpg", id: 1, viewCount: 854),
    HistoryPostModel(thumbnail: "assets/posts/8.jpg", id: 1, viewCount: 854),
    HistoryPostModel(thumbnail: "assets/posts/9.jpg", id: 1, viewCount: 5555),
    HistoryPostModel(thumbnail: "assets/posts/1.jpg", id: 1, viewCount: 43),
    HistoryPostModel(thumbnail: "assets/posts/2.jpg", id: 1, viewCount: 854),
    HistoryPostModel(thumbnail: "assets/posts/5.jpg", id: 1, viewCount: 854),
    HistoryPostModel(thumbnail: "assets/posts/4.jpg", id: 1, viewCount: 323),
    HistoryPostModel(thumbnail: "assets/posts/7.jpg", id: 1, viewCount: 1222),
    HistoryPostModel(thumbnail: "assets/posts/8.jpg", id: 1, viewCount: 854),
    HistoryPostModel(thumbnail: "assets/posts/6.jpg", id: 1, viewCount: 854),
    HistoryPostModel(thumbnail: "assets/posts/9.jpg", id: 1, viewCount: 854),
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
                    ))
              ],
            ))):Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding*3),
            child: Center(
              child: Column(
                children: [
                  Text("Favorites videos", style: TextStyle(color: blackColor,fontWeight: FontWeight.bold, fontSize: 16),),
                  const SizedBox(height: defaultPadding/2,),
                  Text("Your favarite videos will apear here"),
                  const SizedBox(height: defaultPadding / 2),
                ],
              ),
            ));
  }
}
