// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:tiktok_clone/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:tiktok_clone/screens/comment/views/comment.dart';

class AppBarItem {
  String text;
  bool isSelected;

  AppBarItem({required this.text, this.isSelected = false});
}

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isLiked = false;
  bool isMarked = false;
  int likeCount = 998;
  int markCount = 111;
  int commentCount = 99;
  int shareCount = 111;
  List<AppBarItem> appBarItems = [
    AppBarItem(text: "Bạn bè", isSelected: false),
    AppBarItem(text: "Đang Follow", isSelected: false),
    AppBarItem(text: "Dành cho bạn", isSelected: true),
  ];

  @override
  Widget build(BuildContext context) {
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

    buildProfile({double size = 60}) {
      return SizedBox(
        width: size + 10,
        height: size + 10,
        child: Stack(children: [
          Positioned(
            child: Container(
              width: size,
              height: size,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size / 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size / 2),
                child: Image.asset(
                  "assets/icons/profile.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ]),
      );
    }

    buildLikeButton(isLiked) {
      return Icon(Icons.favorite,
          size: 32, color: isLiked ? Colors.red : Colors.white);
    }

    buildBookmarkButton(isMarked) {
      return Icon(
        Icons.bookmark,
        size: 32,
        color: isMarked ? Colors.orange : Colors.white,
      );
    }

    genCount(count) {
      return Text(count.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold));
    }

    Future<bool> handleLikeTap(_isLiked) {
      setState(() {
        isLiked = !_isLiked;
        likeCount = _isLiked ? likeCount - 1 : likeCount + 1;
      });
      return Future.value(!_isLiked);
    }

    Future<bool> handleMarkTap(_isMarked) {
      setState(() {
        isMarked = !_isMarked;
        markCount = _isMarked ? markCount - 1 : markCount + 1;
      });
      return Future.value(!_isMarked);
    }

    void showComment() {
      showModalBottomSheet(context: context, builder: (ctx) => CommentScreen());
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
              color: Colors.black,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/flutter.png",
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      widthFactor: 40,
                      child: Padding(
                          padding: const EdgeInsets.all(defaultPadding / 4),
                          child: Container(
                              width: 60,
                              color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(children: [
                                        buildProfile(size: 60),
                                        Positioned(
                                            right: 0,
                                            left: 0,
                                            bottom: 0,
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: svgIcon(
                                                      "assets/icons/plus.svg",
                                                      color: Colors.white,
                                                      height: 12)),
                                            )),
                                      ]),
                                      const SizedBox(
                                        height: defaultPadding,
                                      ),
                                      LikeButton(
                                        size: 30,
                                        isLiked: isLiked,
                                        likeBuilder: (_isLiked) =>
                                            buildLikeButton(_isLiked),
                                        onTap: (_isLiked) =>
                                            handleLikeTap(_isLiked),
                                      ),
                                      const SizedBox(
                                          height: defaultPadding / 8),
                                      genCount(likeCount),
                                      const SizedBox(
                                        height: defaultPadding,
                                      ),
                                      LikeButton(
                                        size: 30,
                                        isLiked: isMarked,
                                        likeBuilder: (_isMarked) =>
                                            buildBookmarkButton(_isMarked),
                                        onTap: (_isMarked) =>
                                            handleMarkTap(_isMarked),
                                      ),
                                      const SizedBox(
                                          height: defaultPadding / 8),
                                      genCount(markCount),
                                      const SizedBox(height: defaultPadding),
                                      InkWell(
                                        onTap: showComment,
                                        child: svgIcon(
                                            "assets/icons/comment.svg",
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                          height: defaultPadding / 8),
                                      genCount(commentCount),
                                      const SizedBox(height: defaultPadding),
                                      InkWell(
                                        onTap: () => {},
                                        child: svgIcon("assets/icons/share.svg",
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                          height: defaultPadding / 8),
                                      genCount(shareCount),
                                      const SizedBox(height: defaultPadding),
                                      buildProfile(size: 48)
                                    ],
                                  ),
                                ],
                              )))),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: defaultPadding / 2,
                            bottom: defaultPadding / 2,
                            right: 120),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "T11N",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                                "Phần 1 | Tự học code flutter #flutter  #coder",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))
                          ],
                        ),
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
