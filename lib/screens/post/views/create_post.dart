import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiktok_clone/api/post.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/storage/storage.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key, this.video});

  final File? video;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  late final TextEditingController descrioptionController =
      TextEditingController(text: "");
  String? _thumbnailPath;

  Future<void> _generateThumbnail() async {
    final String? thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: widget.video!.path, // The path of the video
      imageFormat: ImageFormat.JPEG,
      maxHeight: 200, // Desired height of the thumbnail
      quality: 75, // Quality of the generated thumbnail
    );

    if (thumbnailPath != null) {
      setState(() {
        _thumbnailPath = thumbnailPath;
      });
    }
  }

  Future<void> createPost() async {
    String title = descrioptionController.text;

    late StorageService storageService = getIt<StorageService>();
    late PostService postService = getIt<PostService>();
    try {
      final user = await storageService.getUser();
      FormData data = FormData.fromMap({
        'title': title,
        'video': await MultipartFile.fromFile(widget.video!.path),
        'thumbnail': await MultipartFile.fromFile(_thumbnailPath!),
        'user_id': user!.id,
        'description': "test description",
      });
      final response = await postService.createPost(data: data);
      if (response == true) {
        print('create post success!');
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  Widget buildTag(String text) {
    return Container(
      padding:
          const EdgeInsets.symmetric(vertical: 4, horizontal: defaultPadding),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4)),
      child: Text(text),
    );
  }

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: whiteColor,
      padding: const EdgeInsets.only(top: defaultPadding * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 0.5, color: blackColor))),
            // decoration: BoxDecoration(
            //     border:
            //         Border(bottom: BorderSide(width: 0.5, color: blackColor))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    icon: SvgPicture.asset(
                      "assets/icons/arround-back.svg",
                      width: 24,
                      colorFilter:
                          ColorFilter.mode(blackColor, BlendMode.srcIn),
                    )),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller:
                            descrioptionController, // Bind the controller to this field
                        maxLines: null, // Allow multiple lines
                        keyboardType:
                            TextInputType.multiline, // Multiline input
                        decoration: InputDecoration(
                          hintText: 'Add description...', // Placeholder text
                          border: InputBorder.none, // No border
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10), // Add padding if needed
                        ),
                      ),
                    ),
                    Container(
                      color: blackColor,
                      width: (MediaQuery.of(context).size.width -
                              defaultPadding * 2) /
                          3, // Set width to one-third of screen
                      child: AspectRatio(
                        aspectRatio: 3 / 4, // Maintain the aspect ratio of 9:16
                        child: Container(
                          color: Colors.black,
                          child: _thumbnailPath != null
                              ? Image.file(File(_thumbnailPath!))
                              : SizedBox(),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: defaultPadding),
                  child: Row(
                    children: [
                      buildTag("# Hashtags"),
                      // buildTag("# Hashtags"),
                      SizedBox(width: defaultPadding),
                      buildTag("@ Mentions")
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: defaultPadding * 2,
          ),
          Container(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.pin_drop_outlined,
                      size: 24,
                      color: blackColor,
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      "Location",
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ],
                    ))
                  ],
                ),
                const SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  children: [
                    buildTag("Coder"),
                    const SizedBox(
                      width: defaultPadding / 2,
                    ),
                    buildTag("Dev Flutter"),
                    const SizedBox(
                      width: defaultPadding / 2,
                    ),
                    buildTag("T11N"),
                  ],
                ),
                const SizedBox(
                  height: defaultPadding * 2,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.add,
                      size: 24,
                      color: blackColor,
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      "Add link",
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ],
                    ))
                  ],
                ),
                const SizedBox(
                  height: defaultPadding * 2,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.public,
                      size: 24,
                      color: blackColor,
                    ),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      "Everyone can view this post",
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ],
                    ))
                  ],
                ),
                const SizedBox(
                  height: defaultPadding * 2,
                ),
                Row(
                  children: [
                    Icon(Icons.more_horiz_outlined,
                        size: 24, color: blackColor),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      "More options",
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ],
                    ))
                  ],
                ),
                const SizedBox(
                  height: defaultPadding * 2,
                ),
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/share.svg",
                        width: 18,
                        colorFilter:
                            ColorFilter.mode(blackColor, BlendMode.srcIn)),
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      "Share to",
                      style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.facebook,
                          size: 32,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: defaultPadding,
                        ),
                        Icon(
                          Icons.telegram,
                          size: 32,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: defaultPadding,
                        ),
                        Icon(
                          Icons.tiktok,
                          size: 32,
                          color: Colors.grey,
                        ),
                      ],
                    ))
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: defaultPadding * 2, horizontal: defaultPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: () => {Navigator.of(context).pop()},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 0.5, color: Colors.grey),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(defaultPadding / 2)),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.edit_note,
                            color: blackColor,
                            size: 16,
                          ),
                          const SizedBox(width: defaultPadding / 2),
                          Text(
                            "Drafts",
                            style: TextStyle(color: blackColor),
                          )
                        ],
                      )),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: createPost,
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(defaultPadding / 2)),
                          ),
                          backgroundColor: Colors.pink,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_upward,
                              color: whiteColor,
                            ),
                            const SizedBox(width: defaultPadding / 2),
                            Text(
                              "Post",
                              style: TextStyle(color: whiteColor),
                            )
                          ],
                        )))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
