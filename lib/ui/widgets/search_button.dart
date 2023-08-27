import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final void Function() onPressed;

  const SearchButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.search, color: Colors.white),
    );
  }
}
