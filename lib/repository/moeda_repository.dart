import 'package:project_flutter/models/moeda.dart';

class MoedaRepository {
  static List<Coin> coinList = [
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
