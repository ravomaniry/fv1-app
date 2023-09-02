import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fv1/models/quiz_question.dart';
import 'package:fv1/models/texts.dart';
import 'package:fv1/ui/widgets/h2.dart';

class QuizItemWidget extends StatelessWidget {
  final AppTexts texts;
  final int index;
  final QuizQuestionModel question;
  final String? value;

  const QuizItemWidget({
    super.key,
    required this.texts,
    required this.question,
    required this.value,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: ScreenH2('${index + 1}. ${question.question}'),
      subtitle: FormBuilderRadioGroup(
        orientation: OptionsOrientation.vertical,
        name: question.key,
        initialValue: value,
        validator: FormBuilderValidators.required(
          errorText: texts.requiredFieldMessage,
        ),
        options: question.options
            .map((e) => FormBuilderFieldOption(value: e))
            .toList(),
      ),
    );
  }
}
