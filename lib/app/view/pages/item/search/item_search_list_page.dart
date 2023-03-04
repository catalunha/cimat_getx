import 'package:cimat/app/view/controllers/item/search/item_search_controller.dart';
import 'package:cimat/app/view/pages/item/search/part/item_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cimat/app/view/pages/item/print/item_print_page.dart';

class ItemSearchListPage extends StatelessWidget {
  final _itemSearchController = Get.find<ItemSearchController>();

  ItemSearchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text('Itens: ${_itemSearchController.itemList.length}'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ItemPrintPage());
            },
            icon: const Icon(Icons.print),
          )
        ],
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              _itemSearchController.nextPage();
            },
            child: Obx(() => Container(
                  color: _itemSearchController.lastPage
                      ? Colors.black
                      : Colors.green,
                  height: 24,
                  child: Center(
                    child: _itemSearchController.lastPage
                        ? const Text('Última página')
                        : const Text('Próxima página'),
                  ),
                )),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: ItemList(
                itemList: _itemSearchController.itemList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
