// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter_svg/svg.dart';
import 'package:tiktok_clone/api/post.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/models/post/post.dart';
import 'package:tiktok_clone/screens/comment/views/comment.dart';
import 'package:tiktok_clone/screens/post/views/post_item.dart';

class AppBarItem {
  String text;
  bool isSelected;

  AppBarItem({required this.text, this.isSelected = false});
}

class PostScreen extends StatefulWidget {
  const PostScreen({super.key, this.id});
  final int? id;

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
  List<AppBarItem> homeAppBarItems = [
    AppBarItem(text: "Friends", isSelected: false),
    AppBarItem(text: "Following", isSelected: false),
    AppBarItem(text: "For you", isSelected: true),
  ];

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


  final PageController _pageController = PageController(initialPage: 0);

  List<Post> posts = []; // Danh sách URL video
  final int perPage = 2;
  int page = 1;
  int currentPage = 0;
  bool isLoading = false;
  bool hasNext = true;
  PostService postService = getIt<PostService>();

  // Giả lập tải video ban đầu
  Future<void> loadInitialPosts() async {
    PostPagination? initialPost =
        await postService.fetchPosts(page: page, perPage: perPage);

    setState(() {
      posts.addAll(initialPost.posts!);
      hasNext = initialPost.hasNext!;
    });
  }

  // Load special post
  Future<void> loadPostById(int id) async {
    Post initialPost = await postService.fetchPostById(id);

    setState(() {
      posts.add(initialPost);
    });
    loadInitialPosts();
  }

  // reload new data
  Future<void> refreshPage() async {
    setState(() {
      page = 1;
      hasNext = true;
    });
    await loadInitialPosts();
  }

  // Tải thêm video khi tới gần cuối danh sách
  Future<void> loadMoreVideos() async {
    if (hasNext) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
      }
      PostPagination? morePost =
          await postService.fetchPosts(page: page + 1, perPage: perPage);
      setState(() {
        posts.addAll(morePost.posts!);
        isLoading = false;
        page = page + 1;
        hasNext = morePost.hasNext!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      loadPostById(widget.id!);
    } else {
      loadInitialPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: blackColor,
        appBar: AppBar(
          toolbarHeight: 40,
          forceMaterialTransparency: true,
          backgroundColor: Colors.black,
          leading: const SizedBox(),
          leadingWidth: 0,
          centerTitle: false,
          title: Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset(
              "assets/icons/live.svg",
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              width: 24,
            ),
          ),
          actions: [
            ...homeAppBarItems.asMap().entries.map((entry) {
              AppBarItem item = entry.value;
              return TextButton(
                onPressed: () => {},
                child: Column(
                  children: [
                    Text(item.text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: item.isSelected
                                ? FontWeight.bold
                                : FontWeight.normal)),
                    item.isSelected
                        ? Container(height: 2, width: 30, color: Colors.white)
                        : SizedBox(height: 2)
                  ],
                ),
              );
            }),
            Align(
              alignment: Alignment.topCenter,
              child: IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, searchScreenRoute);
                },
                icon: SvgPicture.asset(
                  "assets/icons/search.svg",
                  height: 24,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            )
          ],
        ),
        body: RefreshIndicator(
            onRefresh: refreshPage,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical, // vertical scroll
              itemCount: posts.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });

                // Kiểm tra xem người dùng đã gần đến cuối danh sách chưa
                if (index == posts.length - 1) {
                  loadMoreVideos(); // Tải thêm video
                }
              },

              itemBuilder: (context, index) {
                return VideoPost(post: posts[index]);
              },
            )));
  }
}
