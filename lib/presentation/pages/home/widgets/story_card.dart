import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tiny_hn/domain/hacker_news/models/story.dart';
import 'package:tiny_hn/generated/locale_keys.g.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({
    required this.story,
    this.naturalIndex,
    super.key,
  });

  final Story story;
  final int? naturalIndex;

  @override
  Widget build(BuildContext context) {
    final prettyUrl = story.prettyUrl();

    return Card(
      child: ListTile(
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: story.title),
              if (prettyUrl != null) TextSpan(text: ' ($prettyUrl)', style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ),
        subtitle: Text(
          LocaleKeys.home_cart_card_xpoints_points_by_xusername_xcommentcount_comments.tr(
            namedArgs: {
              'points': story.score.toString(),
              'username': story.authorUsername,
              'commentCount': story.commentCount.toString(),
            },
          ),
        ),
        leading: naturalIndex != null
            ? Text(
                '$naturalIndex.',
                style: Theme.of(context).textTheme.bodyLarge,
              )
            : null,
      ),
    );
  }
}
