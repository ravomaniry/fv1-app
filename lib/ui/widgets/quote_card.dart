import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  final Widget child;
  final Color borderColor;

  const QuoteCard({super.key, required this.child, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    const secondaryBorder = BorderSide(width: 1, color: Color(0xffeaeaea));
    return Container(
      padding: const EdgeInsets.only(
        left: 8,
        top: 4,
        bottom: 4,
        right: 4,
      ),
      margin: const EdgeInsets.only(bottom: 8, top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(
            color: borderColor,
            width: 2,
          ),
          bottom: secondaryBorder,
          right: secondaryBorder,
          top: secondaryBorder,
        ),
      ),
      child: child,
    );
  }
}
