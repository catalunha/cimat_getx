import 'package:cimat/app/core/models/item_model.dart';
import 'package:cimat/app/view/pages/item/search/part/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemList extends StatelessWidget {
  final List<ItemModel> itemList;
  const ItemList({
    super.key,
    required this.itemList,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          final person = itemList[index];
          return ItemCard(
            itemModel: person,
          );
        },
      ),
    );
  }
}
