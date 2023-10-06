import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:tiny_hn/domain/hacker_news/models/story.dart';
import 'package:tiny_hn/presentation/pages/story_comments/story_comments_cubit.dart';
import 'package:tiny_hn/presentation/pages/story_comments/widgets/comment_tree.dart';
import 'package:tiny_hn/presentation/widgets/story_card.dart';

// TODO(jakubtomana): optimize layout because it is very inefficient right now
class StoryCommentsPage extends HookWidget {
  const StoryCommentsPage({
    required this.storyID,
    this.story,
    super.key,
  });

  final String storyID;
  final Story? story;

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<StoryCommentsCubit>();
    final state = useBlocBuilder(cubit);

    useEffect(
      () {
        cubit.initialize(
          storyID: storyID,
          story: story,
        );

        return null;
      },
      [cubit],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Story '),
      ),
      body: switch (state) {
        StoryCommentsStateLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
        (final StoryCommentsStateIdle state) => ListView(
            padding: const EdgeInsets.all(8),
            children: [
              StoryCard(story: state.story),
              const SizedBox(height: 16),
              switch (state.comments) {
                CommentsStateLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                (final CommentsStateIdle state) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.comment.length,
                    itemBuilder: (context, i) {
                      final comment = state.comment[i];

                      return CommentTree(comment: comment);
                    },
                  ),
              },
            ],
          ),
      },
    );
  }
}
