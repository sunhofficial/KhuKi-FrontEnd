import 'package:flutter/material.dart';
import 'StepProgressBar.dart';
import 'package:flutter/cupertino.dart';

class SecondView extends StatefulWidget {
  @override
  _SecondViewState createState() => _SecondViewState();
}

class _SecondViewState extends State<SecondView> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _restaruntController = TextEditingController();
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _idController.addListener(_validateFields);
    _messageController.addListener(_validateFields);
    _restaruntController.addListener(_validateFields);
  }

  void _validateFields() {
    if (_idController.text.isNotEmpty &&
        _messageController.text.isNotEmpty &&
        _restaruntController.text.isNotEmpty) {
      setState(() => _isButtonDisabled = false);
    } else {
      setState(() => _isButtonDisabled = true);
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _messageController.dispose();
    _restaruntController.dispose();
    super.dispose();
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 8, 0, 40),
      child: TextField(
        style: TextStyle(fontSize: 14),
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.all(16)),
      ),
    );
  }
  Widget _buildTitleRow(String title, String description) {
    return Row(
    crossAxisAlignment: CrossAxisAlignment.baseline,
    textBaseline: TextBaseline.alphabetic,
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 24),
      ),
      Text(
        description,
        style: TextStyle(fontSize: 12),
      ),
    ],
  );
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
                padding: EdgeInsets.fromLTRB(16, 8, 16, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StepProgressBar(currentStep: 2),
                    SizedBox(height: 48),
                    _buildTitleRow("ID ", "상대방이 내 쿠키를 뽑았을때 보여집니다."),
                    _buildTextField(
                        _idController, 'Enter your phone number or instaID'),
                        _buildTitleRow("보내줘 ", "매칭시 받고 싶은 메시지의 형태"),
                    _buildTextField(
                      _messageController,
                      'ex) 달콤쿠키를 뽑아 연락드렸어요!~! Or 디카프리오님!',
                    ),
                    _buildTitleRow("쩝쩝박사 ", "나만 아는 맛집 or 최애 맛집"),
                    _buildTextField(
                      _restaruntController,
                      'ex) 수누리',
                    ),
              
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 360,
              height: 54,
              child: CupertinoButton(
                onPressed: _isButtonDisabled
                    ? null
                    : () {
                        // Add your button press logic here
                      },
                child: Text("Continue", style: TextStyle(color: Colors.white)),
                color: Colors.pink,
              ),
            ),
            // SizedBox(height: 25), // 버튼과 하단 간격 조절
          ],
        ),
      ),
    );
  }
}
