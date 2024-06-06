import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:khukiting/src/config/configuartions.dart";
import "package:khukiting/src/domain/repository/UserRepository.dart";
import "package:khukiting/src/presentation/views/Login/loginView.dart";
import "package:khukiting/src/presentation/views/ProfileSetting/ThirdView.dart";
import "package:khukiting/src/presentation/views/Settingpage/SettingViewModel.dart";
class SettingView extends StatelessWidget {

  @override 
  Widget build(BuildContext context) {
    final UserRepository _repository = getIt<UserRepository>();
    final settingViewModel = SettingViewModel(_repository); // SettingViewModel 생성
    return Scaffold(
      appBar: CupertinoNavigationBar(middle: Text('설정',style: TextStyle(color: Colors.black),),),
      body: ListView(padding: const EdgeInsets.all(8),
      children: <Widget>[
          _buildListTile(context, '내 쿠키 바꾸기', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdView(isNew: false,)),
            );
          }),
          // _buildListTile(context, '소개 변경하기', () {
          //   // Navigator.push(
          //   //   context,
          //   //   MaterialPageRoute(builder: (context) => ChangeIntroductionView()),
          //   // );
          // }),
          _buildListTileWithAlertDialog(
            context,
            '회원 탈퇴',
            '회원을 탈퇴하시겠습니까?', () async {
          final res = await settingViewModel.deleteUser();
          if (res) {
            _navigateToLoginView(context);
          }
  }
          ),
          _buildListTileWithAlertDialog(
            context,
            '로그아웃',
            '로그아웃 하시겠습니까?', () async {
            final res = await settingViewModel.postlogout();
            if (res) {
              _navigateToLoginView(context);
            }},
          ),
      ],)
    );
  }
    void _navigateToLoginView(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
      (route) => false,
    );
  }
    Widget _buildListTile(BuildContext context, String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      onTap: onTap,
    );
  }
   Widget _buildListTileWithAlertDialog(BuildContext context, String title, String message, VoidCallback onPressed) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('취소'),
                ),
                TextButton(
                  onPressed: () {
                    onPressed();
                    Navigator.of(context).pop();
                  },
                  child: Text('확인'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}