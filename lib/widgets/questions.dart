import 'package:examinate/constants.dart';
import 'package:flutter/material.dart';


class QuestionsWidget extends StatelessWidget {
  const QuestionsWidget({super.key,
    required this.question,
    required this.totalQuestions,
    required this.indexAction,
  });

  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text('Question ${indexAction +1}/$totalQuestions: $question',
      style: const TextStyle(
          fontSize: 25.0,
        color: neutral,
      ),
      ),
    );
  }
}
