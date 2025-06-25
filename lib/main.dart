import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'blocs/auth/auth_bloc.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'localization/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// إضافة استيراد dart:io فقط إذا لم يكن التطبيق ويب
// ignore: avoid_web_libraries_in_flutter
import 'dart:io' show Platform;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    try {
      String envPath = '.env';
      await dotenv.load(fileName: envPath);
    } catch (e) {
      runApp(MaterialApp(
        home: Scaffold(
          body: Center(
            child: SelectableText('خطأ: لم يتم العثور على ملف البيئة .env أو هناك مشكلة في تحميله\n$e'),
          ),
        ),
      ));
      return;
    }
  }

  try {
    await Supabase.initialize(
      url: kIsWeb ? 'https://lhqkhseyqrhkdjvgmgdw.supabase.co' : dotenv.env['SUPABASE_URL']!,
      anonKey: kIsWeb ? 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxocWtoaHNleXFyaGtkanZnbWdkdyIsInJvbGUiOiJhbm9uIiwiaWF0IjoxNzUwODAwNzI4LCJleHAiOjIwNjYzNzY3Mjh9.EzlPp_w1wdjbCwo7q0h-WsnZYvQUZ_DgJScMZnLd0Yc' : dotenv.env['SUPABASE_ANON_KEY']!,
    );
  } catch (e) {
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: SelectableText('خطأ في تهيئة Supabase. تحقق من القيم في ملف .env'),
        ),
      ),
    ));
    return;
  }

  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Gold Workshop Manager',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: _router,
      ),
    );
  }
}

