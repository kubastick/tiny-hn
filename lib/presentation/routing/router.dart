import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiny_hn/presentation/pages/home/home_page.dart';

part 'router.g.dart';

final router = GoRouter(routes: $appRoutes);

@TypedGoRoute<HomeRoute>(
  path: '/',
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}
