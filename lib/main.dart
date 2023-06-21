import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/config/session.dart';
import 'package:money_record/presentation/pages/auth/login_page.dart';
import 'package:money_record/presentation/pages/home_page.dart';

import 'data/model/user.dart';

void main() {
  // initializeDateFormatting('id_ID', null).then((value) => null);
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id_ID').then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          primaryColor: AppColor.primary,
          colorScheme: const ColorScheme.light(
              primary: AppColor.primary, secondary: AppColor.secondary),
          appBarTheme: const AppBarTheme(
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white)),
      home: FutureBuilder(
        future: Session.getUser(),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.data != null && snapshot.data!.idUser != null) {
            return const HomePage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
