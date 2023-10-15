import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:tiny_hn/domain/hacker_news/models/comment.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({
    required this.comment,
    super.key,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.author,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          HtmlWidget(
            comment.text,
            textStyle: Theme.of(context).textTheme.bodySmall,
            onTapUrl: launchUrlString,
          ),
        ],
      ),
    );
  }
}
