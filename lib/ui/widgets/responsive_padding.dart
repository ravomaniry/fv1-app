import 'package:flutter/material.dart';

class ResponsivePadding extends StatelessWidget {
  final Widget child;

  const ResponsivePadding({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    const maxWidth = 800;
    final size = MediaQuery.of(context).size;
    return size.width > size.height && size.width > maxWidth
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: (size.width - maxWidth) / 2,
            ),
            child: SafeArea(child: child),
          )
        : SafeArea(child: child);
  }
}
