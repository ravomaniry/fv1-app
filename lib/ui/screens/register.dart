import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fv1/models/register_data.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/ui/widgets/app_card.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/form/password_field.dart';
import 'package:fv1/ui/widgets/form/username_field.dart';
import 'package:fv1/ui/widgets/h3.dart';
import 'package:fv1/ui/widgets/help_button.dart';
import 'package:fv1/ui/widgets/home_page_container.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:fv1/ui/widgets/login_error.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, state, __) => HomePageContainer(
        floatingActionButton: const HelpFAB(),
        texts: state.texts,
        body: WrapInLoader(
          isReady: !state.isBusy,
          builder: () => _RegisterScreen(state),
        ),
      ),
    );
  }
}

final _formKey = GlobalKey<FormBuilderState>();

class _RegisterScreen extends StatelessWidget {
  final AppState _state;

  const _RegisterScreen(this._state);

  _onSubmit(BuildContext context) {
    final isValid = _formKey.currentState
        ?.saveAndValidate(autoScrollWhenFocusOnInvalid: true);
    if (isValid == true) {
      _state.register(RegisterData.fromJson(_formKey.currentState!.value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: AppCard(
          padding: 16,
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                ScreenH3(_state.texts.createAccount),
                UsernameFormField(_state.texts),
                PasswordFormField(_state.texts),
                const SizedBox(height: 8),
                ContinueButton(
                  label: _state.texts.login,
                  onPressed: () => _onSubmit(context),
                ),
                if (_state.error != null)
                  LoginError(error: _state.error, texts: _state.texts),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
