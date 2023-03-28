import 'package:project_flutter/models/coin.dart';

class CoinsController {
  final List<Coin> _selected = [];

  void updateSelected(Coin coin) {
    if (_selected.contains(coin)) {
      _selected.remove(coin);
    } else {
      _selected.add(coin);
    }
  }

  bool isSelected(Coin coin) {
    return _selected.contains(coin);
  }

  List<Coin> get selected => _selected;
}
