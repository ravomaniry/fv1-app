import 'package:flutter/material.dart';

class WrapInLoader extends StatelessWidget {
  final bool isReady;
  final Widget Function() builder;

  const WrapInLoader({super.key, required this.isReady, required this.builder});

  @override
  Widget build(BuildContext context) {
    return isReady
        ? builder()
        : const Center(
            child: CircularProgressIndicator(value: null),
          );
  }
}
