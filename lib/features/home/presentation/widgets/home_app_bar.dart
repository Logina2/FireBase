import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iti_cu/core/common_model/app_user.dart';
import 'package:iti_cu/core/resource/app_colors.dart';
import 'package:iti_cu/core/services/firebase_auth_service.dart';
import 'package:iti_cu/core/services/firebase_firestore_service.dart';
import 'package:iti_cu/core/services/firebase_user_status.dart';
import 'package:iti_cu/core/services/user_manager.dart';
import 'package:iti_cu/features/home/presentation/widgets/user_status_widget.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final UserManager manager = UserManager();
  final String userId = FirebaseAuthService.getCurrentUser()!.uid;
  AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    manager.init(userId);
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await FirebaseFirestoreService.getUserData(userId);
    setState(() => currentUser = user);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentUser?.name ?? 'Loading...',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          StreamBuilder<DatabaseEvent>(
            stream: FirebaseUserStatus.getStatus(userId),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data?.snapshot.value == null)
                return const UserStatusWidget(isOnline: false);
              final map = Map<String, dynamic>.from(
                snapshot.data!.snapshot.value as Map,
              );
              return UserStatusWidget(isOnline: map['online'] == true);
            },
          ),
        ],
      ),
    );
  }
}
