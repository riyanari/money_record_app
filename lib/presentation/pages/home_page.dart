import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/config/app_asset.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/presentation/controller/c_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            child: Row(
              children: [
                Image.asset(AppAsset.profile),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hi,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Obx(() {
                        return Text(
                          cUser.data.name ?? 'Someone',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        );
                      }),
                    ],
                  ),
                ),
                Builder(builder: (ctx) {
                  return Material(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.chart,
                    child: InkWell(
                        onTap: () {
                          Scaffold.of(ctx).openEndDrawer();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.menu,
                            color: AppColor.primary,
                          ),
                        )),
                  );
                })
              ],
            ),
          ),
          Expanded(
              child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            children: [
              Text(
                'Pengeluaran Hari Ini',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              DView.spaceHeight(),
              Material(
                borderRadius: BorderRadius.circular(16),
                elevation: 4,
                color: AppColor.primary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                      child: Text('Rp 500.000,00', style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.secondary
                      ),),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 30),
                      child: Text('+20% dibanding kemarin', style: TextStyle(color: AppColor.bg, fontSize: 16),),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 0, 0, 16),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Selengkapnya',
                            style: TextStyle(color: AppColor.primary),
                          ),
                          Icon(Icons.navigate_next, color: AppColor.primary)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
