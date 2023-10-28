import 'package:flutter/material.dart';
import 'package:fv1/ui/widgets/app_card.dart';

class NoDataMessage extends StatelessWidget {
  static const Key widgetKey = Key('NoDataMessage');
  final String _message;

  const NoDataMessage(this._message, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: 16,
      child: Text(
        _message,
        key: widgetKey,
      ),
    );
  }
}
