// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:http/http.dart';
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/api/post.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/models/post/post.dart';
import 'package:tiktok_clone/screens/comment/views/comment.dart';
import 'package:tiktok_clone/screens/post/views/components/video_player.dart';
import 'package:tiktok_clone/utils/utils.dart';

class AppBarItem {
  String text;
  bool isSelected;

  AppBarItem({required this.text, this.isSelected = false});
}

class VideoPost extends StatefulWidget {
  const VideoPost({super.key, required this.post});
  final Post post;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  bool isLiked = false;
  bool isMarked = false;
  int likeCount = 0;
  int markCount = 0;
  int commentCount = 0;
  int shareCount = 0;
  List<AppBarItem> appBarItems = [
    AppBarItem(text: "Bạn bè", isSelected: false),
    AppBarItem(text: "Đang Follow", isSelected: false),
    AppBarItem(text: "Dành cho bạn", isSelected: true),
  ];

  PostService postService = getIt<PostService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      markCount = widget.post.favoriteCount!;
      likeCount = widget.post.likeCount!;
      shareCount = widget.post.shareCount!;
      commentCount = widget.post.commentCount!;
    });
  }

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
                child: Image.network(
                  Utils.resolveUrl(Endpoints.baseURL, widget.post.user!.avatar),
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
      final data = {"post_id": widget.post.id!};
      postService.postActivity("LIKE", data);
      setState(() {
        isLiked = !_isLiked;
        likeCount = _isLiked ? likeCount - 1 : likeCount + 1;
      });
      return Future.value(!_isLiked);
    }

    Future<bool> handleMarkTap(_isMarked) {
      final data = {"post_id": widget.post.id!};
      postService.postActivity("FAVORITE", data);
      setState(() {
        isMarked = !_isMarked;
        markCount = _isMarked ? markCount - 1 : markCount + 1;
      });
      return Future.value(!_isMarked);
    }

    void showComment() {
      showModalBottomSheet(context: context, builder: (ctx) => CommentScreen());
    }

    return Stack(
      children: [
        Container(
            color: Colors.black,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Align(
                    alignment: Alignment.bottomCenter,
                    child: TiktokVideoPlayer(
                        videoUrl:
                            Utils.getUrl(widget.post.url)) // Hiển thị video
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                                decoration: const BoxDecoration(
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
                                    const SizedBox(height: defaultPadding / 8),
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
                                    const SizedBox(height: defaultPadding / 8),
                                    genCount(markCount),
                                    const SizedBox(height: defaultPadding),
                                    InkWell(
                                      onTap: showComment,
                                      child: svgIcon("assets/icons/comment.svg",
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: defaultPadding / 8),
                                    genCount(commentCount),
                                    const SizedBox(height: defaultPadding),
                                    InkWell(
                                      onTap: () => {},
                                      child: svgIcon("assets/icons/share.svg",
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: defaultPadding / 8),
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
                          bottom: defaultPadding * 2,
                          right: 120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.user!.username!,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(widget.post.title!,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white))
                        ],
                      ),
                    ))
              ],
            )),
      ],
    );
  }
}
