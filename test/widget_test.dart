import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wish_marketplace/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: WishMarketplaceApp(),
      ),
    );

    // Verify splash screen shows
    expect(find.text('Wish Marketplace'), findsOneWidget);
  });
}
