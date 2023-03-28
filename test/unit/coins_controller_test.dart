import 'package:flutter_test/flutter_test.dart';
import 'package:project_flutter/repository/coins_controller.dart';

import '../helpers.dart';

void main() {
  late final CoinsController controller;
  setUpAll(() {
    controller = CoinsController();
  });
  tearDown(() {
    controller.selected.clear();
  });
  group('Test MoedasController', () {
    test('Moedas Controller is empty', () {
      expect(controller.selected.isEmpty, isTrue);
    });
    test('Moedas Controlller is not empty', () {
      controller.updateSelected(Helpers.bitcoin);
      expect(controller.selected.isEmpty, isFalse);
    });
    test('Bitcoin is selected', () {
      expect(controller.selected.isEmpty, isTrue);
      controller.updateSelected(Helpers.bitcoin);
      expect(controller.isSelected(Helpers.bitcoin), isTrue);
    });
    test('Bitcoin is removed from selection', () {
      controller
        ..updateSelected(Helpers.bitcoin)
        ..updateSelected(Helpers.bitcoin);
      expect(controller.isSelected(Helpers.bitcoin), isFalse);
    });
    test('Check coins quantity in list controller', () {
      for (final coin in Helpers.coinList) {
        controller.updateSelected(coin);
      }
      expect(controller.selected.length, Helpers.coinList.length);
    });
    test('Check add all coins and remove one', () {
      for (final coin in Helpers.coinList) {
        controller.updateSelected(coin);
      }
      controller.updateSelected(Helpers.coinList.last);
      expect(controller.selected.length, Helpers.coinList.length - 1);
    });
    test('Check add all coins and remove the first one', () {
      for (final coin in Helpers.coinList) {
        controller.updateSelected(coin);
      }
      final bitcoin = Helpers.coinList[0];
      controller.updateSelected(bitcoin);
      expect(controller.isSelected(bitcoin), isFalse);
    });
    test('Check add all coins and remove the last one', () {
      for (final coin in Helpers.coinList) {
        controller.updateSelected(coin);
      }
      final ltc = Helpers.coinList[5];
      controller.updateSelected(ltc);
      expect(controller.isSelected(ltc), isFalse);
    });
    test('Check add all coins and remove the middle one', () {
      for (final coin in Helpers.coinList) {
        controller.updateSelected(coin);
      }
      final xrp = Helpers.coinList[2];
      controller.updateSelected(xrp);
      expect(controller.isSelected(xrp), isFalse);
    });
  });
}
