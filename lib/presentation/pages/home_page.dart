import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/config/session.dart';
import 'package:money_record/presentation/pages/auth/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Home Page'),
          ),
          DView.spaceHeight(),
          GestureDetector(
            onTap: () {
              Session.clearUser();
              Get.off(() => const LoginPage());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Logout"),
                DView.spaceWidth(),
                Icon(Icons.logout)
              ],
            ),
          )
        ],
      ),
    );
  }
}
