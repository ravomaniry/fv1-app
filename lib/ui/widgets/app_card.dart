import 'package:flutter/material.dart';
import 'package:fv1/extensions/context.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? padding;
  final bool? selected;

  const AppCard({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor = selected == true ? context.themeSecondaryColor : null;
    return Card(
      color: color ?? selectedColor,
      child: Padding(
        padding: EdgeInsets.all(padding ?? 2),
        child: child,
      ),
    );
  }
}
