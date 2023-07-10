import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/presentation/pages/auth/login_page.dart';

import '../../../config/app_asset.dart';
import '../../../config/app_color.dart';
import '../../../data/source/source_user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  register() async {
    if (formKey.currentState!.validate()) {
      // bool success =
      await SourceUser.register(nameController.text, emailController.text, passwordController.text);
      // if (success) {
      //   DInfo.dialogSuccess('Berhasil Login');
      //   DInfo.closeDialog(actionAfterClose: () {
      //     Get.off(() => const HomePage());
      //   });
      // } else {
      //   DInfo.dialogSuccess('Gagal Login');
      //   DInfo.closeDialog();
      // }
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
                        controller: nameController,
                        validator: (value) =>
                        value == "" ? "Nama harus diisi" : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: AppColor.primary),
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
                            hintText: "Input your name",
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16)),
                      ),
                      DView.spaceHeight(),
                      TextFormField(
                        controller: emailController,
                        validator: (value) =>
                        value == "" ? "Email harus diisi" : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: AppColor.primary),
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
                          onTap: () => register(),
                          borderRadius: BorderRadius.circular(30),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 16),
                            child: Text(
                              "Register",
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
                      "Sudah punya akun? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginPage());
                      },
                      child: const Text(
                        "Login",
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
