import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khukiting/Model/NameTag.dart';
import 'package:khukiting/Model/Cookie.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.gift),
          onPressed: () {
            // Handle back button press
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.settings),
          )
        ],
      ),
      body: CookieGridPage(),
    );
  }
}

class CookieGridPage extends StatefulWidget {
  @override
  _CookieGridPageState createState() => _CookieGridPageState();
}

class _CookieGridPageState extends State<CookieGridPage> {
  final List<Cookie> _cookies = [
    Cookie(info: "컴공동남아송강", cookieType: "normal"),
    Cookie(info: "존잘이선호", cookieType: "khu"),
    Cookie(info: "홀리오석진", cookieType: "white"),
    Cookie(info: "컴공동남아송강", cookieType: "normal"),
    Cookie(info: "컴공동남아송강", cookieType: "normal"),
    Cookie(info: "컴공동남아송강", cookieType: "normal"),
    Cookie(info: "컴공동남아송강", cookieType: "normal"),
    Cookie(info: "컴공동남아송강", cookieType: "normal")
  ];
  final int _initialCount = 15;
  final int _paginationCount = 9;
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // _fetchCookies();
  }

  // Future<void> _fetchCookies({bool isInitialLoad = true}) async {
  //   if (_isLoading) return;
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   // Replace with your actual fetch from server logic
  //   int count = isInitialLoad ? _initialCount : _paginationCount;
  //   List<Cookie> newCookies = await fetchCookiesFromServer(count, _currentPage);

  //   setState(() {
  //     _cookies.addAll(newCookies);
  //     _isLoading = false;
  //     if (!isInitialLoad) _currentPage++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          // if (!_isLoading &&
          //     scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent) {
          //       setState(() {

          //       });
          //   // _fetchCookies(isInitialLoad: false);
          // }
          return true;
        },
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 0.8),
          itemCount: _cookies.length,
          itemBuilder: (context, index) {
            Cookie cookie = _cookies[index];
            return _cookieItem(cookie, () {
              _showCookieModal(context, cookie);
            }, NameTag.small);
          },
        ),
      ),
    );
  }

  _cookieInfoStack(String info, NameTag nameTag) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/nameTag.png',
            width: nameTag.tagWidth,
            height: nameTag.tagHeight,
            fit: BoxFit.contain),
        Text(
          info,
          style: TextStyle(fontSize: nameTag.sizeofFont, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildAgeBox() {
    return Container(
      constraints: BoxConstraints(maxWidth: 116),
      decoration: BoxDecoration(
        color: Color(0xE5FA457E),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          // mainAxisSize: MainAxisSize.mas,
          children: [
            Image.asset("assets/ageYoung.png",
                width: 24, height: 24, fit: BoxFit.contain),
            SizedBox(width: 4),
            Text(
              "19-21살",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  _showCookieModal(BuildContext context, Cookie cookie) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoPopupSurface(
          child: Container(
            color: CupertinoColors.white,
            alignment: Alignment.center,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 32,
                ),
                Image.asset(
                  'assets/cookieType/${cookie.cookieType}.png',
                  width: 200,
                  height: 200,
                ),
                SizedBox(
                  height: 16,
                ),
                _cookieInfoStack(cookie.info, NameTag.big),
                SizedBox(
                  height: 32,
                ),
                _InfoRow("나이", _buildAgeBox()),
                SizedBox(
                  height: 32,
                ),
                _InfoRow(
                  "정문으로부터 거리",
                  Text(
                    "10분",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                _InfoRow(
                  "나의 맛집",
                  Text(
                    "수누리",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                Spacer(),
                _buildButtonsContainer(),
                Spacer()
              ],
            ),
          ),
        );
      },
    );
  }

  _InfoRow(String label, Widget rightWidget) {
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

  _cookieItem(Cookie cookie, VoidCallback onTap, NameTag nameTag) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            'assets/cookieType/${cookie.cookieType}.png',
            width: 100,
            height: 100,
          ),
          SizedBox(
            height: 8,
          ),
          _cookieInfoStack(cookie.info, nameTag),
        ],
      ),
    );
  }

  _buildButtonsContainer() {
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
                                    OutlinedButton(onPressed: () {Navigator.pop(context);}, style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        
                                      ),
                                      fixedSize: Size(104, 48)
                                    ), child: Text("취소")),
                                    SizedBox(width: 24,),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
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
}

// Future<List<Cookie>> fetchCookiesFromServer(int count, int page) async {
//   // Simulate network delay
//   await Future.delayed(Duration(seconds: 2));
//   // Simulate fetching from server by generating placeholder cookies
//   return List.generate(count, (index) => Cookie(id: 'cookie_${page}_$index'));
// }




