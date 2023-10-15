import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tiny_hn/domain/hacker_news/models/comment.dart';
import 'package:tiny_hn/domain/hacker_news/models/story.dart';
import 'package:tiny_hn/domain/hacker_news/use_cases/fetch_story_comments_use_case.dart';

part 'story_comments_cubit.freezed.dart';

part 'story_comments_state.dart';

@injectable
class StoryCommentsCubit extends Cubit<StoryCommentsState> {
  StoryCommentsCubit(
    this._fetchStoryCommentsUseCase,
  ) : super(const StoryCommentsState.loading());

  final FetchStoryCommentsUseCase _fetchStoryCommentsUseCase;

  late final String storyID;

  Future<void> initialize({
    required String storyID,
    Story? story,
  }) async {
    this.storyID = storyID;

    if (story != null) {
      emit(
        StoryCommentsState.idle(
          story: story,
          comments: const CommentsState.loading(),
        ),
      );
      await _fetchData(storyID, story);
    }
  }

  Future<void> _fetchData(String storyID, Story story) async {
    final comments = await _fetchStoryCommentsUseCase(storyID: storyID);

    emit(
      StoryCommentsState.idle(
        story: story,
        comments: CommentsState.idle(comment: comments),
      ),
    );
  }
}
