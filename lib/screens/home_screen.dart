import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gold_workshop_manager/blocs/auth/auth_bloc.dart';
import 'package:gold_workshop_manager/localization/app_localizations.dart';
import 'package:gold_workshop_manager/widgets/gold_price_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.homeScreen),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            context.go('/login');
          }
        },
        child: Column(
          children: [
            Text(appLocalizations.welcomeMessage),
            GoldPriceCard(),
          ],
        ),
      ),
    );
  }
}

