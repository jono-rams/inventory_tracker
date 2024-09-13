import 'package:flutter/material.dart';
import 'package:inventory_tracker/models/app_user.dart';
import 'package:inventory_tracker/services/auth_service.dart';
import 'package:inventory_tracker/shared/styled_button.dart';
import 'package:inventory_tracker/shared/styled_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledAppBarText('Your Profile'),
        backgroundColor: Colors.blue[500],
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StyledHeading('Profile'),
            const SizedBox(
              height: 16.0,
            ),

            // Output user email
            StyledBodyText('Welcome to your profile, ${user.email}'),
            const SizedBox(
              height: 16.0,
            ),

            StyledButton(
              onPressed: () {
                AuthService.signOut();
              },
              child: const StyledButtonText('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
