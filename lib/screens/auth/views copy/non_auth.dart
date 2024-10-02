import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/screens/auth/views/login.dart';

class NonAuthScreen extends StatelessWidget {
  const NonAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: whiteColor,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         
          SvgPicture.asset(
            "assets/icons/user.svg",
            colorFilter: ColorFilter.mode(
              blackColor80,
              BlendMode.srcIn,
            ),
            width: 64,
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          // login to tiktok
          Text(
            "Register TikTok account",
            style: TextStyle(color: blackColor, fontSize: 14),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          ElevatedButton(
            onPressed: () => {
              showModalBottomSheet(
                  context: context,
                  builder: (ctx) => LoginScreen(),
                  isScrollControlled: true,
                  useSafeArea: true)
            },
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                backgroundColor: Colors.pink,
                minimumSize: Size(160, 40)),
            child: Text(
              "Register",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ],
      ),
    ));
  }
}
