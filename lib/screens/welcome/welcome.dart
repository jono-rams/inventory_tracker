import 'package:inventory_tracker/screens/welcome/sign_in.dart';
import 'package:inventory_tracker/shared/styled_text.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledAppBarText('Vemco It Asset Management System'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[800],
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StyledHeading('Welcome.'),
            Column(
              // sign in screen
              children: [
                SignInForm(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
