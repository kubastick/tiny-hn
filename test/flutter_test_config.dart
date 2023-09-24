import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/src/localization.dart';
import 'package:easy_localization/src/translations.dart';
import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts();
  await _loadTranslationIntoEasyLocalization();
  await testMain();
}

Future<void> _loadTranslationIntoEasyLocalization({String translationPath = 'assets/translations/en.json'}) async {
  final content = await File(translationPath).readAsString();
  final data = jsonDecode(content) as Map<String, dynamic>;

  Localization.load(
    const Locale('en'),
    translations: Translations(data),
  );
}
