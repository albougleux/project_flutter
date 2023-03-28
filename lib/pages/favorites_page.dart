import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Moedas Favoritas',
          style: TextStyle(color: Colors.white),
          key: Key('favorites_title'),
        ),
        centerTitle: true,
        key: const Key('favorites_appbar'),
      ),
    );
  }
}
