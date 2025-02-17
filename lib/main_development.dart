import 'package:flutter/material.dart';
import 'package:mayway_business/constants/enum.dart';
import 'package:mayway_business/constants/environments.dart';
import 'package:mayway_business/main.dart';

void main() {
  mainMirrorHub(MirrorHubEnvironment(EnvironmentType.development));
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrueCallerOverlay(),
    ),
  );
}
