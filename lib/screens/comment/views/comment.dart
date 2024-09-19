// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/comment/comment.dart';
import 'package:tiktok_clone/models/comment/comment_data.dart';
import 'package:tiktok_clone/screens/comment/views/components/comment_item.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<CommentData> comments = [
    // CommentData(
    //     id: 1,
    //     content: "này cực với vất vả lắm cố gắng với đam mê nhé bạn",
    //     userName: "..._57505",
    //     created: DateTime.now(),
    //     avatar: "assets/avatars/av1.jpg",
    //     children: [
    //       CommentData(
    //           id: 2,
    //           parentId: 1,
    //           text: "Theo nghề này thì phải cố gắng thôi bác",
    //           userName: "T11n",
    //           created: "12 giờ",
    //           avatar: "assets/avatars/me.jpg",
    //           isCreator: true),
    //     ]),
    // Comment(
    //     id: 3,
    //     text: "Xin nguồn tự học ạ",
    //     userName: "Akova Duong",
    //     created: "10 giờ",
    //     avatar: "assets/avatars/av2.jpg",
    //     children: [
    //       Comment(
    //           id: 2,
    //           parentId: 1,
    //           text:
    //               "Đọc docs thôi ạ. Search thêm vài source template xem cách người ta tổ chức code với dùng thư viện bên thứ 3. Mình cũng mới học được vài hôm",
    //           userName: "T11n",
    //           created: "12 giờ",
    //           avatar: "assets/avatars/me.jpg",
    //           isCreator: true),
    //       Comment(
    //           id: 2,
    //           parentId: 1,
    //           text: "Bác có link template không cho em xin với",
    //           userName: "Tiktoker 1",
    //           created: "1 giờ",
    //           avatar: "assets/avatars/av3.jpg",
    //           isCreator: false),
    //       Comment(
    //           id: 2,
    //           parentId: 1,
    //           text:
    //               "bác lên google seach flutter code git template là ra 1 đống",
    //           userName: "T11N",
    //           created: "1 giờ",
    //           avatar: "assets/avatars/me.jpg",
    //           isCreator: true),
    //       Comment(
    //           id: 2,
    //           parentId: 1,
    //           text: "Ok thank bác.",
    //           userName: "Tiktoker 1",
    //           created: "1 giờ",
    //           avatar: "assets/avatars/av3.jpg",
    //           isCreator: false),
    //         Comment(
    //           id: 2,
    //           parentId: 1,
    //           text:
    //               "Bác có thắc mắc gì thì comment mình biết thì giải đáp cho, không thì nhờ mấy ae giải đáp hộ.",
    //           userName: "T11N",
    //           created: "vừa xong",
    //           avatar: "assets/avatars/me.jpg",
    //           isCreator: true),
    //     ])
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.5, color: blackColor40))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            child: Container(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          bottom: defaultPadding / 2),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black,
                                                  width: 1))),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/message-outline.svg",
                                            width: 18,
                                            colorFilter: ColorFilter.mode(
                                                blackColor60, BlendMode.srcIn),
                                          ),
                                          const SizedBox(
                                              width: defaultPadding / 4),
                                          Text("99")
                                        ],
                                      ),
                                    )))),
                      ),
                      Expanded(
                        child: InkWell(
                            child: Container(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          bottom: defaultPadding / 2),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.white,
                                                  width: 1))),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/heart-outline.svg",
                                            width: 18,
                                            colorFilter: ColorFilter.mode(
                                                blackColor60, BlendMode.srcIn),
                                          ),
                                          const SizedBox(
                                              width: defaultPadding / 4),
                                          Text("998")
                                        ],
                                      ),
                                    )))),
                      ),
                      Expanded(
                        child: InkWell(
                            child: Container(
                                padding: EdgeInsets.all(defaultPadding / 2),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          bottom: defaultPadding / 2),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.white,
                                                  width: 0))),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/play-outline.svg",
                                            width: 18,
                                            colorFilter: ColorFilter.mode(
                                                blackColor60, BlendMode.srcIn),
                                          ),
                                          const SizedBox(
                                              width: defaultPadding / 4),
                                          Text("5555")
                                        ],
                                      ),
                                    )))),
                      ),
                    ],
                  )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: defaultPadding * 2),
                      IconButton(
                          onPressed: () => {},
                          icon: SvgPicture.asset(
                            "assets/icons/filter.svg",
                            width: 18,
                            colorFilter:
                                ColorFilter.mode(blackColor60, BlendMode.srcIn),
                          )),
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
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ...comments.asMap().entries.map((entry) {
                        CommentData comment = entry.value;
                        return CommentItem(comment: comment);
                      })
                    ],
                  )),
            ))
          ],
        ));
  }
}
