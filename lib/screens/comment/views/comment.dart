// ignore_for_file: unused_import, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/api/post.dart';
import 'package:tiktok_clone/components/avatar.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/models/auth/user.dart';
import 'package:tiktok_clone/models/comment/comment.dart';
import 'package:tiktok_clone/models/post/post.dart';
import 'package:tiktok_clone/providers/user_data_provider.dart';
import 'package:tiktok_clone/screens/comment/views/components/comment_item.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key, required this.post});
  final Post post;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<Comment> comments = [];
  late final TextEditingController textController =
      TextEditingController(text: "");
  PostService postService = getIt<PostService>();
  late FocusNode focusNode;
  Comment? replyComment;

  // Giả lập tải video ban đầu
  Future<void> fetchComments(id) async {
    final data = await postService.listComment(widget.post.id);
    setState(() {
      comments = data!;
    });
  }

  // Giả lập tải video ban đầu
  Future<void> fetchNewComment(id) async {
    Comment newComment = await postService.commentById(id);
    setState(() {
      if (newComment.parentId != null) {
        final parent =
            comments.firstWhere((entry) => entry.id == newComment.parentId);
        if (parent.children == null) {
          parent.children = [newComment];
        } else {
          parent.children!.add(newComment);
        }
      } else {
        comments.add(newComment);
      }
    });
  }

  Future<void> addComment(User user) async {
    final newComment = Comment(
        content: textController.text,
        createdAt: DateTime.now(),
        children: [],
        user: user);
    if (replyComment != null) {
      replyComment!.children!.add(newComment);
    } else {
      comments.add(newComment);
    }
    await postService.addComment({
      "post_id": widget.post.id,
      "content": newComment.content,
      "parent_id": replyComment?.id
    });
    setState(() {
      replyComment = null;
    });
    textController.clear();
    FocusScope.of(context).unfocus(); // Hide keyboard
  }

  void handleReplyComment(Comment parentComment) {
    setState(() {
      replyComment = parentComment;
      focusNode.requestFocus();
    });
  }

  WebSocketChannel? channel;
  Future<void> initSignal(int id) async {
    channel = WebSocketChannel.connect(
      Uri.parse(
          'ws://${Endpoints.socketURL}/ws/comment/${widget.post.id.toString()}/'), // Update with your server URL
    );
    channel!.stream.listen((message) {
      // // Handle incoming messages
      final data = jsonDecode(message);
      print("comment $data");

      if (data["type"] == "NEW_COMMENT") {
        fetchNewComment(data["id"]);
      }
      // You can also update your UI here
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
    textController.addListener(() {
      setState(() {}); // Rebuild the widget on text change
    });
    fetchComments(widget.post.id);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    initSignal(userProvider.user!.id!);
  }

  @override
  void dispose() {
    focusNode.dispose(); // Dispose of the FocusNode when not needed
    channel!.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    // Use MediaQuery to get the viewInsets (keyboard height)
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, keyboardHeight),
      height: MediaQuery.of(context).size.height * 3 / 4,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.2, color: blackColor40))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Align(
                  child: Text(
                    "${widget.post.commentCount} Comments",
                    style: TextStyle(color: Colors.black),
                  ),
                )),
                const SizedBox(width: defaultPadding * 2),
                IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: SvgPicture.asset(
                      "assets/icons/close.svg",
                      width: 16,
                      colorFilter:
                          ColorFilter.mode(blackColor60, BlendMode.srcIn),
                    )),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2,
                          vertical: defaultPadding),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 0.2, color: blackColor40))),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Avatar(
                                size: 18,
                                url: widget.post.user!.avatar,
                                isNetwork: true,
                                name: widget.post.user!.firstName),
                            const SizedBox(
                              width: defaultPadding / 2,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.post.user!.firstName!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: blackColor80),
                                    ),
                                    const SizedBox(
                                      width: defaultPadding / 2,
                                    ),
                                    Text(
                                      "Creator",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.pinkAccent),
                                    )
                                  ],
                                ),
                                //user name

                                const SizedBox(height: defaultPadding / 8),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: widget.post.title!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: ' - 3d',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black87),
                                  ),
                                ]))
                              ],
                            ))
                          ]),
                    ),
                    ...comments.asMap().entries.map((entry) {
                      Comment comment = entry.value;
                      return CommentItem(
                          comment: comment,
                          authorId: widget.post.user!.id!,
                          replyComment: handleReplyComment);
                    })
                  ],
                )),
          )),
          Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 0.5, color: blackColor40))),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      color: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: defaultPadding * 2,
                              top: 0,
                              left: defaultPadding / 2,
                              right: defaultPadding / 2),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: defaultPadding / 2,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultPadding / 4,
                                    vertical: defaultPadding / 4),
                                child: Row(
                                  children: [
                                    Avatar(
                                        size: 16,
                                        url: userProvider.user!.avatar,
                                        isNetwork: true,
                                        name: userProvider.user!.username),
                                    const SizedBox(
                                      width: defaultPadding / 2,
                                    ),
                                    Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: defaultPadding),
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxHeight:
                                                          100, // Set max height of the input field
                                                    ),
                                                    child: TextField(
                                                      controller:
                                                          textController,
                                                      focusNode: focusNode,
                                                      autofocus: false,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                      maxLines:
                                                          null, // Auto-expands based on content
                                                      decoration: InputDecoration(
                                                          hintStyle: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 14),
                                                          hintText: replyComment ==
                                                                  null
                                                              ? 'Add comment...'
                                                              : 'Reply ${replyComment!.user!.firstName!}',
                                                          border:
                                                              InputBorder.none),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                IconButton(
                                                  onPressed: () => {
                                                    if (textController
                                                        .text.isNotEmpty)
                                                      addComment(User(
                                                          id: userProvider
                                                              .user!.id,
                                                          avatar: userProvider
                                                              .user!.avatar,
                                                          firstName:
                                                              userProvider.user!
                                                                  .username))
                                                  },
                                                  icon: Container(
                                                    width:
                                                        40, // Width and height should be the same for a circle
                                                    height: 28,
                                                    decoration: BoxDecoration(
                                                        color: textController
                                                                .text.isNotEmpty
                                                            ? Colors.pink
                                                            : Colors.grey
                                                                .shade400, // Background color
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.arrow_upward,
                                                      size: 16,
                                                      color: Colors.white,
                                                    )),
                                                  ),
                                                )
                                              ],
                                            ))),
                                  ],
                                ),
                              ),
                            ],
                          )))))
        ],
      ),
    );
  }
}
