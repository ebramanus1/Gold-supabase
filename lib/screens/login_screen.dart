import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gold_workshop_manager/blocs/auth/auth_bloc.dart';
import 'package:gold_workshop_manager/localization/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.login)),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go('/');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: appLocalizations.username),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: appLocalizations.password),
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          LoginRequested(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                  },
                  child: Text(appLocalizations.login),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

