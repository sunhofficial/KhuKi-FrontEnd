import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:khukiting/src/config/configuartions.dart';
import 'package:khukiting/src/data/DTO/response/CookiesResponse.dart';
import 'package:provider/provider.dart';
import 'package:khukiting/src/domain/Model/Cookie.dart';
import 'package:khukiting/src/presentation/widgets/PickedCookieStack.dart';
import 'package:khukiting/src/presentation/widgets/CookieDetailBottomModal.dart';
import 'package:khukiting/src/presentation/views/PickedCookies/PickedCookieViewModel.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';

class PickedCookieListPage extends StatelessWidget {
  final UserRepository _repository = getIt<UserRepository>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = PickedCookieViewModel(_repository);
        viewModel.fetchPickedCookies();
        return viewModel;
      },
      child: Scaffold(
        appBar: AppBar(title: Text("내가 뽑은 쿠키")),
        body: Consumer<PickedCookieViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (viewModel.cookies.isEmpty) {
              return Center(child: Text('No cookies found'));
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: ListView.builder(
                itemCount: viewModel.cookies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showCookieDetailModal(context, viewModel.cookies[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 16), // 아이템 사이의 간격
                      child: PickedCookieStack(
                     true,
                   viewModel.cookies[index],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _showCookieDetailModal(BuildContext context, Cookie cookie) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CookieDetailBottomModal(
          cookie: CookiesResponse(
            age: cookie.age,
            restaurant: cookie.restaurant,
            type: cookie.type,
            info: cookie.info,
            distance: cookie.distance,
            cookieId: "picked",
          ),
        );
      },
    );
  }
}
