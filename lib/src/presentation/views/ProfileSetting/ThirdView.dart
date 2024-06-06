import 'package:flutter/material.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';
import 'package:khukiting/src/presentation/views/MainPage/MainView.dart';
import 'StepProgressBar.dart';
import 'package:provider/provider.dart';
import 'ThirdViewModel.dart';
import 'package:khukiting/src/config/configuartions.dart';

class ThirdView extends StatelessWidget {
  final bool isNew;
  ThirdView({super.key, required this.isNew});
  final UserRepository _userRepository = getIt<UserRepository>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThirdViewModel(_userRepository),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<ThirdViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          if (isNew)
                            const Padding(
                              padding:EdgeInsets.fromLTRB(16, 8, 16, 0),
                              child: StepProgressBar(currentStep: 3),
                            ),
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height *
                                    (isNew ? 0.1 : 0.2)),
                          ),
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Image.asset(
                                'assets/cookieType/${viewModel.cookieList[viewModel.selectedCookie]}',
                                width: 360,
                                height: 360,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.contain,
                                opacity: const AlwaysStoppedAnimation(0.3),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        Image.asset('assets/cookiebox.png',
                                            width: 120, height: 80),
                                        const Text("나의 쿠키 만들기",
                                            style: TextStyle(fontSize: 32)),
                                      ],
                                    ),
                                  ),
                                  const Text("나를 소개할 한 문장",
                                      style: TextStyle(fontSize: 16)),
                                  TextField(
                                    controller: viewModel.infoController,
                                    decoration: InputDecoration(
                                      hintText: "ex) 컴공 동남아 송강",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 0.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide:
                                            const BorderSide(color: Colors.black),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                      contentPadding: const EdgeInsets.all(16),
                                      errorText: viewModel.isValidText
                                          ? null
                                          : "10자 이하로 입력해주세요.",
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          viewModel.selectCookie(0);
                                        },
                                        child: Opacity(
                                          opacity: viewModel.selectedCookie == 0
                                              ? 1
                                              : 0.7,
                                          child: Image.asset(
                                            'assets/cookieType/normal.png',
                                            width: 112,
                                            height: 112,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          viewModel.selectCookie(1);
                                        },
                                        child: Opacity(
                                          opacity: viewModel.selectedCookie == 1
                                              ? 1
                                              : 0.7,
                                          child: Image.asset(
                                            'assets/cookieType/khu.png',
                                            width: 112,
                                            height: 112,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          viewModel.selectCookie(2);
                                        },
                                        child: Opacity(
                                          opacity: viewModel.selectedCookie == 2
                                              ? 1
                                              : 0.7,
                                          child: Image.asset(
                                            'assets/cookieType/white.png',
                                            width: 112,
                                            height: 112,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(240, 64),
                                backgroundColor: Colors.pink,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            onPressed: viewModel.isValidText
                                ? () async {
                                    bool isSuccess =
                                        await viewModel.postCookie();
                                    if (isSuccess) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainView()),
                                      );
                                    }
                                  }
                                : null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset("assets/baking.png",
                                    width: 48, height: 48),
                                const Text("베이킹 시작",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
