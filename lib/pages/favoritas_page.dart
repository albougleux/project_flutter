// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class FavoritasPage extends StatefulWidget {
  const FavoritasPage({super.key});

  @override
  _FavoritasPageState createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Moedas Favoritas',
          style: TextStyle(color: Colors.white),
          key: const Key('favorites_title'),
        ),
        centerTitle: true,
        key: const Key('favorites_appbar'),
      ),
    );
  }
}
