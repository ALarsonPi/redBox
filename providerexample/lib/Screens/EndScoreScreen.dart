import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerexample/ChangeListeners/CurrentValue.dart';
import 'package:providerexample/ChangeListeners/TimerValue.dart';
import 'package:providerexample/Models/HighScore.dart';

import '../ChangeListeners/Points.dart';
import '../repository/dataRepository.dart';

class EndScoreScreen extends StatelessWidget {
  EndScoreScreen({super.key});

  final DataRepository repository = DataRepository();

  restartGame(BuildContext context) {
    Provider.of<Points>(context, listen: false).resetPoints();
    Provider.of<TimerValue>(context, listen: false).restartGame();
    Provider.of<CurrentValue>(context, listen: false).resetValue();
  }

  // createModal(BuildContext context) async {
  //   String data = await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Expanded(
  //         child: AlertDialog(
  //           title: Text('Welcome'),
  //           content: Text('GeeksforGeeks'),
  //           actions: [
  //             ElevatedButton(
  //               onPressed: () {},
  //               child: Text('CANCEL'),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {},
  //               child: Text('ACCEPT'),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  //   return data;
  // }

  @override
  Widget build(BuildContext context) {
    // createModal(context);
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
            child: const Text("Try again"),
          ),
          const Divider(
            indent: 30,
            endIndent: 20,
            thickness: 2,
            height: 30,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              // Using the stream from the DataRepo (DAO) class
              stream: repository.getStream(),
              // Builder (basically a provider for when the data arrives)
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('No Scores Provided');
                } else if (snapshot.hasData) {
                  return _buildList(context, snapshot.data?.docs ?? []);
                } else {
                  return const Text('Error Occured');
                }
              }),
            ),
          ),
          // Stream of input coming from Firebase
        ],
      ),
    );
  }

  int index = 0;
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    index = 0;
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: (snapshot.isNotEmpty)
          ? snapshot.map((data) => _buildListItem(context, data)).toList()
          : [const Text('no scores')],
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final HighScore highScoreObject = HighScore.fromSnapshot(snapshot);
    index++;
    return (index <= 5)
        ? Card(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Center(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 56.0, right: 56.0),
                      child: Text(
                        '$index',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: RichText(
                        text: TextSpan(
                          text: '',
                          style: Theme.of(context).textTheme.displayLarge,
                          children: <TextSpan>[
                            const TextSpan(
                                text: 'Name: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                )),
                            TextSpan(
                                text: highScoreObject.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                )),
                            const TextSpan(
                                text: '\nScore: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                )),
                            TextSpan(
                                text: '${highScoreObject.score}',
                                style: const TextStyle(
                                  fontSize: 24,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const Text('');
  }
}
