import 'package:flutter/material.dart';
import 'package:inventory_tracker/services/auth_service.dart';
import 'package:inventory_tracker/shared/styled_button.dart';
import 'package:inventory_tracker/shared/styled_text.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _email = '';
  String _password = '';

  String? _errorFeedback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // intro text
            const Center(
              child: StyledBodyText('Sign into your account'),
            ),
            const SizedBox(
              height: 16.0,
            ),

            // email address
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                labelText: 'Email address',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!.trim();
              },
            ),
            const SizedBox(
              height: 16.0,
            ),

            // password
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
              onSaved: (value) {
                _password = value!.trim();
              },
            ),
            const SizedBox(
              height: 16.0,
            ),

            // error feedback
            if (_errorFeedback != null)
              Text(
                _errorFeedback!,
                style: const TextStyle(color: Colors.red),
              ),

            // submit button
            StyledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _errorFeedback = null;
                  });

                  // perform sign-in logic here
                  _formKey.currentState!.save();

                  final user = await AuthService.signIn(_email, _password);

                  // error feedback
                  if (user == null) {
                    setState(() {
                      _errorFeedback = 'Invalid email or password';
                      // clear form fields
                      _formKey.currentState!.reset();
                    });
                  }
                }
              },
              child: const StyledButtonText('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
