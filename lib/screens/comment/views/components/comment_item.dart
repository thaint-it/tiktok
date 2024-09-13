// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:tiktok_clone/components/avatar.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/comment_model.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({super.key, required this.comment});
  final CommentModel comment;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  buildComment(CommentModel comment, isRoot) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Avatar(size: isRoot ? 24 : 16, url: comment.avatar),
      const SizedBox(
        width: defaultPadding / 2,
      ),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: defaultPadding / 2),
          Row(
            children: [
              Text(
                comment.fullName,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: blackColor80),
              ),
              const SizedBox(
                width: defaultPadding / 2,
              ),
              comment.isCreator == true
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

          const SizedBox(height: defaultPadding / 4),
          Text(comment.text),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                comment.time,
                style: TextStyle(color: blackColor40, fontSize: 12),
              ),
              const SizedBox(
                width: defaultPadding / 2,
              ),
              TextButton(
                  onPressed: () => {},
                  child: Text(
                    "Trả lời",
                    style: TextStyle(color: blackColor60),
                  ))
            ],
          ),
          isRoot
              ? Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ...widget.comment.childComments
                          .asMap()
                          .entries
                          .map((entry) {
                        CommentModel childComment = entry.value;
                        return buildComment(childComment, false);
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
    return Padding(
        padding: const EdgeInsets.all(defaultPadding / 2),
        child: buildComment(widget.comment, true));
  }
}
