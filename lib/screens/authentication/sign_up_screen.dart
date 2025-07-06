import 'package:flutter/material.dart';
import '../../theme/font_theme.dart';
import '../../repositories/auth_repository.dart';
import '../home/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String route = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _agree = true;
  bool _loading = false;
  String? _error;
  final AuthRepository _authRepository = AuthRepository();

  Future<void> _register() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await _authRepository.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        username: _usernameController.text.trim(),
      );
      if (mounted) {
        // After successful registration, user is automatically logged in
        Navigator.of(context).pushReplacementNamed(HomeScreen.route);
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        print(_error);
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  'Create your new account',
                  style: fontTheme.headlineLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Create an account to start looking for the food you like',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 32),
                if (_error != null) ...[
                  Text(
                    _error!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                Text(
                  'Email Address',
                  style: fontTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'Enter Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                Text(
                  'User Name',
                  style: fontTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(hintText: 'User Name'),
                ),
                const SizedBox(height: 20),
                Text(
                  'Password',
                  style: fontTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xFF8391A1),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _agree,
                      onChanged: (val) {
                        setState(() {
                          _agree = val ?? false;
                        });
                      },
                      activeColor: const Color(0xFF4ECB71),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'I Agree with ',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSecondary,
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms of Service and Privacy Policy',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _agree && !_loading ? _register : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4ECB71),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      elevation: 0,
                    ),
                    child: _loading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/signin');
                      },
                      child: Text(
                        'Sign In',
                        style: fontTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
