import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/components/avatar.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/injections/injection.dart';
import 'package:tiktok_clone/providers/user_data_provider.dart';
import 'package:tiktok_clone/screens/auth/views/login.dart';
import 'package:tiktok_clone/storage/storage.dart';

class ChangeAccount extends StatefulWidget {
  const ChangeAccount({super.key});

  @override
  State<ChangeAccount> createState() => _ChangeAccountState();
}

class _ChangeAccountState extends State<ChangeAccount> {
  final storageService = getIt<StorageService>();
  void showLogin() {
    Navigator.of(context).pop();
    showModalBottomSheet(
        context: context,
        builder: (ctx) => LoginScreen(),
        isScrollControlled: true,
        useSafeArea: true);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: whiteColor,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Chuyển đổi tài khoản",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: blackColor),
                    ),
                  ),
                  Positioned(
                      top: -7,
                      right: 5,
                      child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          child: SvgPicture.asset(
                            "assets/icons/close.svg",
                            width: 16,
                            colorFilter: ColorFilter.mode(
                                const Color.fromARGB(255, 23, 23, 24),
                                BlendMode.srcIn),
                          )))
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding * 2,
                    vertical: defaultPadding * 3),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Avatar(size: 24, url: "assets/avatars/me.jpg"),
                        const SizedBox(width: defaultPadding),
                        Text("T11N",
                            style: TextStyle(
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14))
                      ],
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    TextButton(
                        onPressed: showLogin,
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0)),
                        child: Row(
                          children: [
                            Container(
                                width: 50,
                                height: 50,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.add,
                                      // size: 24,
                                      color: blackColor,
                                    ))),
                            const SizedBox(
                              width: defaultPadding,
                            ),
                            Text("Thêm tài khoản",
                                style: TextStyle(
                                    color: blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14))
                          ],
                        )),
                    const SizedBox(height: defaultPadding * 2),
                     TextButton(
                        onPressed: () => {
                              storageService.clearSharedPreferences(),
                              userProvider.setUser(null),
                              Navigator.of(context).pop()
                            },
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout_outlined,
                              size: 32,
                              color: blackColor80,
                            ),
                            const SizedBox(width: defaultPadding),
                            Text("Log out",
                                style: TextStyle(
                                    color: blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14))
                          ],
                        ))
                  ],
                )),
          ],
        ));
  }
}
