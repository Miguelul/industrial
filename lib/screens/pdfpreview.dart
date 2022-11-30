import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:industrial/widgets/pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../models/pruduccion.dart';
import '../providers/cre_produ_prov.dart';

class PdfPreviewPage extends StatelessWidget {
  final ProduccionCre invoice;
  int? nuPro;
  PdfPreviewPage({Key? key, required this.invoice, required this.nuPro})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final crPruProv = Provider.of<CreProducProv>(context, listen: false);
    DetalleMater detalleve2 = DetalleMater(
        crPruProv.sumMateriales(nuPro!, 1),
        crPruProv.sumMateriales(nuPro!, 8),
        crPruProv.sumMateriales(nuPro!, 8),
        crPruProv.sumMateriales(nuPro!, 8),
        crPruProv.sumMateriales(nuPro!, 8),
        crPruProv.sumMateriales(nuPro!, 8),
        crPruProv.sumMateriales(nuPro!, 8),
        crPruProv.sumMateriales(nuPro!, 8),
        crPruProv.sumMateriales(nuPro!, 6),
        crPruProv.sumMateriales(nuPro!, 7));
    DetalleMater detalleve3 = DetalleMater(
        crPruProv.sumMateriales(nuPro!, 1),
        crPruProv.sumMateriales(nuPro!, 8),
        crPruProv.sumMateriales(nuPro!, 8),
        crPruProv.sumMateriales(nuPro!, 8),
        crPruProv.sumMateriales(nuPro!, 8),
        crPruProv.sumMateriales(nuPro!, 8),
        crPruProv.sumMateriales(nuPro!, 8),
        crPruProv.sumMateriales(nuPro!, 8),
        crPruProv.sumMateriales(nuPro!, 6),
        crPruProv.sumMateriales(nuPro!, 7));
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(181, 21, 22, 22) ,
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => PdfInvoiceApi.generate(invoice, detalleve2,detalleve3),
         canDebug: true,
        canChangeOrientation: false,
        canChangePageFormat: false,
        allowPrinting:true,
        allowSharing: true,
       
      ),
    );
  }
}
