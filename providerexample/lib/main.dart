// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerexample/ChangeListeners/ColorList.dart';
import 'package:providerexample/ChangeListeners/CurrentValue.dart';
import 'package:providerexample/ChangeListeners/TimerValue.dart';

import 'Global.dart';
import 'MyHomePage.dart';
import 'ChangeListeners/Points.dart';

void main() {
  Global.fillColorNamesList();
  Global.fillColorListEasy();
  Global.fillColorListMedium();
  Global.fillColorListHard();

  runApp(
    // Provide the model to all widgets within the app. We're using
    // ChangeNotifierProvider because that's a simple way to rebuild
    // widgets when a model changes. We could also just use
    // Provider, but then we would have to listen to Counter ourselves.
    //
    // Read Provider's docs to learn about all the available providers.
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
      // Initialize the model in the builder. That way, Provider
      // can own Counter's lifecycle, making sure to call `dispose`
      // when not needed anymore.
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
