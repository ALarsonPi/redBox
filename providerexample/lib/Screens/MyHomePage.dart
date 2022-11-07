import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerexample/ChangeListeners/CurrentValue.dart';
import 'package:providerexample/ChangeListeners/TimerValue.dart';
import 'package:providerexample/Screens/EndScoreScreen.dart';
import 'package:providerexample/Widgets/TimerWidget.dart';

import '../ChangeListeners/Points.dart';
import '../Widgets/BoxRow.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  late TextStyle inGameTextStyle = const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  startCountdown(BuildContext context) {
    Provider.of<TimerValue>(context, listen: false).startCountdown();
  }

  startGame(BuildContext context) {
    Provider.of<TimerValue>(context, listen: false).startGame();
  }

  endGame(BuildContext context) {
    Provider.of<TimerValue>(context, listen: false).endGame();
  }

  @override
  Widget build(BuildContext context) {
    String currentTitle = (Provider.of<TimerValue>(context).hasStarted)
        ? 'Tap the Red Box!'
        : 'Tap Start to begin!';
    if (Provider.of<TimerValue>(context).shouldShowEndScreen) {
      currentTitle = 'Results';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(currentTitle, style: const TextStyle(fontSize: 30)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: (!Provider.of<TimerValue>(context).shouldShowEndScreen)
            ? Align(
                alignment: Alignment.topCenter,
                child: (!Provider.of<TimerValue>(context).hasStarted)
                    ? (!Provider.of<TimerValue>(context).shouldStartCountdown)
                        ? ElevatedButton(
                            onPressed: () => startCountdown(context),
                            child: const Text('Start'),
                          )
                        : TimerWidget(
                            startingSeconds: 3,
                            textStyle: const TextStyle(
                              fontSize: 50,
                            ),
                            timesUpFunction: startGame)
                    : ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Consumer<Points>(
                                  builder: (context, points, child) {
                                    return Text('Points: ${points.value}',
                                        style: inGameTextStyle);
                                  },
                                ),
                                TimerWidget(
                                  startingSeconds: 150,
                                  textStyle: inGameTextStyle,
                                  timesUpFunction: endGame,
                                  textToShow: 'Time Left',
                                  shouldShowText: true,
                                ),
                              ],
                            ),
                          ),
                          for (int i = 0;
                              i < Provider.of<CurrentValue>(context).numRows;
                              i++)
                            BoxRow(i),
                        ],
                      ),
              )
            : const EndScoreScreen(),
      ),
    );
  }
}
