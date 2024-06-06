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
                color: currentStep >= 1 ? const Color(0xFFE9525F) : const Color(0xFFE2DAEB),
              ),
            ),
            Expanded(
              child: StepProgressBarItem(
                color: currentStep >= 2 ? const Color(0xFFEF7D85) : const Color(0xFFE2DAEB),
              ),
            ),
            Expanded(
              child: StepProgressBarItem(
                color: currentStep >= 3 ? const Color(0xFFEF7D85) : const Color(0xFFE2DAEB),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            '간단한 자기소개를 작성해주세요.',
            style: TextStyle(fontSize: 16),
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
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
