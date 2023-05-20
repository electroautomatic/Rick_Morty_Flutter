import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

enum LiveState { alive, dead, unknown }

class ChatacterStatus extends StatelessWidget {
  final LiveState liveState;
  const ChatacterStatus({super.key, required this.liveState});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.circle,
          size: 11,
          color: liveState == LiveState.alive
              ? Colors.lightGreenAccent[400]
              : liveState == LiveState.dead
                  ? Colors.red
                  : Colors.white,
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          liveState == LiveState.dead
              ? 'dead'
              : liveState == LiveState.alive
                  ? 'alive'
                  : 'unknown',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
