import 'package:tiny_hn/domain/hacker_news/models/comment.dart';
import 'package:tiny_hn/domain/hacker_news/models/story.dart';
import 'package:tiny_hn/domain/hacker_news/models/story_list_type.dart';

abstract interface class HackerNewsRepository {
  Future<List<Story>> fetchStories({
    required StoryListType storyListType,
    required int from,
    required int count,
  });

  Future<List<Comment>> fetchStoryComments({required String storyID});

  Future<List<Story>?> getCachedStories();
}
