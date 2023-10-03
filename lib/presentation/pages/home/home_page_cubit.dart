import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tiny_hn/domain/hacker_news/models/story.dart';
import 'package:tiny_hn/domain/hacker_news/use_cases/fetch_stories_use_case.dart';

part 'home_page_cubit.freezed.dart';

part 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(
    this._fetchStoriesUseCase,
  ) : super(const HomePageState.loading());

  final FetchStoriesUseCase _fetchStoriesUseCase;

  Future<void> initialize() async {
    await refreshStories();
  }

  Future<void> refreshStories() async {
    final stories = await _fetchStoriesUseCase();
    emit(HomePageState.idle(stories: stories));
  }
}
