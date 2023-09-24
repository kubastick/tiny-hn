import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:tiny_hn/core/di/injectable.dart';
import 'package:tiny_hn/core/log/bloc_logger.dart';
import 'package:tiny_hn/presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();
  Bloc.observer = BlocLogger();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: HookedBlocConfigProvider(
        injector: () => getIt.get,
        child: const App(),
      ),
    ),
  );
}
