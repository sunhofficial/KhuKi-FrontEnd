import 'package:flutter/material.dart';
import 'package:khukiting/src/presentation/views/MainPage/MainView.dart';
import 'package:khukiting/src/presentation/views/ProfileSetting/ThirdView.dart';
import '../StepProgressBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:khukiting/src/config/configuartions.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';
import 'SecondViewModel.dart';

class SecondView extends StatelessWidget {
  SecondView({super.key});
  final UserRepository _userRepository = getIt<UserRepository>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SecondViewModel(_userRepository),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<SecondViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const StepProgressBar(currentStep: 2),
                          const SizedBox(height: 48),
                          _buildTitleRow(
                              context, "ID ", "상대방이 내 쿠키를 뽑았을때 보여집니다."),
                          _buildTextField('Enter your phone number or instaID',
                              viewModel.idController),
                          _buildTitleRow(context, "보내줘 ", "매칭시 받고 싶은 메시지의 형태"),
                          _buildTextField('ex) 달콤쿠키를 뽑아 연락드렸어요!~! Or 디카프리오님!',
                              viewModel.messageController),
                          _buildTitleRow(context, "쩝쩝박사 ", "나만 아는 맛집 or 최애 맛집"),
                          _buildTextField(
                              'ex) 수누리', viewModel.restaurantController),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 360,
                    height: 54,
                    child: CupertinoButton(
                      onPressed: !viewModel.isButtonDisabled
                          ? () async {
                              bool isSuccess = await viewModel.submitProfile();
                              if (isSuccess) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ThirdView(
                                            isNew: true,
                                          )),
                                );
                              }
                            }
                          : null,
                      child: Text("Continue",
                          style: TextStyle(color: Colors.white)),
                      color: Colors.pink,
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

  Widget _buildTextField(String hintText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 40),
      child: TextField(
        style: const TextStyle(fontSize: 14),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildTitleRow(
      BuildContext context, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
        Text(
          description,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
