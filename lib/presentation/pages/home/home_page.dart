import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:tiny_hn/generated/locale_keys.g.dart';
import 'package:tiny_hn/presentation/pages/home/home_page_cubit.dart';
import 'package:tiny_hn/presentation/pages/home/widgets/story_card.dart';

class HomePage extends HookWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<HomePageCubit>();
    final state = useBlocBuilder(cubit);

    useEffect(
      () {
        cubit.initialize();

        return null;
      },
      [cubit],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home_app_bar_title.tr()),
      ),
      body: switch (state) {
        HomePageStateLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        final HomePageStateIdle state => RefreshIndicator(
            onRefresh: cubit.refreshStories,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: state.stories.length,
              itemBuilder: (context, index) {
                final story = state.stories[index];
                return StoryCard(
                  story: story,
                  naturalIndex: index + 1,
                );
              },
            ),
          ),
      },
    );
  }
}
