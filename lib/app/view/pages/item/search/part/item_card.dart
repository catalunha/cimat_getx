import 'package:cimat/app/core/models/item_model.dart';
import 'package:cimat/app/routes.dart';
import 'package:cimat/app/view/pages/utils/app_photo_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ItemCard extends StatelessWidget {
  final ItemModel itemModel;
  const ItemCard({Key? key, required this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          AppImageShow(
            photoUrl: itemModel.image?.url,
            width: 300,
            height: 100,
          ),
          // AppTextTitleValue(
          //   title: 'Id: ',
          //   value: itemModel.id,
          // ),
          Text(
            '${itemModel.description}',
            style: const TextStyle(fontSize: 22),
          ),
          Text(
            '${itemModel.serie} - ${itemModel.lote}',
            style: const TextStyle(fontSize: 22),
          ),
          // AppTextTitleValue(
          //   title: 'Descrição: ',
          //   value: itemModel.description,
          // ),
          Wrap(
            children: [
              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.itemAddEdit, arguments: itemModel);
                },
                icon: const Icon(
                  Icons.edit,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.toNamed(
                    Routes.itemView,
                    arguments: itemModel,
                  );
                },
                icon: const Icon(
                  Icons.assignment_ind_outlined,
                ),
              ),
              // IconButton(
              //   onPressed: () => copy(itemModel.id!),
              //   icon: const Icon(
              //     Icons.copy,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  copy(String text) async {
    Get.snackbar(text, 'Id copiado.',
        margin: const EdgeInsets.all(10), duration: const Duration(seconds: 1));
    await Clipboard.setData(ClipboardData(text: text));
  }
}
