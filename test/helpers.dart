import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_flutter/main.dart' as app;
import 'package:project_flutter/models/moeda.dart';

class Helpers {
  static const bitcoin = Coin(
    id: 0,
    name: 'Bitcoin',
    initials: 'BTC',
    icon: 'assets/images/bitcoin.png',
    price: 0,
  );

  static const coinList = [
    Coin(
      id: 0,
      icon: 'images/bitcoin.png',
      name: 'Bitcoin',
      initials: 'BTC',
      price: 1634603,
    ),
    Coin(
      id: 1,
      icon: 'images/ethereum.png',
      name: 'Ethereum',
      initials: 'ETH',
      price: 9716,
    ),
    Coin(
      id: 2,
      icon: 'images/xrp.png',
      name: 'XRP',
      initials: 'XRP',
      price: 3.34,
    ),
    Coin(
      id: 3,
      icon: 'images/cardano.png',
      name: 'Cardano',
      initials: 'ADA',
      price: 6.32,
    ),
    Coin(
      id: 4,
      icon: 'images/usdcoin.png',
      name: 'USD Coin',
      initials: 'USDC',
      price: 5.02,
    ),
    Coin(
      id: 5,
      icon: 'images/litecoin.png',
      name: 'Litecoin',
      initials: 'LTC',
      price: 669.93,
    ),
  ];
}

Future<void> initAppTest(WidgetTester tester) async {
  final originalOnError = FlutterError.onError!;
  app.main();
  await tester.pumpAndSettle();
  FlutterError.onError = (FlutterErrorDetails details) async {
    originalOnError(details);
  };
  expect(find.byKey(const Key('coins_title')), findsOneWidget);
}

Future<void> tapSingleButton(
  WidgetTester tester,
  Finder button, {
  bool warnIfMissed = true,
}) async {
  expect(button, findsOneWidget);
  await tester.tap(button, warnIfMissed: warnIfMissed);
  await tester.pumpAndSettle();
}

Future<void> tapSingleButtonWithDelay(
  WidgetTester tester,
  Finder button, {
  bool warnIfMissed = true,
  Duration duration = const Duration(seconds: 1),
}) async {
  expect(button, findsOneWidget);
  await tester.tap(button, warnIfMissed: warnIfMissed);
  await tester.pump();
  await delayTime(duration: duration);
}

Future<void> delayTime({
  Duration duration = const Duration(milliseconds: 100),
}) async {
  await Future<void>.delayed(duration);
}
