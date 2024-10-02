import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tiktok_clone/components/avatar.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/auth/user.dart';
import 'package:tiktok_clone/screens/message/views/components/profile.dart';

class DetailMessageScreen extends StatefulWidget {
  const DetailMessageScreen({super.key, required this.user});
  final User user;

  @override
  State<DetailMessageScreen> createState() => _DetailMessageScreenState();
}

class _DetailMessageScreenState extends State<DetailMessageScreen> {
  @override
  Widget build(BuildContext context) {
    Widget buildTag(IconData? icon, String? text, Color color) {
      return Container(
          padding: const EdgeInsets.symmetric(
              vertical: 4, horizontal: defaultPadding),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20)),
          child: icon != null
              ? Icon(
                  icon,
                  color: color,
                )
              : Text(text!, style: TextStyle(color: color)));
    }

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 48,
          forceMaterialTransparency: true,
          backgroundColor: whiteColor,
          leading: IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black54,
              )),
          leadingWidth: 20,
          centerTitle: false,
          title: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                  onPressed: () => {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Avatar(
                        size: 16,
                        url: widget.user.avatar,
                        isNetwork: true,
                        name: widget.user.username,
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.user.firstName!,
                            style: TextStyle(
                                fontSize: 16,
                                color: blackColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: defaultPadding / 16,
                          ),
                          Text(
                            "Active 36m ago",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  ))),
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, searchScreenRoute);
                },
                icon: Icon(
                  Icons.flag_outlined,
                  color: blackColor,
                )),
            IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, searchScreenRoute);
                },
                icon: Icon(
                  Icons.more_horiz_outlined,
                  color: blackColor,
                ))
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(5), // Height of the bottom border
            child: Container(
              color: Colors.grey, // Border color
              height: 0.5, // Border height
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: MessageProfile(user: widget.user),
            )
          ],
        ),
        bottomNavigationBar: Container(
            color: Colors.grey.shade50,
            child: Padding(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding * 2,
                    top: defaultPadding,
                    left: defaultPadding,
                    right: defaultPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        buildTag(Icons.favorite, "", Colors.pink),
                        const SizedBox(
                          width: defaultPadding / 2,
                        ),
                        buildTag(Icons.thumb_up, "",
                            Colors.lightBlueAccent.shade400),
                        const SizedBox(
                          width: defaultPadding / 2,
                        ),
                        buildTag(Icons.tag_faces_sharp, "", Colors.deepOrange),
                      ],
                    ),
                    const SizedBox(
                      height: defaultPadding / 2,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding / 2,
                          vertical: defaultPadding / 4),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent.shade400,
                                shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                "A",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Expanded(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight:
                                    100, // Set max height of the input field
                              ),
                              child: TextField(
                                // controller: _controller,
                                maxLines: null, // Auto-expands based on content
                                decoration: InputDecoration(
                                    hintText: 'Message...',
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width:
                                40, // Width and height should be the same for a circle
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.pink, // Background color
                              shape: BoxShape.circle, // Circle shape
                            ),
                            child: Center(
                              child: Transform.rotate(
                                angle: -25 *
                                    (3.14159 /
                                        180), // Convert degrees to radians
                                child: IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
