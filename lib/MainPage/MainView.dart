import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      // body: GridView.builder(
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 3, // Display 3 images per row
      //   ),
      //   // itemCount: yourList.length, // Replace `yourList` with the actual list from the server
      //   // itemBuilder: (BuildContext context, int index) {
      //   //   // Build each grid item with an image
      //   //   return Image.network(yourList[index].imageUrl); // Replace `imageUrl` with the actual property name in your data model
      //   // },
      // ),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: [
      //     CupertinoButton(
      //       child: Icon(CupertinoIcons.settings),
      //       onPressed: () {
      //         // Handle settings icon press
      //       },
      //     ),
      //     SizedBox(height: 16),
      //     CupertinoButton(
      //       child: Icon(CupertinoIcons.profile_circled),
      //       onPressed: () {
      //         // Handle profile icon press
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}

class CookieGridPage extends StatefulWidget {
  @override
  _CookieGridPageState createState() => _CookieGridPageState();
}

class _CookieGridPageState extends State<CookieGridPage> {
  final List<Cookie> _cookies = [Cookie(info: "컴공동남아송강", cookieType: "normal"),Cookie(info: "컴공동남아송강", cookieType: "normal"),Cookie(info: "컴공동남아송강", cookieType: "normal"),Cookie(info: "컴공동남아송강", cookieType: "normal"),Cookie(info: "컴공동남아송강", cookieType: "normal"),Cookie(info: "컴공동남아송강", cookieType: "normal"),Cookie(info: "컴공동남아송강", cookieType: "normal"),Cookie(info: "컴공동남아송강", cookieType: "normal")];
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
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.8),
          itemCount: _cookies.length,
          itemBuilder: (context, index) {
            Cookie cookie = _cookies[index];
            return CookieItem(cookie: cookie);
          },
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

class Cookie {
  final String info;
  final String cookieType;

  Cookie({required this.info, required this.cookieType});
}

class CookieItem extends StatelessWidget {
  final Cookie cookie;

  CookieItem({required this.cookie});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/cookieType/${cookie.cookieType}.png',
          width: 100,
          height: 100,
        ),
        SizedBox(
          height: 8,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/nameTag.png', width: 118, height: 24,),
            Text(
              cookie.info,
              style: TextStyle(fontSize: 14),
            ),
          ],
        )
      ],
    );
  }
}
