import 'package:flutter/material.dart';
import 'package:industrial/widgets/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../models/pruduccion.dart';
import '../providers/cre_produ_prov.dart';

// ignore: must_be_immutable
class PdfPreviewPage extends StatelessWidget {
  final ProduccionCre invoice;
  int? nuPro;
  PdfPreviewPage({Key? key, required this.invoice, required this.nuPro})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crPruProv = Provider.of<CreProducProv>(context, listen: false);
    DetalleMater detalleve2 = DetalleMater(
      crPruProv.sumMateriales(nuPro!, 1),
      crPruProv.sumMateriales(nuPro!, 2),
      crPruProv.sumMateriales(nuPro!, 2),
      crPruProv.sumMateriales(nuPro!, 3),
      crPruProv.sumMateriales(nuPro!, 3),
      crPruProv.sumMateriales(nuPro!, 4),
      crPruProv.sumMateriales(nuPro!, 4),
    );

    DetalleMater detalleve3 = DetalleMater(
      crPruProv.sumMateriales(nuPro!, 8),
      crPruProv.sumMateriales(nuPro!, 9),
      crPruProv.sumMateriales(nuPro!, 9),
      crPruProv.sumMateriales(nuPro!, 10),
      crPruProv.sumMateriales(nuPro!, 10),
      crPruProv.sumMateriales(nuPro!, 11),
      crPruProv.sumMateriales(nuPro!, 12),
    );
   DetalleMater2 detalleE= DetalleMater2(
      crPruProv.sumMateriales(nuPro!, 5),
      crPruProv.sumMateriales(nuPro!, 6),
      crPruProv.sumMateriales(nuPro!, 7),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(171, 110, 107, 107),
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) =>
            PdfInvoiceApi.generate(invoice, detalleve2, detalleve3,detalleE ),
        canDebug: true,
        canChangeOrientation: false,
        canChangePageFormat: false,
        allowPrinting: true,
        allowSharing: true,
      ),
    );
  }
}
