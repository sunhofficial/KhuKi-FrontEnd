import 'package:flutter/material.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep;

  const StepProgressBar({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: StepProgressBarItem(
                color: currentStep >= 1 ? Color(0xFFE9525F) : Color(0xFFE2DAEB),
              ),
            ),
            Expanded(
              child: StepProgressBarItem(
                color: currentStep >= 2 ? Color(0xFFEF7D85) : Color(0xFFE2DAEB),
              ),
            ),
            Expanded(
              child: StepProgressBarItem(
                color: currentStep >= 3 ? Color(0xFFEF7D85) : Color(0xFFE2DAEB),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            '간단한 자기소개를 작성해주세요.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class StepProgressBarItem extends StatelessWidget {
  final Color color;

  const StepProgressBarItem({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
      ),
      margin: EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
