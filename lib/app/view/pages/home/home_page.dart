import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cimat/app/core/utils/allowed_access.dart';
import 'package:cimat/app/routes.dart';
import 'package:cimat/app/view/controllers/splash/splash_controller.dart';
import 'package:cimat/app/view/pages/home/parts/popmenu_user.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _splashController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            "Olá, ${_splashController.userModel!.userProfile!.nickname ?? 'Atualize seu perfil.'}.")),
        actions: [
          PopMenuButtonPhotoUser(),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              CardHome(
                title: 'Gerenciar usuários',
                access: const ['admin'],
                onAction: () {
                  Get.toNamed(Routes.userProfileSearch);
                },
                icon: Icons.people,
                color: Colors.black87,
              ),
              CardHome(
                title: 'Relatórios',
                access: const ['admin'],
                onAction: () {
                  // Get.toNamed(Routes.userProfileSearch);
                },
                icon: Icons.print_rounded,
                color: Colors.black87,
              ),
              CardHome(
                title: 'Imagens de itens',
                access: const ['patrimonio'],
                onAction: () {
                  Get.toNamed(Routes.imageSearch);
                },
                icon: Icons.image,
                color: Colors.black54,
              ),
              CardHome(
                title: 'Adicionar item',
                access: const ['patrimonio'],
                onAction: () {
                  Get.toNamed(Routes.itemAddEdit);
                },
                icon: Icons.add,
                color: Colors.black54,
              ),
              CardHome(
                title: 'Buscar item',
                access: const ['patrimonio'],
                onAction: () {
                  Get.toNamed(Routes.itemSearch);
                },
                icon: Icons.content_paste_search,
                color: Colors.black54,
              ),
              CardHome(
                title: 'Entregar item',
                access: const ['reserva'],
                onAction: () {
                  Get.toNamed(Routes.cautionDeliveryConsult);
                },
                icon: Icons.keyboard_tab,
                color: Colors.black38,
              ),
              CardHome(
                title: 'Receber item',
                access: const ['reserva'],
                onAction: () {
                  Get.toNamed(Routes.cautionGiveback);
                },
                icon: Icons.keyboard_return,
                color: Colors.black38,
              ),
              CardHome(
                title: 'Cautelas',
                access: const ['reserva'],
                onAction: () {
                  Get.toNamed(Routes.cautionSearch, arguments: false);
                },
                icon: Icons.search,
                color: Colors.black38,
              ),
              CardHome(
                title: 'Meus itens temporários',
                access: const ['operador'],
                onAction: () {
                  Get.toNamed(Routes.cautionReceiver);
                },
                icon: Icons.access_time,
                color: Colors.black26,
              ),
              CardHome(
                title: 'Meus itens permanentes',
                access: const ['operador'],
                onAction: () {
                  Get.toNamed(Routes.cautionReceiverPermanent);
                },
                icon: Icons.timelapse,
                color: Colors.black26,
              ),
              CardHome(
                title: 'Minhas cautelas',
                access: const ['operador'],
                onAction: () {
                  // Get.toNamed(Routes.cautionReceiverHistory);
                  Get.toNamed(Routes.cautionSearch, arguments: true);
                },
                icon: Icons.av_timer,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardHome extends StatelessWidget {
  final List<String> access;
  final Function() onAction;
  final String title;
  final IconData icon;
  final Color color;
  const CardHome({
    Key? key,
    required this.access,
    required this.onAction,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (AllowedAccess.consultFor(access)) {
      return InkWell(
        onTap: onAction,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: 150,
            height: 100,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color,
            ),
            child: Column(children: [
              Icon(
                icon,
                size: 50,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
              )
            ]),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
