import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          // Image.asset(
          //   AppAssets.splash,
          //   // height: 200,
          // ),
          SizedBox(
            height: 20,
          ),
          Text('Analisando seus dados...'),
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(),
        ],
      ),
    ));
  }
}
