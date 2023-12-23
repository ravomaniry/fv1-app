import 'package:flutter/material.dart';
import 'package:fv1/extensions/context.dart';
import 'package:fv1/models/teaching_summary.dart';
import 'package:fv1/ui/widgets/card_container.dart';

class NewTeaching extends StatelessWidget {
  final TeachingSummaryModel teaching;
  final void Function(int id) onSelect;
  final String keyPrefix;

  const NewTeaching({
    super.key,
    required this.teaching,
    required this.onSelect,
    this.keyPrefix = '',
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: ListTile(
        key: Key('$keyPrefix${teaching.id}'),
        title: Text(teaching.title),
        subtitle: Text(teaching.subtitle),
        trailing: Icon(
          Icons.chevron_right,
          color: context.themePrimaryColor,
        ),
        onTap: () => onSelect(teaching.id),
      ),
    );
  }
}
