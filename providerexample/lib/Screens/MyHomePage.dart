import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerexample/ChangeListeners/CurrentValue.dart';
import 'package:providerexample/ChangeListeners/TimerValue.dart';
import 'package:providerexample/Models/HighScore.dart';
import 'package:providerexample/Screens/EndScoreScreen.dart';
import 'package:providerexample/Widgets/TimerWidget.dart';
import 'package:providerexample/repository/dataRepository.dart';

import '../ChangeListeners/Points.dart';
import '../Widgets/BoxRow.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> {
  DataRepository repository = DataRepository();

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

  String name = "";
  bool shouldShowNewRecordModal = false;
  endGame(BuildContext context) async {
    int currentScore = Provider.of<Points>(context, listen: false).value;

    int numHigher = await repository.findNumberOfScoresHigherThan(currentScore);
    if (numHigher <= 5 && mounted) {
      await _displayHighScoreModal(context);
      if (name == '') name = createRandomUserID();
      if (mounted) {
        repository.addHighScore(HighScore(score: currentScore, name: name));
      }
    }
    if (mounted) {
      Provider.of<TimerValue>(context, listen: false).endGame();
    }
  }

  String createRandomUserID() {
    return "user${Random().nextInt(12345)}";
  }

  final TextEditingController _textFieldController =
      TextEditingController(text: '');
  _displayHighScoreModal(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New Record'),
            content: TextField(
              onChanged: (value) {},
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "Name or Initials"),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => {
                  name = _textFieldController.value.text,
                  Navigator.pop(context),
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    const int amountOfTimeForTheUser = 150;

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
                                  startingSeconds: amountOfTimeForTheUser,
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
            : EndScoreScreen(),
      ),
    );
  }
}
