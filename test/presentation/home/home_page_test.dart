import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiny_hn/generated/locale_keys.g.dart';
import 'package:tiny_hn/presentation/pages/home/home_page.dart';

import '../../utils/widget_tester_utils.dart';

void main() {
  group(
    'HomePage',
    () {
      testWidgets(
        'shows hello world text',
        (tester) async {
          await tester.pumpAppWidget(const HomePage());
          await tester.pumpAndSettle();

          expect(find.textContaining(LocaleKeys.home_hello_world.tr()), findsOneWidget);
        },
      );
    },
  );
}
