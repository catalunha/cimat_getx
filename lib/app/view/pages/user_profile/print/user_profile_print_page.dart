import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:cimat/app/core/models/user_profile_model.dart';
import 'package:cimat/app/view/controllers/user_profile/search/user_profile_search_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:get/get.dart';

class UserProfilePrintPage extends StatelessWidget {
  final _userProfileSearchController = Get.find<UserProfileSearchController>();
  var images = <String, pw.ImageProvider?>{};
  UserProfilePrintPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatório'),
      ),
      body: PdfPreview(
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        pdfFileName: 'relatorio',
        build: (format) => makePdf(),
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    await getImages();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginTop: 1.0 * PdfPageFormat.cm,
          marginLeft: 1.0 * PdfPageFormat.cm,
          marginRight: 1.0 * PdfPageFormat.cm,
          marginBottom: 1.0 * PdfPageFormat.cm,
        ),
        footer: (pw.Context context) => footerPage(context),
        build: (pw.Context context) => <pw.Widget>[
          pw.Header(
            level: 1,
            child: pw.Text('Relatório de usuários'),
          ),
          ...body(),
        ],
      ),
    );

    return await pdf.save();
  }

  body() {
    List<pw.Widget> lineList = [];
    for (var userProfile in _userProfileSearchController.userProfileList) {
      lineList.add(userBody(userProfile));
    }

    return lineList;
  }

  getImages() async {
    for (var userProfile in _userProfileSearchController.userProfileList) {
      if (userProfile.photo != null) {
        final image = await networkImage(userProfile.photo!);
        //     final image =
        // await flutterImageProvider(NetworkImage(userProfile.photo ?? ''));
        images[userProfile.id] = image;
      } else {
        images[userProfile.id] = null;
      }
    }
  }

  userBody(UserProfileModel userProfile) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(children: [
          if (images[userProfile.id] != null)
            pw.Center(
              child: pw.Image(height: 100, width: 100, images[userProfile.id]!),
            ),
          pw.SizedBox(width: 10),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text('E-mail: ${userProfile.email}'),
            pw.Text('Nome em tropa: ${userProfile.nickname}'),
            pw.Text('Nome completo: ${userProfile.name}'),
            pw.Text('CPF: ${userProfile.cpf}'),
            pw.Text('Registro: ${userProfile.register}'),
            pw.Text('Telefone: ${userProfile.phone}'),
            pw.Text('Acessos: ${userProfile.routes?.join(',')}'),
            pw.Text('Restrições: ${userProfile.restrictions?.join(',')}'),
            pw.Text(
                'Esta ativo? ${userProfile.isActive == true ? 'Sim' : 'Não'}'),
          ])
        ]),
        pw.Divider(),
      ],
    );
  }

  footerPage(context) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
      decoration: const pw.BoxDecoration(
          border: pw.Border(
              top: pw.BorderSide(width: 1.0, color: PdfColors.black))),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'cimat - ${DateTime.now()}',
            style: const pw.TextStyle(fontSize: 10),
          ),
          pw.Text(
            'Pág.: ${context.pageNumber} de ${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
