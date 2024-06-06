import 'package:flutter/material.dart';
import 'package:khukiting/src/data/DTO/response/PickCookieResponse.dart';
import 'package:khukiting/src/presentation/views/MainPage/MainView.dart';
import 'package:khukiting/src/presentation/widgets/CookieInfoStack.dart';
import 'package:khukiting/src/domain/Model/Cookie.dart';
import 'package:khukiting/src/domain/Model/nameTag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:khukiting/src/utils/ColorStyles.dart';

class PickedCookieStack extends StatelessWidget {
  final bool isHistory;
  final Cookie? cookie;
  PartnerDetail? partnerDetail;
  final String? cookieType;
  PickedCookieStack(this.isHistory,
      [this.cookie, this.partnerDetail, this.cookieType]);
  // PickedCookieStack({this.cookie, required this.isHistory});
  void copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(
        text: isHistory ? cookie!.openID : partnerDetail!.openID));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("복사 완료"),
          content: const Text("클립보드에 저장되었습니다."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("확인"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: 320, maxHeight: isHistory ? 224 : 208),
      child: DecoratedBox(
        decoration: isHistory
            ? BoxDecoration(
                border: Border.all(color: ColorStyles.LoginPageBackground, width: 2),
                borderRadius: BorderRadius.circular(10),
                // color: Colors.pink,
              )
            : const BoxDecoration(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 24, 8, 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/cookieType/${isHistory ? cookie?.cookieType : cookieType}.png',
                        width: isHistory ? 128 : 140,
                        height: isHistory ? 128 : 140,
                      ),
                      if (isHistory == true) ...[
                        const SizedBox(height: 8),
                        CookieInfoStack(cookie!.info, NameTag.small),
                      ]
                    ],
                  ),
                  const SizedBox(width: 24),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        "연락수단",
                        style: TextStyle(
                            fontSize: 14 ,fontFamily: 'uhBeeBold'),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isHistory ? cookie!.openID : partnerDetail!.openID,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "이렇게 연락해죠",
                        style: TextStyle(
                            fontSize: 14, fontFamily: 'uhBeeBold'),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isHistory ? cookie!.selfInfo : partnerDetail!.selfInfo,
                        style: const TextStyle(fontSize: 14),
                      ),
                      IconButton(
                          onPressed: () => copyToClipboard(context),
                          icon: const Icon(Icons.copy)),
                    ],
                  ),
                ],
              ),
            ),
            if (isHistory == false)
              Positioned(
                right: -8,
                top: -8,
                child: IconButton(
                  icon: const Icon(
                    CupertinoIcons.xmark,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
