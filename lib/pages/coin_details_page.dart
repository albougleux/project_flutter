// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/models/coin.dart';

class CoinDetailsPage extends StatefulWidget {
  const CoinDetailsPage({required this.coin, super.key});
  final Coin coin;

  @override
  _CoinDetailsPageState createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: r'R$');
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantity = 0;
  double minValue = 50;

  @override
  void dispose() {
    _valor.dispose();
    super.dispose();
  }

  void coinCalculator(String value) {
    setState(() {
      quantity = (value.isEmpty) ? 0 : double.parse(value) / widget.coin.price;
    });
  }

  void purchase() {
    if (_form.currentState!.validate()) {
      // Save purchase in Database

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Compra realizada com sucesso!',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
          key: Key('coins_purchase_snackbar'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.coin.name,
          style: const TextStyle(
            color: Colors.white,
          ),
          key: const Key('coins_details_title'),
        ),
        centerTitle: true,
        key: const Key('coins_details_appbar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(widget.coin.icon),
                    width: 50,
                    key: const Key('coins_details_icon'),
                  ),
                  Container(width: 10),
                  Text(
                    real.format(widget.coin.price),
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.lightBlue,
                    ),
                    key: const Key('coins_details_price'),
                  ),
                ],
              ),
            ),
            if (quantity > 0)
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: Text(
                    '$quantity ${widget.coin.initials}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue,
                    ),
                    key: const Key('coinbox_details_initials_text'),
                  ),
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.lightBlue.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  key: const Key('coins_details_quantity_box'),
                ),
              )
            else
              Container(
                margin: const EdgeInsets.only(bottom: 16),
              ),
            Form(
              key: _form,
              child: TextFormField(
                controller: _valor,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.lightBlue,
                ),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Valor',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  suffix: Text(
                    r'R$',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o valor da compra';
                  } else if (double.parse(value) < minValue) {
                    return 'O valor mínimo é de R\$ ${minValue.toStringAsFixed(2)}';
                  }
                  return null;
                },
                onChanged: coinCalculator,
                key: const Key('coins_details_value_input'),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: purchase,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Comprar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              key: const Key('coins_details_buy_button'),
            ),
          ],
        ),
      ),
    );
  }
}
