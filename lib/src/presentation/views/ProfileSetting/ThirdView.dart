import 'package:flutter/material.dart';
import 'StepProgressBar.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class ThirdView extends StatefulWidget {
  @override
  _ThirdViewState createState() => _ThirdViewState();
}

class _ThirdViewState extends State<ThirdView> {
  final TextEditingController _infoController = TextEditingController();
  bool _isValidText = false;
  int _SelectCookie = 1;
  final List<String> _cookieList = [
    "normal.png",
    "khu.png",
    "white.png"
  ];

  @override
  void initState() {
    super.initState();
    _infoController.addListener(_validateFields);
  }

  @override
  void dispose() {
    _infoController.dispose();
    super.dispose();
  }

  void _validateFields() {
    if (_infoController.text.length > 10 || _infoController.text.isEmpty) {
      setState(() => _isValidText = false);
    } else {
      setState(() => _isValidText = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [
                  Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 0 ),
              child: StepProgressBar(currentStep: 3),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
              ),
                Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    'assets/${_cookieList[_SelectCookie]}',
                    width: 360,
                    height: 360,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.contain,
                    opacity: AlwaysStoppedAnimation(0.3),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/cookiebox.png',
                                width: 120, height: 80),
                            // SizedBox(hei)
                            Text("나의 쿠키 만들기", style: TextStyle(fontSize: 32)),
                          ],
                        ),
                      ),
                      Text("나를 소개할 한 문장", style: TextStyle(fontSize: 16)),
                      TextField(
                        controller: _infoController,
                        decoration: InputDecoration(
                          hintText: "ex) 컴공 동남아 송강",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // width: 0.0 produces a thin "hairline" border
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                          errorText: _isValidText ? null : "10자 이하로 입력해주세요.",
                        ),
                      ),
                      // Text(
                      //   "글자의 수는 10자 이하여야합니다.",
                      //   textAlign: TextAlign.left,
                      // ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _SelectCookie = 0;
                              });
                            },
                            child: Opacity(
                              opacity: _SelectCookie == 0 ? 1 : 0.7,
                              child: Image.asset(
                                'assets/cookieType/normal.png',
                                width: 120,
                                height: 120,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _SelectCookie = 1;
                              });
                            },
                            child: Opacity(
                              opacity: _SelectCookie == 1 ? 1 : 0.7,
                              child: Image.asset(
                                'assets/cookieType/khu.png',
                                width: 120,
                                height: 120,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _SelectCookie = 2;
                              });
                            },
                            child: Opacity(
                              opacity: _SelectCookie == 2 ? 1 : 0.7,
                              child: Image.asset(
                                'assets/cookieType/white.png',
                                width: 120,
                                height: 120,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
                SizedBox(
              height: 32,
            ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(240, 64),
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset("assets/baking.png", width: 48, height: 48),
                    Text("베이킹 시작",
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                  ],
                )),
              ],) ,
          ),),
          ],
        ),
      ),
    );
  }
}
