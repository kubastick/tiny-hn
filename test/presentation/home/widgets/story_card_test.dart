import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tiny_hn/domain/hacker_news/models/story.dart';
import 'package:tiny_hn/presentation/pages/home/widgets/story_card.dart';

import '../../../utils/widget_tester_utils.dart';

void main() {
  group(
    'StoryCard',
    () {
      final testStory = Story(
        id: '',
        authorUsername: '',
        commentCount: 0,
        commentIDs: [],
        score: 0,
        creationTime: DateTime(0),
        title: '',
      );

      testWidgets(
        'shows title',
        (tester) async {
          const testTitle = 'xyz';
          final story = testStory.copyWith(title: testTitle);
          await tester.pumpAppWidget(StoryCard(story: story));
          await tester.pumpAndSettle();

          expect(find.text(testTitle), findsOneWidget);
        },
      );

      testWidgets(
        'shows score and comment cunt',
        (tester) async {
          const testScore = 321;
          const testCommentCount = 567;

          final story = testStory.copyWith(
            score: testScore,
            commentCount: testCommentCount,
          );
          await tester.pumpAppWidget(StoryCard(story: story));
          await tester.pumpAndSettle();

          expect(find.textContaining(testScore.toString()), findsOneWidget);
          expect(find.textContaining(testCommentCount.toString()), findsOneWidget);
        },
      );

      testWidgets(
        'shows username',
        (tester) async {
          const testUsername = 'test';
          final story = testStory.copyWith(authorUsername: testUsername);
          await tester.pumpAppWidget(StoryCard(story: story));
          await tester.pumpAndSettle();

          expect(find.textContaining(testUsername), findsOneWidget);
        },
      );

      testGoldens(
        'matches golden',
        (tester) async {
          final goldenStory = Story(
            id: '',
            authorUsername: 'Author',
            commentCount: 123,
            commentIDs: [],
            score: 321,
            creationTime: DateTime(0),
            title: 'Test story',
          );

          final goldenBuilder = GoldenBuilder.column()
            ..addScenario(
              'Without optional parameters',
              StoryCard(
                story: goldenStory,
              ),
            )
            ..addTextScaleScenario(
              'Text scaling',
              StoryCard(
                story: goldenStory,
              ),
              textScaleFactor: 2,
            )
            ..addScenario(
              'With natural index',
              StoryCard(
                story: goldenStory,
                naturalIndex: 1,
              ),
            );
          await tester.pumpWidgetBuilder(goldenBuilder.build());

          await screenMatchesGolden(tester, 'story_card');
        },
      );
    },
  );
}
