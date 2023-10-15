import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tiny_hn/domain/hacker_news/models/comment.dart';
import 'package:tiny_hn/presentation/pages/story_comments/widgets/comment_tile.dart';
import 'package:tiny_hn/presentation/pages/story_comments/widgets/comment_tree_indent_container.dart';

class CommentTree extends StatelessWidget {
  const CommentTree({
    required this.comment,
    this.indent = 0,
    super.key,
  });

  final Comment comment;
  final int indent;

  @override
  Widget build(BuildContext context) {
    final childComments = comment.childComments;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommentTreeIndentContainer(
          indent: indent,
          child: CommentTile(comment: comment),
        ),
        if (childComments.isNotEmpty)
          ...childComments.mapIndexed(
            (index, comment) => CommentTree(
              comment: comment,
              indent: indent + 1,
            ),
          ),
      ],
    );
  }
}
