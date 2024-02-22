import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:readr_app/core/values/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MemberLoginPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '繼續使用代表您同意與接受',
          style: TextStyle(
            fontFamily: 'PingFang TC',
            fontSize: 13,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: '鏡傳媒的',
                style: TextStyle(
                    fontFamily: 'PingFang TC',
                    fontSize: 13,
                    color: Colors.black),
              ),
              TextSpan(
                text: '《服務條款》',
                style: const TextStyle(
                    fontFamily: 'PingFang TC', fontSize: 13, color: appColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrlString(
                        'https://www.mirrormedia.mg/story/service-rule/');
                  },
              ),
              const TextSpan(
                text: '以及',
                style: TextStyle(
                    fontFamily: 'PingFang TC',
                    fontSize: 13,
                    color: Colors.black),
              ),
              TextSpan(
                text: '《隱私政策》',
                style: const TextStyle(
                    fontFamily: 'PingFang TC', fontSize: 13, color: appColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrlString(
                        'https://www.mirrormedia.mg/story/privacy/');
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
