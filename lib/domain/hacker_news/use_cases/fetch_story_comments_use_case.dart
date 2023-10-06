import 'package:injectable/injectable.dart';
import 'package:tiny_hn/domain/hacker_news/hacker_news_repository.dart';
import 'package:tiny_hn/domain/hacker_news/models/comment.dart';

@injectable
class FetchStoryCommentsUseCase {
  const FetchStoryCommentsUseCase(this._hackerNewsRepository);

  final HackerNewsRepository _hackerNewsRepository;

  Future<List<Comment>> call({
    required String storyID,
  }) =>
      _hackerNewsRepository.fetchStoryComments(storyID: storyID);
}
