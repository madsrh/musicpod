import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gtk/gtk.dart';
import 'package:yaru/yaru.dart';

import '../l10n/l10n.dart';
import 'app.dart';
import 'theme.dart';

class MusicPod extends StatelessWidget {
  const MusicPod({super.key, required this.yaruApp});

  final bool yaruApp;

  @override
  Widget build(BuildContext context) {
    if (yaruApp) {
      return YaruTheme(
        builder: (context, yaruThemeData, child) {
          final materialApp = MusicPodApp(
            lightTheme: yaruThemeData.theme,
            darkTheme: yaruThemeData.darkTheme,
          );
          return GtkApplication(
            child: materialApp,
          );
        },
      );
    } else {
      return MusicPodApp(
        lightTheme: m3Theme(),
        darkTheme: m3Theme(brightness: Brightness.dark),
      );
    }
  }
}

class MusicPodApp extends StatelessWidget {
  const MusicPodApp({
    super.key,
    this.lightTheme,
    this.darkTheme,
  });

  final ThemeData? lightTheme, darkTheme;

  @override
  Widget build(BuildContext context) {
    const dividerColor = Color.fromARGB(28, 255, 255, 255);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme?.copyWith(
        dividerColor: dividerColor,
        dividerTheme: const DividerThemeData(
          color: dividerColor,
          space: 1.0,
          thickness: 0.0,
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: supportedLocales,
      onGenerateTitle: (context) => 'MusicPod',
      home: App.create(),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
          PointerDeviceKind.trackpad,
        },
      ),
    );
  }
}