import 'package:cimat/app/view/controllers/caution/delivery/caution_delivery_controller.dart';
import 'package:cimat/app/view/pages/utils/app_photo_show.dart';
import 'package:cimat/app/view/pages/utils/app_text_title_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CautionDeliveryConfirmPage extends StatelessWidget {
  final _cautionDeliveryController = Get.find<CautionDeliveryController>();
  CautionDeliveryConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Cautela de item - Confirmação')),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextTitleValue(
                    title: 'Quantidade deste item: ',
                    value: _cautionDeliveryController.quantityEnd.toString(),
                  ),
                  const SizedBox(height: 15),
                  AppImageShow(
                    photoUrl: _cautionDeliveryController
                        .cautionModel!.item!.image?.url,
                    width: 300,
                    height: 100,
                  ),
                  Text(
                    '${_cautionDeliveryController.cautionModel!.item!.description}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${_cautionDeliveryController.cautionModel!.item!.serie == null || _cautionDeliveryController.cautionModel!.item!.serie!.isEmpty ? '...' : _cautionDeliveryController.cautionModel!.item!.serie} | ${_cautionDeliveryController.cautionModel!.item!.lote == null || _cautionDeliveryController.cautionModel!.item!.lote!.isEmpty ? '...' : _cautionDeliveryController.cautionModel!.item!.lote}',
                    style: const TextStyle(fontSize: 22),
                  ),
                  // AppTextTitleValue(
                  //   title: 'Grupos: ',
                  //   value: _cautionDeliveryController
                  //       .cautionModel!.item!.groups!
                  //       .join('\n'),
                  //   inColumn: true,
                  // ),

                  const Divider(height: 5),
                  const SizedBox(height: 15),
                  AppImageShow(
                    photoUrl: _cautionDeliveryController
                        .cautionModel!.receiverUserProfile!.photo,
                    height: 100,
                    width: 100,
                  ),
                  Text(
                      '${_cautionDeliveryController.cautionModel!.receiverUserProfile!.nickname}'),
                  Text(
                    '${_cautionDeliveryController.cautionModel!.receiverUserProfile!.register}',
                    style: const TextStyle(fontSize: 22),
                  ),

                  _cautionDeliveryController
                              .operatorContainRestrictionsWithItem ==
                          true
                      ? const Text(
                          'Este operador possui restrições a este item',
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox.shrink(),
                  // AppTextTitleValue(
                  //   title: 'Restrições: ',
                  //   value: _cautionDeliveryController
                  //       .cautionModel!.receiverUserProfile!.restrictions!
                  //       .join('\n'),
                  //   inColumn: true,
                  // ),
                  const SizedBox(height: 15),
                  const Divider(height: 5),
                  IconButton(
                    tooltip: 'Confirmar cautela.',
                    onPressed: () async {
                      await _cautionDeliveryController.confirmOrder();
                      // Get.back();
                      Get.back(result: true);

                      // Get.toNamed(Routes.cautionDeliverySearch,
                      //     arguments: _cautionDeliveryController.registerEnd);
                    },
                    icon: const Icon(Icons.send),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  IconButton(
                    tooltip: 'Nova item, outro operador',
                    onPressed: () async {
                      await _cautionDeliveryController.confirmOrder();
                      Get.back(result: false);
                    },
                    icon: const Icon(Icons.keyboard_tab),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
