import 'package:flutter/cupertino.dart';

class NoDataMessage extends StatelessWidget {
  static const Key widgetKey = Key('NoDataMessage');
  final String _message;

  const NoDataMessage(this._message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _message,
        key: widgetKey,
      ),
    );
  }
}
