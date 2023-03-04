import 'package:cimat/app/routes.dart';
import 'package:cimat/app/view/controllers/home/home_controller.dart';
import 'package:cimat/app/view/controllers/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopMenuButtonPhotoUser extends StatelessWidget {
  final HomeController _homeController = Get.find();
  final SplashController _splashController = Get.find();

  PopMenuButtonPhotoUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset.fromDirection(120.0, 100.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Editar perfil'),
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.userProfileEdit);
              },
              icon: const Icon(Icons.person_outline_outlined),
            ),
          ),
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Sair'),
              onPressed: () {
                _homeController.logout();
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ),
        ];
      },
      child: Obx(
        () => Tooltip(
          message: 'Click para opções',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: _splashController.userModel?.userProfile?.photo != null
                ? Image.network(
                    _splashController.userModel!.userProfile!.photo!,
                    height: 30,
                    width: 30,
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.person,
                        // color: Colors.black,
                      );
                    },
                  )
                : const Align(
                    alignment: Alignment.center,
                    child: Text(
                      ':-) ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
