import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tiny_hn/domain/hacker_news/models/story.dart';
import 'package:tiny_hn/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({
    required this.story,
    this.naturalIndex,
    this.onCommentsPressed,
    super.key,
  });

  final Story story;
  final int? naturalIndex;
  final VoidCallback? onCommentsPressed;

  @override
  Widget build(BuildContext context) {
    final prettyUrl = story.prettyUrl();

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () async {
          final storyURL = story.url;
          if (storyURL != null) {
            await launchUrlString(storyURL);
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Card(
          child: ListTile(
            visualDensity: VisualDensity.comfortable,
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
            trailing: IconButton(
              onPressed: onCommentsPressed,
              icon: const Icon(
                Icons.comment,
                size: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
