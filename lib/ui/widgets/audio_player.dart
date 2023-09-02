import 'package:flutter/material.dart';

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.play_arrow),
        ),
        Expanded(
          child: LinearProgressIndicator(
            value: 0.5,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
