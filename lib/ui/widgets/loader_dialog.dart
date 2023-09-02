import 'package:flutter/material.dart';

class LoaderDialog extends StatelessWidget {
  static const loaderKey = Key('loaderDialog');

  const LoaderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      content: CircularProgressIndicator(
        value: null,
        key: loaderKey,
      ),
    );
  }
}
