import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khukiting/src/config/configuartions.dart';
import 'package:khukiting/src/data/DTO/response/CookiesResponse.dart';
import 'package:khukiting/src/data/DTO/response/PickCookieResponse.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';
import 'package:khukiting/src/presentation/views/MainPage/MainViewModel.dart';
import 'package:khukiting/src/presentation/views/ProfileSetting/ThirdView.dart';
import 'package:khukiting/src/presentation/views/Settingpage/SettingView.dart';
import 'package:khukiting/src/presentation/views/Settingpage/SettingViewModel.dart';
import 'package:khukiting/src/presentation/widgets/CookieDetailBottomModal.dart';
import 'package:khukiting/src/presentation/widgets/CookieInfoStack.dart';
import 'package:khukiting/src/domain/Model/Cookie.dart';
import 'package:khukiting/src/domain/Model/nameTag.dart';
import 'package:khukiting/src/presentation/views/PickedCookies/pickedCookiesView.dart';
import 'package:khukiting/src/presentation/widgets/PickedCookieStack.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late MainViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MainViewModel(getIt<UserRepository>());
    _viewModel.addListener(_showNoCookieDialog);
    _viewModel.addListener(_show24hoursDialog);
    _viewModel.fetchCookies();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_showNoCookieDialog);
    _viewModel.removeListener(_show24hoursDialog);
    super.dispose();
  }

  void _showNoCookieDialog() {
    if (_viewModel.noMyCookie) {
      showNoCookieDialog(context);
    }
  }

  void _show24hoursDialog() {
    if (_viewModel.alertThat24hours) {
      show24hoursDialog(context);
    }
  }

  void show24hoursDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 32, vertical: 288),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("중요!!!",style: TextStyle(color: Colors.black, fontSize: 20)),
              SizedBox(
                height: 16,
              ),
              Text(
                "쿠키를 뽑은지 24시간이 지나지 않았어요!",
                style: TextStyle(color: Colors.black, fontSize: 16),
                textAlign: TextAlign.center,
              ),
                   SizedBox(
                height: 16,
              ),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                     Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fixedSize: Size(104, 48),
                  ),
                  child: Text("확인")),
            ],
          ),
        );
      },
    );
  }

  void showNoCookieDialog(BuildContext context) {
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
            horizontal: 36,
            vertical: 280,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "앗! 누가 내 쿠키를 뽑아갔어요",
                style: TextStyle(color: Colors.black, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 8,
              ),
              Text("내 쿠키가 있어야 다른 쿠키를 뽑을 수 있어요",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 16)),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ThirdView(
                              isNew: false,
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fixedSize: const Size(240, 44),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.pink),
                child: Text("새 쿠키 만들러가기"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainViewModel>.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.gift),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PickedCookieListPage()),
              );
              _viewModel.resetAndFetchCookies();
            },
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingView()),
                );
                _viewModel.resetAndFetchCookies();
              },
              icon: Icon(CupertinoIcons.settings),
            )
          ],
        ),
        body: CookieGridPage(),
      ),
    );
  }
}

class CookieGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading && viewModel.cookies.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        if (viewModel.noCookiesYet) {
          print("없어 아직 ");
          return const Center(
              child: Text("아직 만들어진 쿠키가 없습니다.", style: TextStyle(fontSize: 18)));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (!viewModel.isLoading &&
                scrollNotification.metrics.pixels < 200) {
              viewModel.fetchCookies(isInitialLoad: false);
            }
            return true;
          },
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 0.8),
            itemCount: viewModel.cookies.length,
            itemBuilder: (context, index) {
              return _cookieItem(viewModel.cookies[index], () {
                _showCookieModal(context, viewModel.cookies[index], viewModel);
              }, NameTag.small);
            },
          ),
        );
      },
    );
  }

  void _showCookieModal(
      BuildContext context, CookiesResponse cookie, MainViewModel viewModel) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CookieDetailBottomModal(
            cookie: cookie,
            onYesPressed: () async {
              PartnerDetail partnerDetail =
                  await viewModel.selectCookie(cookie.cookieId);
              Navigator.of(context).pop();
              viewModel.resetAndFetchCookies();
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    insetPadding: const EdgeInsets.all(20),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: PickedCookieStack(
                          false, null, partnerDetail, cookie.cookieType),
                    ),
                  );
                },
              );
            });
      },
    );
  }

  Widget _cookieItem(
      CookiesResponse cookie, VoidCallback onTap, NameTag nameTag) {
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
