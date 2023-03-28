import 'package:flutter/material.dart';

class DynamicAppBar extends StatelessWidget with PreferredSizeWidget {
  const DynamicAppBar({
    required this.isEmpty,
    required this.onPressed,
    required this.selected,
    super.key,
  });
  final bool isEmpty;
  final VoidCallback onPressed;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isEmpty,
      replacement: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onPressed,
        ),
        title: Text(
          '$selected selecionadas',
          key: const Key('coins_title_selected'),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.lightBlue),
        titleTextStyle: const TextStyle(
          color: Colors.lightBlue,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        key: const Key('coins_appbar_selected'),
      ),
      child: AppBar(
        title: const Text(
          'Crypto Moedas',
          style: TextStyle(
            color: Colors.white,
          ),
          key: Key('coins_title'),
        ),
        centerTitle: true,
        key: const Key('coins_appbar'),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
