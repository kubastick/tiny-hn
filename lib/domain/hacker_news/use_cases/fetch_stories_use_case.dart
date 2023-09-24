import 'package:injectable/injectable.dart';
import 'package:tiny_hn/domain/hacker_news/hacker_news_repository.dart';
import 'package:tiny_hn/domain/hacker_news/models/story.dart';
import 'package:tiny_hn/domain/hacker_news/models/story_list_type.dart';

@injectable
class FetchStoriesUseCase {
  const FetchStoriesUseCase(this._hackerNewsRepository);

  final HackerNewsRepository _hackerNewsRepository;

  Future<List<Story>> call({
    StoryListType storyListType = StoryListType.top,
    int from = 0,
    int count = 30,
  }) =>
      _hackerNewsRepository.fetchStories(
        storyListType: storyListType,
        from: from,
        count: count,
      );
}
