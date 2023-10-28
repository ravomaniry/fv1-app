import 'package:flutter/material.dart';
import 'package:fv1/ui/widgets/card_container.dart';

class HomeCard extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget? actionButton;
  final Widget? trailing;
  final void Function()? onTap;

  const HomeCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.actionButton,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        children: [
          ListTile(
            title: title,
            subtitle: subtitle,
            onTap: onTap,
            trailing: trailing,
          ),
          if (actionButton != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [actionButton!],
            ),
        ],
      ),
    );
  }
}
