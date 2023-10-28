import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? padding;

  const AppCard({super.key, required this.child, this.color, this.padding});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: EdgeInsets.all(padding ?? 4),
        child: child,
      ),
    );
  }
}
