part of 'story_comments_cubit.dart';

@freezed
sealed class StoryCommentsState with _$StoryCommentsState {
  const factory StoryCommentsState.loading() = StoryCommentsStateLoading;

  const factory StoryCommentsState.idle({
    required Story story,
    required CommentsState comments,
  }) = StoryCommentsStateIdle;
}

@freezed
sealed class CommentsState {
  const factory CommentsState.loading() = CommentsStateLoading;

  const factory CommentsState.idle({
    required List<Comment> comment,
  }) = CommentsStateIdle;
}
