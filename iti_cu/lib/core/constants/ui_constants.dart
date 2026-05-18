import 'package:iti_cu/features/main/presentation/ui_models/nav_item.dart';
import 'package:iti_cu/features/account/presentation/ui_models/account_item.dart';
import 'package:iti_cu/core/resource/app_icons.dart';
import 'package:iti_cu/features/home/presentation/screens/home_screen.dart';
import 'package:iti_cu/features/chat/presentation/screens/chat_screen.dart';
import 'package:iti_cu/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:iti_cu/features/account/presentation/screens/account_screen.dart';

class UiConstants {
  UiConstants._();

  static final List<NavItem> navItems = [
    NavItem(icon: AppIcons.home, label: 'Home', child: const HomeScreen()),
    NavItem(icon: AppIcons.chat, label: 'Chat', child: const ChatScreen()),
    NavItem(
      icon: AppIcons.notifications,
      label: 'Alerts',
      child: const NotificationsScreen(),
    ),
    NavItem(
      icon: AppIcons.account,
      label: 'Account',
      child: const AccountScreen(),
    ),
  ];

  static final List<AccountItem> accountItems = [
    AccountItem(
      icon: AppIcons.account,
      title: 'Profile Info',
      route: const HomeScreen(),
    ),
    AccountItem(
      icon: AppIcons.notifications,
      title: 'Settings',
      route: const HomeScreen(),
    ),
    AccountItem(
      icon: AppIcons.chat,
      title: 'Logout',
      route: const HomeScreen(),
    ),
  ];
}
