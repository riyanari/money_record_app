import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

import '../../../config/app_color.dart';

class AddHistoryPage extends StatelessWidget {
  const AddHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft("Tambah Baru"),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Tanggal",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const Text("2022-01-01"),
              DView.spaceWidth(),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.event),
                  label: const Text("Pilih"))
            ],
          ),
          DView.spaceHeight(),
          const Text(
            "Tipe",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DView.spaceHeight(8),
          DropdownButtonFormField(
            value: 'Pemasukan',
            items: ['Pemasukan', 'Pengeluaran'].map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (value) {},
            decoration: const InputDecoration(
                border: OutlineInputBorder(), isDense: true),
          ),
          DView.spaceHeight(),
          DInput(
            controller: TextEditingController(),
            hint: 'Gaji',
            title: "Sumber/objek pengeluaran",
          ),
          DView.spaceHeight(),
          DInput(
            controller: TextEditingController(),
            hint: '5000000',
            title: "Jumlah Rp. ",
            inputType: TextInputType.number,
          ),
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
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DView.spaceHeight(8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey)),
            child: Wrap(
              children: [
                Chip(
                  label: const Text('Sumber'),
                  deleteIcon: const Icon(Icons.clear),
                  onDeleted: () {},
                ),
                Chip(
                  label: const Text('Sumber'),
                  deleteIcon: const Icon(Icons.clear),
                  onDeleted: () {},
                ),
                Chip(
                  label: const Text('Sumber'),
                  deleteIcon: const Icon(Icons.clear),
                  onDeleted: () {},
                ),
                Chip(
                  label: const Text('Sumber'),
                  deleteIcon: const Icon(Icons.clear),
                  onDeleted: () {},
                ),
              ],
            ),
          ),
          DView.spaceHeight(),
          Row(
            children: [
              const Text(
                "Total: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              DView.spaceWidth(),
              Text(
                "Rp 5.000.000,00",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.primary),
              )
            ],
          ),
          DView.spaceHeight(50),
          Material(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Center(
                  child: Text(
                    'SUBMIT',
                    style: Theme.of(context)
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
