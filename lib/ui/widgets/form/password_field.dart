import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fv1/models/texts.dart';

class PasswordFormField extends StatelessWidget {
  static const fieldKey = Key('PasswordFormField');
  final AppTexts texts;

  const PasswordFormField(this.texts, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'password',
      obscureText: true,
      key: fieldKey,
      decoration: InputDecoration(labelText: texts.password),
      validator: FormBuilderValidators.required(
        errorText: texts.requiredFieldMessage,
      ),
    );
  }
}
