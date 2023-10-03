import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tiny_hn/domain/hacker_news/models/story.dart';
import 'package:tiny_hn/domain/hacker_news/use_cases/fetch_stories_use_case.dart';
import 'package:tiny_hn/presentation/pages/home/home_page_cubit.dart';

import 'home_page_bloc_test.mocks.dart';

@GenerateMocks([
  FetchStoriesUseCase,
])
void main() {
  late FetchStoriesUseCase fetchStoriesUseCase;

  late HomePageCubit cubit;

  setUp(
    () {
      fetchStoriesUseCase = MockFetchStoriesUseCase();

      cubit = HomePageCubit(fetchStoriesUseCase);
    },
  );

  final testStories = [
    Story(
      id: '',
      authorUsername: '',
      commentCount: 0,
      commentIDs: [],
      score: 0,
      creationTime: DateTime(0),
      title: '',
    ),
  ];

  group('HomePageCubit', () {
    blocTest<HomePageCubit, HomePageState>(
      'initializes and fetches story cards',
      setUp: () {
        when(fetchStoriesUseCase.call()).thenAnswer((_) async => testStories);
      },
      build: () => cubit,
      act: (cubit) => cubit.initialize(),
      expect: () => [
        HomePageState.idle(stories: testStories),
      ],
    );
  });
}
