// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/components/avatar.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/comment/comment.dart';
import 'package:tiktok_clone/providers/user_data_provider.dart';
import 'package:tiktok_clone/utils/utils.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({super.key, required this.comment, required this.authorId,required this.replyComment});
  final Comment comment;
  final int authorId;
  final Function(Comment parentComment) replyComment;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  buildComment(Comment comment, isRoot, authorId) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Avatar(
          size: isRoot ? 18 : 14,
          url: comment.user!.avatar,
          isNetwork: true,
          name: comment.user!.firstName),
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
                comment.user!.firstName!,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: blackColor80),
              ),
              const SizedBox(
                width: defaultPadding / 2,
              ),
              comment.user!.id! == authorId
                  ? Text(
                      "Creator",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent),
                    )
                  : const SizedBox()
            ],
          ),
          //user name

          const SizedBox(height: defaultPadding / 8),
          Text(comment.content!),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Utils.calculateTimeDifference(comment.createdAt),
                style: TextStyle(color: blackColor40, fontSize: 12),
              ),
              const SizedBox(
                width: defaultPadding / 4,
              ),
              SizedBox(
                height: 30,
                width: 50, // Set a fixed width
                child: TextButton(
                  onPressed: () => {widget.replyComment(widget.comment)},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                  ),
                  child: Text(
                    "Reply",
                    style: TextStyle(color: blackColor60),
                  ),
                ),
              )
            ],
          ),
          isRoot
              ? Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ...widget.comment.children!.asMap().entries.map((entry) {
                        Comment childComment = entry.value;
                        return buildComment(
                            childComment, false, widget.authorId);
                      })
                    ],
                  ),
                )
              : SizedBox()
        ],
      ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Padding(
        padding: const EdgeInsets.all(defaultPadding / 2),
        child: buildComment(widget.comment, true, widget.authorId));
  }
}
