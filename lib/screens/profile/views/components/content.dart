import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/profile/views/components/bookmark_post.dart';
import 'package:tiktok_clone/screens/profile/views/components/history_post.dart';
import 'package:tiktok_clone/screens/profile/views/components/liked_post.dart';
import 'package:tiktok_clone/screens/profile/views/components/lock_post.dart';

class Content extends StatefulWidget {
  const Content(
      {super.key, required this.selectedIndex, required this.onIndexChanged});
  final int selectedIndex;
  final ValueChanged<int> onIndexChanged; // Callback with an int parameter
  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  late PageController pageController;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.selectedIndex);
    selectedIndex = widget.selectedIndex;
  }

  @override
  void dispose() {
    selectedIndex = 0;
    pageController.dispose();
    super.dispose();
  }

  List<String> items = [
    "assets/icons/filter.svg",
    "assets/icons/lock.svg",
    "assets/icons/bookmark.svg",
    "assets/icons/hidden-like.svg"
  ];


  @override
  void didUpdateWidget(Content oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Detect when selectedIndex changes
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      pageController.jumpToPage(widget.selectedIndex);
      selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 1000,
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                  widget.onIndexChanged(
                      index); // Cập nhật khi kéo sang trang khác
                });
              },
              controller: pageController,
              children: [
                HistoryPost(),
                LockPost(),
                BookmarkPost(),
                LikedPost()
              ],
            ))
      ],
    );
  }
}
