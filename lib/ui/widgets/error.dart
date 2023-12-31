import 'package:flutter/material.dart';
import 'package:fv1/extensions/context.dart';
import 'package:fv1/providers/app_state.dart';
import 'package:fv1/providers/browser_state.dart';
import 'package:fv1/types/exceptions.dart';
import 'package:fv1/ui/widgets/error_text.dart';

class AppErrorWidget extends StatelessWidget {
  final AppState appState;
  final BrowserState browserState;

  const AppErrorWidget({
    super.key,
    required this.appState,
    required this.browserState,
  });

  String _getErrorMsg() {
    return browserState.error is AppException
        ? (browserState.error as AppException).getMessage(appState.texts)
        : appState.texts.errorUnknown;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Expanded(
          child: ErrorText(_getErrorMsg()),
        ),
        CloseButton(
          onPressed: () => browserState.dismissError(),
          color: context.themeErrorColor,
          key: const Key('DismissErrorButton'),
        ),
      ],
    );
  }
}
