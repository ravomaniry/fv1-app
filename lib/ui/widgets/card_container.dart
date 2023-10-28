import 'package:flutter/material.dart';
import 'package:fv1/ui/widgets/app_card.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final bool selected;

  const CardContainer({
    super.key,
    required this.child,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = selected ? const Color(0xfff4f4f4) : null;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: selected ? theme.primaryColor : const Color(0xfff0f0f0),
          ),
        ),
        color: color,
      ),
      child: AppCard(
        color: color,
        child: child,
      ),
    );
  }
}
