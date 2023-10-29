import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fv1/models/texts.dart';

class UsernameFormField extends StatelessWidget {
  final AppTexts texts;

  static const fieldKey = Key('FormUsernameField');

  const UsernameFormField(this.texts, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'username',
      autofocus: true,
      key: fieldKey,
      decoration: InputDecoration(
        label: Text(texts.username),
      ),
      validator: FormBuilderValidators.required(
        errorText: texts.requiredFieldMessage,
      ),
    );
  }
}
