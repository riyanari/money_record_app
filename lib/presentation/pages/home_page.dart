import 'package:d_chart/d_chart.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record/config/app_asset.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/config/session.dart';
import 'package:money_record/presentation/controller/c_user.dart';
import 'package:money_record/presentation/pages/auth/login_page.dart';

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
      endDrawer: drawer(),
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
              cardToday(context),
              DView.spaceHeight(30),
              Center(
                child: Container(
                  height: 5,
                  width: 80,
                  decoration: BoxDecoration(
                      color: AppColor.primary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              DView.spaceHeight(30),
              Text(
                'Pengeluaran Minggu Ini',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              DView.spaceHeight(),
              barWeek(),
              DView.spaceHeight(30),
              Text(
                'Pengeluaran Bulan Ini',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              chartMont()
            ],
          )),
        ],
      ),
    );
  }

  Material cardToday(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 4,
      color: AppColor.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
            child: Text(
              'Rp 500.000,00',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColor.secondary),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: Text(
              '+20% dibanding kemarin',
              style: TextStyle(color: AppColor.bg, fontSize: 16),
            ),
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
    );
  }

  AspectRatio barWeek() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DChartBar(
        data: const [
          {
            'id': 'Bar',
            'data': [
              {'domain': 'Sen', 'measure': 2},
              {'domain': 'Sel', 'measure': 2},
              {'domain': 'Rab', 'measure': 2},
              {'domain': 'Kam', 'measure': 4},
              {'domain': 'Jum', 'measure': 6},
              {'domain': 'Sab', 'measure': 0.3},
              {'domain': 'Min', 'measure': 0.3},
            ],
          },
        ],
        domainLabelPaddingToAxisLine: 16,
        axisLineTick: 2,
        axisLinePointTick: 2,
        axisLinePointWidth: 10,
        axisLineColor: AppColor.primary,
        measureLabelPaddingToAxisLine: 16,
        barColor: (barData, index, id) => AppColor.primary,
        showBarValue: true,
      ),
    );
  }

  chartMont() {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          child: Stack(
            children: [
              DChartPie(
                data: const [
                  {'domain': 'Flutter', 'measure': 60},
                  {'domain': 'React Native', 'measure': 40},
                ],
                fillColor: (pieData, index) => AppColor.primary,
                donutWidth: 30,
                labelColor: Colors.white,
              ),
              Center(
                  child: Text(
                "60%",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: AppColor.primary),
              ))
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 16,
                  width: 16,
                  color: AppColor.primary,
                ),
                DView.spaceWidth(8),
                const Text("Pemasukan"),
              ],
            ),
            DView.spaceHeight(8),
            Row(
              children: [
                Container(
                  height: 16,
                  width: 16,
                  color: AppColor.secondary,
                ),
                DView.spaceWidth(8),
                const Text("Pengeluaran"),
              ],
            ),
            DView.spaceHeight(20),
            const Text("Pemasukan"),
            const Text("lebih besar 20%"),
            const Text("dari pengeluaran"),
            DView.spaceHeight(10),
            const Text("Atau Setara:"),
            const Text(
              "Rp. 20.000,00",
              style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  Drawer drawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            margin: const EdgeInsets.only(bottom: 0),
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(AppAsset.profile),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Text(
                              cUser.data.name ?? 'Someone',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            );
                          }),
                          Obx(() {
                            return Text(
                              cUser.data.email ?? 'someone@gmail.com',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 16),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
                Material(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      Session.clearUser();
                      Get.off(() => const LoginPage());
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.add),
            horizontalTitleGap: 0,
            title: const Text('Tambah Baru'),
            trailing: const Icon(Icons.navigate_next),
          ),
          const Divider(height: 1,),
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.south_west),
            horizontalTitleGap: 0,
            title: const Text('Pemasukan'),
            trailing: const Icon(Icons.navigate_next),
          ),
          const Divider(height: 1,),
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.north_east),
            horizontalTitleGap: 0,
            title: const Text('Pengeluaran'),
            trailing: const Icon(Icons.navigate_next),
          ),
          const Divider(height: 1,),
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.history),
            horizontalTitleGap: 0,
            title: const Text('Riwayat'),
            trailing: const Icon(Icons.navigate_next),
          ),
          const Divider(height: 1,),
        ],
      ),
    );
  }
}
