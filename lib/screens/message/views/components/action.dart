import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiktok_clone/constants.dart';

class MessageAction extends StatelessWidget {
  const MessageAction({super.key});

  genIcon(String icon, String label, VoidCallback callback,
      {Color color = Colors.black}) {
    return IconButton(
        onPressed: () => {},
        icon: Column(
          children: [
            Container(
                height: 48,
                width: 48,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(icon,
                        width: 24,
                        height: 24,
                        colorFilter:
                            ColorFilter.mode(color, BlendMode.srcIn)))),
            SizedBox(
              height: defaultPadding / 8,
            ),
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w500,color: color),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            top: true,
            bottom: false,
            child: GestureDetector(
              onTap: () => {Navigator.of(context).pop()},
              child: Container(
                padding: const EdgeInsets.only(
                  top: 48,
                ),
                child: Container(
                  color: Colors.grey.withOpacity(0.6),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: defaultPadding,
                            ),
                            genIcon(
                                "assets/icons/reply.svg", "Reply", () => {}),
                            const SizedBox(
                              width: defaultPadding,
                            ),
                            genIcon("assets/icons/forward.svg", "Forward",
                                () => {}),
                            const SizedBox(
                              width: defaultPadding,
                            ),
                            genIcon("assets/icons/copy.svg", "Copy", () => {}),
                            const SizedBox(
                              width: defaultPadding,
                            ),
                            genIcon(
                                "assets/icons/delete.svg", "Delete", () => {},color: Colors.red),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                      ]),
                ),
              ),
            )));
  }
}
