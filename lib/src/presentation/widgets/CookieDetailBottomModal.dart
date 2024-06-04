import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khukiting/src/data/DTO/response/CookiesResponse.dart';
import 'package:khukiting/src/domain/Model/AgeGroup.dart';
import 'package:khukiting/src/presentation/widgets/CookieInfoStack.dart';
import 'package:khukiting/src/domain/Model/Cookie.dart';
import 'package:khukiting/src/domain/Model/nameTag.dart';
import 'package:khukiting/src/presentation/widgets/PickedCookieStack.dart';
class CookieDetailBottomModal extends StatelessWidget {
  final CookiesResponse cookie;
  final VoidCallback? onYesPressed;
  CookieDetailBottomModal({
      required this.cookie,
      this.onYesPressed,
  });


  Widget _InfoRow(BuildContext context, String label, Widget rightWidget) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              label,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: rightWidget,
          ),
        ),
      ],
    );
  }

  Widget _buildAgeBox(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 116),
      decoration: BoxDecoration(
        color: Color(0xE5FA457E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          children: [
            Image.asset(AgeGroup.fromAge(cookie.age).assetPath,
                width: 24, height: 24, fit: BoxFit.contain),
            SizedBox(width: 4),
            Text(
              AgeGroup.fromAge(cookie.age).description,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonsContainer(BuildContext context, CookiesResponse cookie) {
    return Container(
      width: 160,
      height: 72,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x26752276),
            blurRadius: 40,
            offset: Offset(4, 4),
            spreadRadius: 0.0,
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Ink(
                width: 52,
                height: 52,
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  shadows: [
                    BoxShadow(
                      color: Color(0x26752276),
                      blurRadius: 40,
                      offset: Offset(0, 8),
                      spreadRadius: 0.0,
                    )
                  ],
                  color: Colors.white,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.xmark,
                    color: Colors.red,
                  ),
                ),
              ),
              // More buttons as previously defined
              Ink(
                width: 52,
                height: 52,
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                  color: Colors.pink,
                ),
                child: IconButton(
                  iconSize: 24,
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        barrierColor: Colors.black.withOpacity(0.3),
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                            
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            insetPadding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 280,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "이 쿠키를 고르시겠습니까?",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 24),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text("쿠키는 하루애 한개만 뽑을 수 있습니다."),
                                SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    OutlinedButton(onPressed: () {Navigator.pop(context);
                                    Navigator.pop(context);
                                    }, style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        
                                      ),
                                      fixedSize: Size(104, 48),
                                    ), child: Text("취소")),
                                    SizedBox(width: 24,),
                                    ElevatedButton(
                                      onPressed: (
                    
                                      ) {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                           if (onYesPressed != null) {
                                        onYesPressed!(); // Execute onYesPressed callback
                                      }
                                        //  showDialog(
                                        //   context: context,
                                        //   builder: (context) {
                                        //     return Dialog(
                                        //       backgroundColor: Colors.white,
                                        //       surfaceTintColor: Colors.white,
                                        //       shape: RoundedRectangleBorder(
                                        //         borderRadius:
                                        //             BorderRadius.circular(8),
                                        //       ),
                                        //       // child: PickedCookieStack(cookie:  cookie, isHistory:  false)
                                        //     );},);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        fixedSize: Size(104, 48),
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.pink,
                                      ),
                                      child: Text("네"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  icon: const Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      // isSurfacePainted: true,
      child: Container(
        color: CupertinoColors.white,
        alignment: Alignment.center,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            Image.asset(
              'assets/cookieType/${cookie.cookieType}.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 16),
            // Assumed existing method call
          CookieInfoStack(cookie.info, NameTag.big),
            SizedBox(height: 32),
            _InfoRow(context, "나이", _buildAgeBox(context)),
            SizedBox(height: 32),
            _InfoRow(context, "정문으로부터 거리", Text("${cookie.distance}분", style: TextStyle(fontSize: 16, color: Colors.black))),
            SizedBox(height: 32),
            _InfoRow(context, "나의 맛집", Text("${cookie.restaurant}", style: TextStyle(fontSize: 16, color: Colors.black))),
            Spacer(),
            _buildButtonsContainer(context, cookie),
            Spacer()
          ],
        ),
      ),
    );
  }
}
