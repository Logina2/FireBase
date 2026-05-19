import 'package:flutter/material.dart';
import 'package:iti_cu/core/constants/ui_constants.dart';
import 'package:iti_cu/core/resource/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: UiConstants.navItems.map((e) => e.child).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (v) => setState(() => pageIndex = v),
        backgroundColor: AppColors.primary,
        selectedItemColor: AppColors.cyan,
        unselectedItemColor: AppColors.grey,
        type: BottomNavigationBarType.fixed,
        items: UiConstants.navItems
            .map(
              (e) => BottomNavigationBarItem(
                icon: const Icon(Icons.bubble_chart),
                label: e.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
