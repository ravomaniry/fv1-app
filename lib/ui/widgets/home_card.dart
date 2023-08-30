import 'package:flutter/material.dart';
import 'package:fv1/ui/widgets/card_container.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget actionButton;

  const HomeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        children: [
          ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [actionButton],
          ),
        ],
      ),
    );
  }
}
