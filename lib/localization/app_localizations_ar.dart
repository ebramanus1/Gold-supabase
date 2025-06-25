// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مدير ورشة الذهب';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get password => 'كلمة المرور';

  @override
  String get invalidCredentials => 'بيانات اعتماد غير صحيحة';

  @override
  String get homeScreen => 'الشاشة الرئيسية';

  @override
  String get welcomeMessage => 'مرحباً بك في مدير ورشة الذهب!';
}
