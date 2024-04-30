
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khukiting/Components/CookieDetailBottomModal.dart';
import 'package:khukiting/Components/CookieInfoStack.dart';
import 'package:khukiting/Model/NameTag.dart';
import 'package:khukiting/Model/Cookie.dart';
import 'package:khukiting/PickedCookies/PickedCookiesView.dart';
// import 'package:khukiting/ProfileSetting/PickedCookies/pickedCookiesView.dart';
// import P;

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.gift),
          onPressed: () {
 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PickedCookieListPage())
            );
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

  

  _showCookieModal(BuildContext context, Cookie cookie) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CookieDetailBottomModal(cookie);
      },);}

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
        CookieInfoStack(cookie.info, nameTag),
        ],
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

