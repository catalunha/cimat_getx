import 'package:cimat/app/core/models/item_model.dart';
import 'package:cimat/app/view/controllers/item/search/item_search_controller.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:typed_data';

class ItemPrintPage extends StatelessWidget {
  final _itemModelSearchController = Get.find<ItemSearchController>();
  // var images = <String, pw.ImageProvider?>{};
  ItemPrintPage({Key? key}) : super(key: key);

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
    // await getImages();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.copyWith(
          marginTop: 1.0 * PdfPageFormat.cm,
          marginLeft: 1.0 * PdfPageFormat.cm,
          marginRight: 1.0 * PdfPageFormat.cm,
          marginBottom: 1.0 * PdfPageFormat.cm,
        ),
        orientation: pw.PageOrientation.portrait,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        footer: (pw.Context context) => footerPage(context),
        build: (pw.Context context) => <pw.Widget>[
          pw.Header(
            level: 1,
            child: pw.Text('Relatório de itens'),
          ),
          ...body(),
        ],
      ),
    );

    return await pdf.save();
  }

  body() {
    List<pw.Widget> lineList = [];
    for (var itemModel in _itemModelSearchController.itemList) {
      lineList.add(userBody(itemModel));
    }

    return lineList;
  }

  // getImages() async {
  //   for (var itemModel in _itemModelSearchController.itemList) {
  //     if (itemModel.image?.url != null) {
  //       final image = await networkImage(itemModel.image!.url!);
  //       images[itemModel.id!] = image;
  //     } else {
  //       images[itemModel.id!] = null;
  //     }
  //   }
  // }

  userBody(ItemModel itemModel) {
    final dateFormat = DateFormat('MM/y');

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(children: [
          // if (images[itemModel.id] != null)
          //   pw.Center(
          //     child: pw.Image(height: 200, width: 200, images[itemModel.id]!),
          //   ),
          pw.SizedBox(width: 10),
          pw.Expanded(
              child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Descrição: ${itemModel.description}'),
              pw.Text('Série: ${itemModel.serie}'),
              pw.Text('Lote: ${itemModel.lote}'),
              pw.Text('Marca: ${itemModel.brand}'),
              pw.Text('Modelo: ${itemModel.model}'),
              pw.Text('Calibre: ${itemModel.calibre}'),
              pw.Text('Documentação: ${itemModel.doc}'),
              pw.Text('Obs. Cautela: ${itemModel.obsCaution}'),
              pw.Text(
                  'Validade: ${itemModel.validate == null ? "..." : dateFormat.format(itemModel.validate!)}'),
              pw.Text('Grupos: ${itemModel.groups?.join(',')}'),
              pw.Text(
                  'É munição? ${itemModel.isMunition == true ? 'Sim' : 'Não'}'),
              pw.Text(
                  'Bloqueada pelo operador? ${itemModel.isBlockedOperator == true ? 'Sim' : 'Não'}'),
              pw.Text(
                  'Bloqueada pela documentação? ${itemModel.isBlockedDoc == true ? 'Sim' : 'Não'}'),
            ],
          ))
        ]),
        pw.Divider(),
      ],
    );
  }

  footerPage(context) {
    final dateFormat = DateFormat('dd/MM/y HH:mm');

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
            'cimat - ${dateFormat.format(DateTime.now())}',
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
