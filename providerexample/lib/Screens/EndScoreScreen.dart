import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerexample/ChangeListeners/CurrentValue.dart';
import 'package:providerexample/ChangeListeners/TimerValue.dart';

import '../ChangeListeners/Points.dart';

class EndScoreScreen extends StatelessWidget {
  const EndScoreScreen({super.key});

  restartGame(BuildContext context) {
    Provider.of<Points>(context, listen: false).resetPoints();
    Provider.of<TimerValue>(context, listen: false).restartGame();
    Provider.of<CurrentValue>(context, listen: false).resetValue();
  }

  @override
  Widget build(BuildContext context) {
    int currentScore = Provider.of<Points>(context).value;
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Text(
            'Points: $currentScore',
            style: const TextStyle(
              fontSize: 40,
            ),
          ),
          const Divider(
            indent: 30,
            endIndent: 20,
            thickness: 2,
            height: 30,
          ),
          ElevatedButton(
            onPressed: () => restartGame(context),
            child: Text("Try again"),
          ),
          const Divider(
            indent: 30,
            endIndent: 20,
            thickness: 2,
            height: 30,
          ),
        ],
      ),
    );
  }
}
