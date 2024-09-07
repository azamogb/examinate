import 'package:examinate/constants.dart';
import 'package:flutter/material.dart';


class NextButton extends StatelessWidget {
  const NextButton({super.key});



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: neutral,
        borderRadius: BorderRadius.circular(10.0),

      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: const Text('NEXT',
      textAlign: TextAlign.center,
      ),
    );
  }
}
