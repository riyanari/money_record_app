import 'dart:convert';

import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_record/config/app_format.dart';
import 'package:money_record/presentation/controller/history/c_add_history.dart';

import '../../../config/app_color.dart';
import '../../../data/source/source_history.dart';
import '../../controller/c_user.dart';

class AddHistoryPage extends StatelessWidget {
  AddHistoryPage({super.key});

  final cUser = Get.put(CUser());
  final cAddHistory = Get.put(CAddHistory());
  final objectController = TextEditingController();
  final priceController = TextEditingController();

  addHistory() async {
    bool success = await SourceHistory.add(
        cUser.data.idUser!,
        cAddHistory.date,
        cAddHistory.type,
        jsonEncode(cAddHistory.items),
        cAddHistory.total.toString());

    if (success) {
      Future.delayed(const Duration(milliseconds: 3000), () {
        Get.back(result: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft("Tambah Baru"),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Tanggal",
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.textPrimary),
          ),
          Row(
            children: [
              Obx(() {
                return Text(cAddHistory.date, style: const TextStyle(color: AppColor.textPrimary),);
              }),
              DView.spaceWidth(),
              ElevatedButton.icon(
                  onPressed: () async {
                    DateTime? result = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022, 01, 01),
                        lastDate: DateTime(DateTime
                            .now()
                            .year + 1));
                    if (result != null) {
                      cAddHistory
                          .setDate(DateFormat('yyyy-MM-dd').format(result));
                    }
                  },
                  icon: const Icon(Icons.event),
                  label: const Text("Pilih"))
            ],
          ),
          DView.spaceHeight(),
          const Text(
            "Tipe",
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.textPrimary),
          ),
          DView.spaceHeight(8),
          Obx(() {
            return DropdownButtonFormField(
              value: cAddHistory.type, style: const TextStyle(color: AppColor.textPrimary, fontSize: 16),
              items: ['Pemasukan', 'Pengeluaran'].map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                cAddHistory.setType(value);
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), isDense: true),
            );
          }),
          DView.spaceHeight(),
          DInput(
            controller: objectController,
            hint: 'Gaji',
            title: "Sumber/objek pengeluaran",
            style: TextStyle(color: AppColor.textPrimary),
          ),
          DView.spaceHeight(),
          DInput(
            controller: priceController,
            hint: '5000000',
            title: "Jumlah Rp. ",
            inputType: TextInputType.number,
            style: TextStyle(color: AppColor.textPrimary),
          ),
          DView.spaceHeight(),
          ElevatedButton(
              onPressed: () {
                cAddHistory.addItem({
                  "object": objectController.text,
                  "price": priceController.text
                });
                objectController.clear();
                priceController.clear();
              }, child: const Text('Tambah ke items')),
          DView.spaceHeight(),
          Center(
            child: Container(
              height: 5,
              width: 80,
              decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          DView.spaceHeight(),
          const Text(
            "Items",
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.textPrimary),
          ),
          DView.spaceHeight(8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey)),
            child: GetBuilder<CAddHistory>(
                builder: (_) {
                  return Wrap(
                    // runSpacing: 8,
                      spacing: 8,
                      children: List.generate(_.items.length, (index) {
                        return Chip(
                          label: Text(_.items[index]['object']),
                          deleteIcon: const Icon(Icons.clear),
                          onDeleted: () => _.deleteItem(index),
                        );
                      })
                  );
                }
            ),
          ),
          DView.spaceHeight(),
          Row(
            children: [
              const Text(
                "Total: ",
                style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.textPrimary),
              ),
              DView.spaceWidth(),
              Obx(() {
                return Text(
                  AppFormat.currency(cAddHistory.total.toString()),
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(
                      fontWeight: FontWeight.bold, color: AppColor.primary),
                );
              }
              )
            ],
          ),
          DView.spaceHeight(30),
          Material(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () => addHistory(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: Center(
                  child: Text(
                    'SUBMIT',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: AppColor.bg),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
