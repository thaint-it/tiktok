import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/api/enpoints.dart';
import 'package:tiktok_clone/api/message.dart';
import 'package:tiktok_clone/components/avatar.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/models/auth/user.dart';
import 'package:tiktok_clone/models/message/message.dart';
import 'package:tiktok_clone/providers/user_data_provider.dart';
import 'package:tiktok_clone/screens/message/views/components/profile.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class DetailMessageScreen extends StatefulWidget {
  const DetailMessageScreen({super.key, required this.user});
  final User user;

  @override
  State<DetailMessageScreen> createState() => _DetailMessageScreenState();
}

class _DetailMessageScreenState extends State<DetailMessageScreen>
    with WidgetsBindingObserver {
  WebSocketChannel? channel;
  List<Message> messages = []; // Danh sách URL video
  final int perPage = 20;
  int page = 1;
  int currentPage = 0;
  bool isLoading = false;
  bool hasNext = true;
  User? currentUser;
  bool isKeyboardVisible = false;
  double scrollRatio = 1;
  MessageService messageService = getIt<MessageService>();
  final ScrollController scrollController = ScrollController();
  late final TextEditingController textController =
      TextEditingController(text: "");

  // Giả lập tải video ban đầu
  Future<void> fetchMessages() async {
    MessagePagination? initialMessages = await messageService.fetchMessages(
        userId: widget.user.id!, page: page, perPage: perPage);

    setState(() {
      messages = initialMessages.messages!;
      hasNext = initialMessages.hasNext!;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  // Giả lập tải video ban đầu
  Future<void> getMessage(id) async {
    Message? message = await messageService.getMessages(id: id);
    setState(() {
      messages.add(message);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  Future<void> sendMessage() async {
    final newMessage = Message(
        content: textController.text,
        toUser: widget.user,
        fromUser: currentUser!,
        isSending: true);
    textController.clear();
    setState(() {
      messages.add(newMessage);
    });
    FocusScope.of(context).unfocus(); // Hide keyboard
    // Unfocus and scroll after the frame has settled
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // scrollToBottom();
    });

    await messageService.createMessage(data: {
      "content": newMessage.content,
      "to_user_id": newMessage.toUser!.id,
      "parent_id": null
    });
    // Sleep for 1 second
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      newMessage.isSending = false;
    });
  }

  Future<void> initSignal(User user) async {
    channel = WebSocketChannel.connect(
      Uri.parse(
          'ws://${Endpoints.socketURL}/ws/messages/${user.id}/'), // Update with your server URL
    );
    channel!.stream.listen((message) {
      // // Handle incoming messages
      final data = jsonDecode(message);
      if (data["type"] == "NEW_MESSAGE") {
        getMessage(data["id"]);
      }
      // You can also update your UI here
    });
  }

  void scrollToBottom() {
    // Animate to the bottom of the scroll view
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    currentUser = User(id: userProvider.user!.id);
    initSignal(currentUser!);
    textController.addListener(() {
      setState(() {}); // Rebuild the widget on text change
    });
    fetchMessages();
    // Use addPostFrameCallback to ensure the listener runs after the frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(() {
        final offset = scrollController.offset;
        final maxScrollExtent = scrollController.position.maxScrollExtent;

        if (maxScrollExtent > 0) {
          // Ensure maxScrollExtent is valid
          setState(() {
            scrollRatio = offset / maxScrollExtent;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.dispose(); // Dispose of the controller
    channel!.sink.close();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    // Check if the keyboard is visible
    setState(() {
      isKeyboardVisible = bottomInset > 0;
    });

    // Scroll to bottom after the keyboard is shown or hidden
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget buildTag(IconData? icon, String? text, Color color) {
    //   return Container(
    //       padding: const EdgeInsets.symmetric(
    //           vertical: 4, horizontal: defaultPadding),
    //       decoration: BoxDecoration(
    //           color: Colors.grey.shade200,
    //           shape: BoxShape.rectangle,
    //           borderRadius: BorderRadius.circular(20)),
    //       child: icon != null
    //           ? Icon(
    //               icon,
    //               color: color,
    //             )
    //           : Text(text!, style: TextStyle(color: color)));
    // }

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        resizeToAvoidBottomInset: true,
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
        body: Stack(children: [
          // Main content here
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: MessageProfile(user: widget.user),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            final message = messages[index];
                            bool isMe = message.fromUser!.id == currentUser!.id;
                            bool showAvatar = !isMe &&
                                (index == messages.length - 1 ||
                                    (index < messages.length - 1 &&
                                        messages[index + 1].toUser!.id ==
                                            widget.user.id));

                            return Align(
                                alignment: isMe
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.75, // 75% of screen width
                                  ),
                                  child: Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: defaultPadding / 4,
                                          horizontal: defaultPadding),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                              mainAxisAlignment: isMe
                                                  ? MainAxisAlignment.end
                                                  : MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (showAvatar)
                                                  Avatar(
                                                    size: 16,
                                                    url: message
                                                        .fromUser!.avatar,
                                                    isNetwork: true,
                                                    name: message
                                                        .fromUser!.tiktokId,
                                                  ),
                                                const SizedBox(
                                                  width: defaultPadding / 2,
                                                ),
                                                Flexible(
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.only(
                                                        left: !showAvatar
                                                            ? 24 +
                                                                defaultPadding /
                                                                    2
                                                            : 0),
                                                    decoration: BoxDecoration(
                                                      color: isMe
                                                          ? Colors.blue
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      message.content!,
                                                      style: TextStyle(
                                                          color: isMe
                                                              ? Colors.white
                                                              : Colors.black),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                          if (isMe &&
                                              index == messages.length - 1)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical:
                                                          defaultPadding / 4,
                                                      horizontal:
                                                          defaultPadding / 2),
                                              child: Text(
                                                  messages[index].isSending ==
                                                          true
                                                      ? "sending..."
                                                      : "sent"),
                                            )
                                        ],
                                      )),
                                ));
                          },
                          childCount: messages.length,
                        ),
                      )
                    ],
                  ),
                ),
                // Input field at the bottom, floating above the keyboard
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        color: Colors.grey.shade50,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: defaultPadding * 2,
                                top: 0,
                                left: defaultPadding,
                                right: defaultPadding),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Row(
                                //   children: [
                                //     buildTag(Icons.favorite, "", Colors.pink),
                                //     const SizedBox(
                                //       width: defaultPadding / 2,
                                //     ),
                                //     buildTag(Icons.thumb_up, "",
                                //         Colors.lightBlueAccent.shade400),
                                //     const SizedBox(
                                //       width: defaultPadding / 2,
                                //     ),
                                //     buildTag(Icons.tag_faces_sharp, "",
                                //         Colors.deepOrange),
                                //   ],
                                // ),
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
                                            color:
                                                Colors.lightBlueAccent.shade400,
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
                                            autofocus: false,
                                            controller: textController,
                                            maxLines:
                                                null, // Auto-expands based on content
                                            decoration: InputDecoration(
                                                hintText: 'Message...',
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      IconButton(
                                        onPressed: () => {
                                          if (textController.text.isNotEmpty)
                                            sendMessage()
                                        },
                                        icon: Container(
                                          width:
                                              40, // Width and height should be the same for a circle
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: textController
                                                    .text.isNotEmpty
                                                ? Colors.pink
                                                : Colors.grey
                                                    .shade400, // Background color
                                            shape:
                                                BoxShape.circle, // Circle shape
                                          ),
                                          child: Center(
                                            child: Transform.rotate(
                                              angle: -25 *
                                                  (3.14159 /
                                                      180), // Convert degrees to radians
                                              child: Icon(
                                                Icons.send,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ))))
              ],
            ),
          ),
        ]));
  }
}
