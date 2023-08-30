import 'package:flutter/material.dart';
import 'package:fv1/models/quiz_question.dart';
import 'package:fv1/ui/widgets/h2.dart';

class QuizItemWidget extends StatelessWidget {
  final QuizQuestionModel question;
  final String? value;
  final void Function(String?) onChanged;

  const QuizItemWidget({
    super.key,
    required this.question,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: ScreenH2(question.question),
      subtitle: Column(
        children: [
          for (final opt in question.options)
            RadioListTile(
              title: Text(
                opt,
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
              value: opt,
              groupValue: value,
              onChanged: onChanged,
            ),
        ],
      ),
    );
  }
}