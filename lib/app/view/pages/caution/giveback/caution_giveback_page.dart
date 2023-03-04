import 'package:cimat/app/view/controllers/caution/giveback/caution_giveback_controller.dart';
import 'package:cimat/app/view/pages/caution/giveback/caution_giveback_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CautionGivebackPage extends StatefulWidget {
  final _cautionGivebackController = Get.find<CautionGivebackController>();

  CautionGivebackPage({super.key});

  @override
  State<CautionGivebackPage> createState() => _CautionGivebackPageState();
}

class _CautionGivebackPageState extends State<CautionGivebackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              'Itens em devolução: ${widget._cautionGivebackController.cautionList.length}'),
        ),
      ),
      body: FutureBuilder(
          future: widget._cautionGivebackController.getCurrentCautions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              // UserProfileModel userProfileModel = snapshot.data!;

              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 600,
                        child: Obx(
                          () => ListView.builder(
                            itemCount: widget
                                ._cautionGivebackController.cautionList.length,
                            itemBuilder: (context, index) {
                              final cautionModel = widget
                                  ._cautionGivebackController
                                  .cautionList[index];
                              return CautionGivebackCard(
                                cautionModel: cautionModel,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),

      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         height: 600,
      //         child: Obx(
      //           () => ListView.builder(
      //             itemCount:
      //                 widget._cautionGivebackController.cautionList.length,
      //             itemBuilder: (context, index) {
      //               final cautionModel =
      //                   widget._cautionGivebackController.cautionList[index];
      //               return CautionGivebackCard(
      //                 cautionModel: cautionModel,
      //               );
      //             },
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
