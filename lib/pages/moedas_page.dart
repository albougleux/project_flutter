import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/models/moeda.dart';
import 'package:project_flutter/pages/common/dynamic_appbar.dart';
import 'package:project_flutter/pages/moedas_detalhes_page.dart';
import 'package:project_flutter/repository/moeda_repository.dart';
import 'package:project_flutter/repository/moedas_controller.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({
    required this.controller,
    required this.coinList,
    super.key,
  });
  final CoinsController controller;
  final List<Coin> coinList;

  static Widget create() {
    return MoedasPage(
      controller: CoinsController(),
      coinList: MoedaRepository.coinList,
    );
  }

  @override
  _MoedasPageState createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: r'R$');
  CoinsController get controller => widget.controller;
  List<Coin> get coinList => widget.coinList;

  void showDetails(Coin coin) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MoedasDetalhesPage(coin: coin),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DynamicAppBar(
        isEmpty: controller.selected.isEmpty,
        onPressed: () {
          setState(() {
            controller.selected.clear();
          });
        },
        selected: controller.selected.length,
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int coin) {
          return ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: (controller.isSelected(coinList[coin]))
                ? const CircleAvatar(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  )
                : SizedBox(
                    width: 40,
                    child: Image.asset(coinList[coin].icon),
                  ),
            title: Text(
              coinList[coin].name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.lightBlue,
              ),
              key: const Key('coins_name'),
            ),
            subtitle: Text(
              coinList[coin].initials,
              style: const TextStyle(
                color: Colors.lightBlue,
              ),
              key: const Key('coins_initials'),
            ),
            trailing: Text(
              real.format(coinList[coin].price),
              style: const TextStyle(
                color: Colors.lightBlue,
              ),
              key: const Key('coins_price'),
            ),
            selected: controller.isSelected(coinList[coin]),
            selectedTileColor: Colors.lightBlue[50],
            onLongPress: () {
              setState(() {
                controller.updateSelected(coinList[coin]);
              });
            },
            onTap: () => showDetails(coinList[coin]),
          );
        },
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: coinList.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (controller.selected.isNotEmpty)
          ? FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(
                Icons.star,
                color: Colors.white,
              ),
              label: const Text(
                'FAVORITAR',
                style: TextStyle(
                  letterSpacing: 0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                key: Key('favorite_button'),
              ),
            )
          : null,
    );
  }
}
