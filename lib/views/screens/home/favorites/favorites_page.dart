import 'package:flutter/material.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(child: Text('المفضلة', style: StringStyle.headerStyle)),
    );
  }
}
