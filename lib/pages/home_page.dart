// ignore_for_file: prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:project_flutter/pages/coins_page.dart';
import 'package:project_flutter/pages/favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int actualPage = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: actualPage);
  }

  void setActualPage(int page) {
    setState(() {
      actualPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          CoinsPage.create(),
          const FavoritesPage(),
        ],
        onPageChanged: setActualPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: actualPage,
        onTap: (page) {
          actualPage = page;
          pc.animateToPage(
            actualPage,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Todas',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.star_outlined),
            label: 'Favoritas',
          ),
        ],
        backgroundColor: Colors.lightBlue[100],
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.white,
        key: const Key('bottomNavigationBar'),
      ),
    );
  }
}
