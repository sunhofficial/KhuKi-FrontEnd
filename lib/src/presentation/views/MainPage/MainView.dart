
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khukiting/src/config/configuartions.dart';
import 'package:khukiting/src/data/DTO/response/CookiesResponse.dart';
import 'package:khukiting/src/data/DTO/response/PickCookieResponse.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';
import 'package:khukiting/src/presentation/views/MainPage/MainViewModel.dart';
import 'package:khukiting/src/presentation/views/Settingpage/SettingView.dart';
import 'package:khukiting/src/presentation/views/Settingpage/SettingViewModel.dart';
import 'package:khukiting/src/presentation/widgets/CookieDetailBottomModal.dart';
import 'package:khukiting/src/presentation/widgets/CookieInfoStack.dart';
import 'package:khukiting/src/domain/Model/Cookie.dart';
import 'package:khukiting/src/domain/Model/nameTag.dart';
import 'package:khukiting/src/presentation/views/PickedCookies/pickedCookiesView.dart';
import 'package:khukiting/src/presentation/widgets/PickedCookieStack.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
    final UserRepository _repository = getIt<UserRepository>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = MainViewModel(_repository);
        viewModel.fetchCookies();
        return viewModel;
      },

      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.gift),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PickedCookieListPage()),
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingView()
              ),);
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

        return NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (!viewModel.isLoading &&
                scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent) {
              viewModel.fetchCookies(isInitialLoad: false);
            }
            return true;
          },
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 0.8),
            itemCount: viewModel.cookies.length,
            itemBuilder: (context, index) {
              // Cookie cookie = Cookie(info: viewModel.cookies÷[index].info, cookieType: viewModel.cookies[index].cookieType);
              return _cookieItem(viewModel.cookies[index], () {
                _showCookieModal(context, viewModel.cookies[index], viewModel);
              }, NameTag.small);
            },
          ),
        );
      },
    );
  }

  void _showCookieModal(BuildContext context, CookiesResponse cookie, MainViewModel viewModel) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CookieDetailBottomModal(cookie: cookie, onYesPressed: () async {
          PartnerDetail partnerDetail = await viewModel.selectCookie(cookie.cookieId);
          Navigator.of(context).pop();
          showDialog(context: context, builder: (context) {
            return Dialog(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            insetPadding: const EdgeInsets.all(20),
            child: Padding(padding: const EdgeInsets.all(16),
            child: PickedCookieStack( false, null, partnerDetail, cookie.type),),);
          },); 
        } );
      },
    );
  }
  // void _showPartnerInfoDialog(BuildContext context, PartnerDetail partnerDetail, int cookieImage) {
  //   showDialog(context: context, builder: (context) {
  //     return Dialog(
  //       backgroundColor: Colors.white,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //       insetPadding: const EdgeInsets.all(20),
  //       child: Padding(
  //         padding: const EdgeInsets.all(16),
  //         child: Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Image.asset('assets/cookieType/${cookieImage}.png', width: 100, height: 100),
  //             Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text("연락수단", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
  //                 SizedBox(height: 4,),
  //                 Text(partnerDetail.openID),
  //                      SizedBox(height: 8),
  //                 Text("이렇게 연락해죠!", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
  //                      SizedBox(height: 4,),
  //                 Text(partnerDetail.selfInfo),
  //                   SizedBox(height: 8),
  //                   IconButton(
  //                     icon: Icon(CupertinoIcons.),
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                   )
  //               ],
  //             )
              
  //           ],
  //         ),
  //       ),
        
  //     )
  //   })

  // }

  Widget _cookieItem(CookiesResponse cookie, VoidCallback onTap, NameTag nameTag) {
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