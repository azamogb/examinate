import 'package:examinate/constants.dart';
import 'package:flutter/material.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    super.key,
    required this.result,
    required this.questionLength,
    required this.onPressed,
  });

  final int result;
  final int questionLength;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Result',
              style: TextStyle(color: neutral, fontSize: 25.0),),
            const SizedBox(
              height: 20.0,
            ),
            CircleAvatar(
              radius: 70.0,
              backgroundColor: result == questionLength / 2
                  ? Colors.yellow
                  : result < questionLength / 2
                      ? incorrect
                      : correct,
              child:  Text(
                "$result/$questionLength",
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              result == questionLength / 2
                  ? 'Almost there'
                  : result < questionLength / 2
                      ? 'You are a Failure'
                      : 'Good Job',
              style: const TextStyle(
                color: neutral,
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            GestureDetector(
              onTap: onPressed,
              child: const Text(
                'GO AGAIN ?',
                style: TextStyle(
                    fontSize: 20,
                    color: neutral,
                    //fontWeight: FontWeight.bold,
                letterSpacing: 1.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
