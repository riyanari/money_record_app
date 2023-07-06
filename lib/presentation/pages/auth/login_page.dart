import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/config/app_asset.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/data/source/source_user.dart';
import 'package:money_record/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  login() async {
    if (formKey.currentState!.validate()) {
      bool success =
          await SourceUser.login(emailController.text, passwordController.text);
      if (success) {
        DInfo.dialogSuccess(context, 'Berhasil Login');
        DInfo.closeDialog(context, actionAfterClose: () {
          Get.off(() => const HomePage());
        });
      } else {
        DInfo.dialogSuccess(context, 'Gagal Login');
        DInfo.closeDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DView.nothing(),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Image.asset(AppAsset.logo),
                      DView.spaceHeight(40),
                      TextFormField(
                        controller: emailController,
                        validator: (value) =>
                            value == "" ? "Email harus diisi" : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: TextStyle(color: AppColor.primary),
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: AppColor.primary,
                                    width: 1,
                                    style: BorderStyle.solid,
                                    strokeAlign: BorderSide.strokeAlignInside)),
                            hintText: "Input your email",
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16)),
                      ),
                      DView.spaceHeight(),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) =>
                            value == "" ? "Password harus diisi" : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        style: TextStyle(color: AppColor.primary),
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: AppColor.primary,
                                    width: 1,
                                    style: BorderStyle.solid,
                                    strokeAlign: BorderSide.strokeAlignInside)),
                            hintText: "Input your password",
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16)),
                      ),
                      DView.spaceHeight(30),
                      Material(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          onTap: () => login(),
                          borderRadius: BorderRadius.circular(30),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Belum punya akun? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }));
  }
}
