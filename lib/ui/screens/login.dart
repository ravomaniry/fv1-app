import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fv1/models/login_data.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/ui/routes.dart';
import 'package:fv1/ui/widgets/app_card.dart';
import 'package:fv1/ui/widgets/continue_button.dart';
import 'package:fv1/ui/widgets/form/password_field.dart';
import 'package:fv1/ui/widgets/form/username_field.dart';
import 'package:fv1/ui/widgets/h3.dart';
import 'package:fv1/ui/widgets/help_button.dart';
import 'package:fv1/ui/widgets/home_page_container.dart';
import 'package:fv1/ui/widgets/loader.dart';
import 'package:fv1/ui/widgets/login_error.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const route = 'login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, state, __) => HomePageContainer(
        floatingActionButton: const HelpFAB(),
        texts: state.texts,
        body: WrapInLoader(
          isReady: !state.isBusy,
          builder: () => _LoginScreen(state),
        ),
      ),
    );
  }
}

class _LoginScreen extends StatefulWidget {
  final AppState _state;

  const _LoginScreen(this._state);

  @override
  State<_LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<_LoginScreen> {
  AppState get _state => widget._state;

  final _formKey = GlobalKey<FormBuilderState>();

  _onSubmit(BuildContext context) {
    final isValid = _formKey.currentState
        ?.saveAndValidate(autoScrollWhenFocusOnInvalid: true);
    if (isValid == true) {
      _state.login(LoginData.fromJson(_formKey.currentState!.value));
    }
  }

  _registerAsGuest() {
    _state.registerAsGuest();
  }

  _goToRegisterScreen(BuildContext context) {
    context.go(Routes.register);
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
                ScreenH3(_state.texts.loginTitle),
                UsernameFormField(_state.texts),
                PasswordFormField(_state.texts),
                const SizedBox(height: 8),
                ContinueButton(
                  label: _state.texts.login,
                  onPressed: () => _onSubmit(context),
                ),
                if (_state.error != null)
                  LoginError(texts: _state.texts, error: _state.error),
                const Padding(padding: EdgeInsets.all(8), child: Divider()),
                ScreenH3(_state.texts.noAccountYet),
                OutlinedButton(
                  onPressed: () => _goToRegisterScreen(context),
                  child: Text(_state.texts.createAccount),
                ),
                Text(_state.texts.or),
                OutlinedButton(
                  onPressed: _registerAsGuest,
                  child: Text(_state.texts.continueAsGuest),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
