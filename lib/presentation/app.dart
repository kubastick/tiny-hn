import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tiny_hn/generated/locale_keys.g.dart';
import 'package:tiny_hn/presentation/routing/router.dart';
import 'package:tiny_hn/presentation/style/app_colors.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => LocaleKeys.app_name.tr(context: context),
      routerConfig: router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.hackerNewsHeaderColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
    );
  }
}
