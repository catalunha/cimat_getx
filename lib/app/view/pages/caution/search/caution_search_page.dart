import 'package:cimat/app/view/controllers/caution/search/caution_search_controller.dart';
import 'package:cimat/app/view/pages/utils/app_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CautionSearchPage extends StatefulWidget {
  final _cautionSearchController = Get.find<CautionSearchController>();
  CautionSearchPage({Key? key}) : super(key: key);

  @override
  State<CautionSearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<CautionSearchPage> {
  final _formKey = GlobalKey<FormState>();
  bool _deliveryDtSelected = false;
  DateTime _deliveryDtValue = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscando Cautela'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        const Text('por Data de entrega'),
                        Row(
                          children: [
                            Checkbox(
                              value: _deliveryDtSelected,
                              onChanged: (value) {
                                setState(() {
                                  _deliveryDtSelected = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: SizedBox(
                                width: 300,
                                height: 100,
                                child: CupertinoDatePicker(
                                  initialDateTime: _deliveryDtValue,
                                  mode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: (DateTime newDate) {
                                    _deliveryDtValue = newDate;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 70)
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Executar busca',
        child: const Icon(AppIconData.search),
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            await widget._cautionSearchController.search(
              deliveryDtSelected: _deliveryDtSelected,
              deliveryDtValue: _deliveryDtValue,
            );
            // Get.back();
          }
        },
      ),
    );
  }
}
