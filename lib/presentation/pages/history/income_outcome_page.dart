import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_record/config/app_color.dart';
import 'package:money_record/config/app_format.dart';
import 'package:money_record/presentation/controller/c_user.dart';
import 'package:money_record/presentation/controller/history/c_income_outcome.dart';
import 'package:money_record/presentation/pages/history/update_history_page.dart';

import '../../../data/model/history.dart';

class IncomeOutcomePage extends StatefulWidget {
  final String type;

  const IncomeOutcomePage({super.key, required this.type});

  @override
  State<IncomeOutcomePage> createState() => _IncomeOutcomePageState();
}

class _IncomeOutcomePageState extends State<IncomeOutcomePage> {
  final cInOut = Get.put(CIncomeOutcome());
  final cUser = Get.put(CUser());
  final searchController = TextEditingController();

  refresh() {
    cInOut.getList(cUser.data.idUser, widget.type);
  }

  menuOption(String value, History history) {
    if (value == 'update') {
      Get.to(() => UpdateHistoryPage(date: history.date!))?.then((value) {
        if (value ?? false) {
          refresh();
        }
      });
    } else if (value == 'delete') {}
  }

  @override
  void initState() {
    // TODO: implement initState
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Row(
            children: [
              Text(widget.type),
              Expanded(
                  child: Container(
                height: 40,
                margin: const EdgeInsets.all(16),
                child: TextField(
                  controller: searchController,
                  onTap: () async {
                    DateTime? result = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022, 01, 01),
                        lastDate: DateTime(DateTime.now().year + 1));
                    if (result != null) {
                      searchController.text =
                          DateFormat('yyyy-MM-dd').format(result);
                    }
                    // DateTime? result = await showDatePicker(
                    //     context: context,
                    //     initialDate: DateTime.now(),
                    //     firstDate: DateTime(2022, 02, 02),
                    //     lastDate: DateTime(DateTime.now().year + 1));
                    //
                    // if (result != null) {
                    //   searchController.text =
                    //       DateFormat('yyyy-MM-dd').format(result);
                    // }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: AppColor.chart.withOpacity(0.5),
                      suffixIcon: IconButton(
                          onPressed: () {
                            cInOut.search(cUser.data.idUser, widget.type,
                                searchController.text);
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                      // isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 0),
                      hintText: '2023-07-11',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.5))),
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ))
            ],
          ),
        ),
        body: GetBuilder<CIncomeOutcome>(builder: (_) {
          print("list pemasukan");
          print(_.list);
          if (_.loading) return DView.loadingCircle();
          if (_.list.isEmpty) return DView.empty('Kosong');
          return RefreshIndicator(
            onRefresh: () async => refresh(),
            child: ListView.builder(
                itemCount: _.list.length,
                itemBuilder: (context, index) {
                  History history = _.list[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.fromLTRB(16, index == 0 ? 16 : 8, 16,
                        index == _.list.length - 1 ? 16 : 8),
                    child: Row(
                      children: [
                        DView.spaceWidth(),
                        Text(
                          AppFormat.date(history.date!),
                          style: const TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Expanded(
                            child: Text(
                          AppFormat.currency(history.total!),
                          style: const TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.end,
                        )),
                        PopupMenuButton<String>(
                            itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'update',
                                    child: Text('Update'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  )
                                ],
                            onSelected: (value) => menuOption(value, history))
                      ],
                    ),
                  );
                }),
          );
        }));
  }
}
