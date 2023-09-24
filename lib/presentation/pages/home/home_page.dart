import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tiny_hn/generated/locale_keys.g.dart';

class HomePage extends HookWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home_app_bar_title.tr()),
      ),
      body: Center(
        child: Text(LocaleKeys.home_hello_world.tr()),
      ),
    );
  }
}
