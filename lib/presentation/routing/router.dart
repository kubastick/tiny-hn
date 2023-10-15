import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiny_hn/domain/hacker_news/models/story.dart';
import 'package:tiny_hn/presentation/pages/home/home_page.dart';
import 'package:tiny_hn/presentation/pages/story_comments/story_comments.dart';

part 'router.g.dart';

final router = GoRouter(routes: $appRoutes);

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<StoryCommentsRoute>(
      path: 'story_comments',
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

class StoryCommentsRoute extends GoRouteData {
  StoryCommentsRoute({
    required this.storyID,
    this.$extra,
  });

  final String storyID;
  final Story? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => StoryCommentsPage(
        storyID: storyID,
        story: $extra,
      );
}
