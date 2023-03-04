import 'package:cimat/app/core/models/caution_model.dart';
import 'package:cimat/app/view/pages/caution/search/part/caution_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CautionList extends StatelessWidget {
  final List<CautionModel> cautionList;
  const CautionList({
    super.key,
    required this.cautionList,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: cautionList.length,
        itemBuilder: (context, index) {
          final caution = cautionList[index];
          return CautionCard(
            cautionModel: caution,
          );
        },
      ),
    );
  }
}
