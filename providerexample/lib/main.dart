import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerexample/ChangeListeners/ColorList.dart';
import 'package:providerexample/ChangeListeners/CurrentValue.dart';
import 'package:providerexample/ChangeListeners/TimerValue.dart';

import 'Global.dart';
import 'ChangeListeners/Points.dart';
import 'Screens/MyHomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Global.fillColorNamesList();
  Global.fillColorListEasy();
  Global.fillColorListMedium();
  Global.fillColorListHard();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Points(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrentValue(),
        ),
        ChangeNotifierProvider(
          create: (context) => ColorList(Global.colorListEasy),
        ),
        ChangeNotifierProvider(
          create: (context) => TimerValue(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
