import 'package:flutter/material.dart';
import 'package:iti_cu/features/home/presentation/widgets/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(),
      body: Center(
        child: Text('Welcome Home', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
