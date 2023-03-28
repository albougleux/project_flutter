// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter/models/moeda.dart';

class MoedasDetalhesPage extends StatefulWidget {
  MoedasDetalhesPage({super.key, required this.coin});
  Coin coin;

  @override
  _MoedasDetalhesPageState createState() => _MoedasDetalhesPageState();
}

class _MoedasDetalhesPageState extends State<MoedasDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: r'R$');
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;
  double minValue = 50;

  void calcMoeda(String value) {
    setState(() {
      quantidade =
          (value.isEmpty) ? 0 : double.parse(value) / widget.coin.price;
    });
  }

  void comprar() {
    if (_form.currentState!.validate()) {
      // Salvar Compra no Database

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Compra realizada com sucesso!',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
          key: const Key('coins_purchase_snackbar'),
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
          style: TextStyle(
            color: Colors.white,
          ),
          key: const Key('coins_details_title'),
        ),
        centerTitle: true,
        key: const Key('coins_details_appbar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 24),
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
                    style: TextStyle(
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
            if (quantidade > 0)
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: Text(
                    '$quantidade ${widget.coin.initials}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.lightBlue,
                    ),
                    key: const Key('coinbox_details_initials_text'),
                  ),
                  margin: EdgeInsets.only(bottom: 24),
                  padding: EdgeInsets.all(16),
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
                margin: EdgeInsets.only(bottom: 16),
              ),
            Form(
              key: _form,
              child: TextFormField(
                controller: _valor,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.lightBlue,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
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
                onChanged: calcMoeda,
                key: const Key('coins_details_value_input'),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: comprar,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    Padding(
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
