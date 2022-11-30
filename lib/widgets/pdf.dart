import 'dart:io';
import 'dart:typed_data';

import 'package:industrial/providers/cre_produ_prov.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../models/pruduccion.dart';

class PdfInvoiceApi {
  static Future<Uint8List> generate(ProduccionCre invoice, DetalleMater detaVe2,DetalleMater detaVe) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      orientation: PageOrientation.landscape,
      build: (context) => [
        // buildHeader(invoice),
        // SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildDetalle(detaVe2, detaVe),
        Divider(),
        buildInvoice(invoice),
        
        // buildTotal(invoice),
      ],
    ));
   return pdf.save();
  }

  // static Widget buildHeader(ProduccionCre invoice) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(height: 1 * PdfPageFormat.cm),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             buildSupplierAddress(invoice.supplier),
  //             Container(
  //               height: 50,
  //               width: 50,
  //               child: BarcodeWidget(
  //                 barcode: Barcode.qrCode(),
  //                 data: invoice.info.number,
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 1 * PdfPageFormat.cm),
  //         Row(
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             buildCustomerAddress(invoice.customer),
  //             buildInvoiceInfo(invoice.info),
  //           ],
  //         ),
  //       ],
  //     );

  // static Widget buildCustomerAddress(Customer customer) => Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
  //     Text(customer.address),
  //   ],
  // );

  // static Widget buildInvoiceInfo(InvoiceInfo info) {
  //   final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
  //   final titles = <String>[
  //     'Invoice Number:',
  //     'Invoice Date:',
  //     'Payment Terms:',
  //     'Due Date:'
  //   ];
  //   final data = <String>[
  //     info.number,
  //     Utils.formatDate(info.date),
  //     paymentTerms,
  //     Utils.formatDate(info.dueDate),
  //   ];

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: List.generate(titles.length, (index) {
  //       final title = titles[index];
  //       final value = data[index];

  //       return buildText(title: title, value: value, width: 200);
  //     }),
  //   );
  // }

  // static Widget buildSupplierAddress(Supplier supplier) => Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
  //     SizedBox(height: 1 * PdfPageFormat.mm),
  //     Text(supplier.address),
  //   ],
  // );

  static Widget buildTitle(ProduccionCre invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ORDEN DE PRODUCCION',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height:  0.2 * PdfPageFormat.cm),
           Text(
            '${invoice.tipoVentana}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height:  0.8 * PdfPageFormat.cm),
          Text("Orden No. :  ${invoice.id!}"),
          Text("CLIENTE :  ${invoice.cliente!}"),
          Text("LOCALIDAD :  ${invoice.direccion!}"),
          Text("FECHA :  ${invoice.fecha!}"),
          Text("TELEFONO :  ${invoice.telefono!}"),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );
}
  Widget buildInvoice(ProduccionCre invoice) {
    final headers = [
      'Alto',
      'Ancho',
      'Lateral',
      'Cab\\Riel',
      'Cab\\Alf',
      'Jambas',
      'Ancho',
      'Alto'

    ];
    final data = invoice.items.map((item) {

      return [
        toFracc(item.ancho!),
        toFracc(item.alto!),
        toFracc(item.laterales![0].valor),
        toFracc(item.cabezarRiel![0].valor),
        toFracc(item.cabezalArferza![0].valor!),
        toFracc(item.llavinEnganche![0].valor),
        toFracc(item.anchoCrital![0].valor),
        toFracc(item.altoCrital![0].valor),
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
        6: Alignment.centerRight,
        7: Alignment.centerRight,
      },
    );
  }

  Widget buildDetalle(DetalleMater detaVe2,DetalleMater detaVe) {
    final headers = [
      'Alto',
      'Ancho',
      'Lateral',
      'Cab\\Riel',
      'Cab\\Alf',
      'Jambas',
      'Ancho',
      'Alto'

    ];
    final  List data = [
        detaVe2.cabezaMarco,
        detaVe2.alfeHoja,
        detaVe2.alfeHoja,
        detaVe2.alfeHoja,
        detaVe2.alfeHoja,
        detaVe2.alfeHoja,
        detaVe2.alfeHoja,
        detaVe2.alfeHoja,
      ];
   

    return Table.fromTextArray(
      headers: headers,
      data: [data],
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
        6: Alignment.centerRight,
        7: Alignment.centerRight,
      },
    );
  }









 toFracc(double num) {
    double type = num - num.floor();

    if (type == 0) {
      return num.toInt().toString();
    } else {
      double margin = 0.028;

      Map<int, String> estandar = {
        1: "1/16",
        2: "1/8",
        3: "3/16",
        4: "1/4",
        5: "5/16",
        6: "3/8",
        7: "7/16",
        8: "1/2",
        9: "9/16",
        10: "5/8",
        11: "11/16",
        12: "3/4",
        13: "13/16",
        14: "7/8",
        15: "15/16"
      };
      double num1 = double.parse(num.toStringAsFixed(4));
      int int1 = num1.floor();
      double desimal = num1 - int1;
      double a = 1, b = 1, aux = 1, e = 0, q = 0;
      int d = 0;

      while (!(aux == desimal) && d != 50) {
        aux = a / b;
        e = a;
        q = b;
        if (aux != desimal) {
          if (aux < desimal) {
            a++;
          } else if (aux > desimal) {
            a--;
            b++;
          }
        }
        d++;
        aux = double.parse(aux.toStringAsFixed(4));
        desimal = double.parse(desimal.toStringAsFixed(4));
      }

      double doubl1 = 0, doubl2 = 0, toDouble = 0;

      int index = 1;
      double aproxima = 1;

      while ((!(index == 16) && !(aproxima == 0)) &&
          (!(aproxima >= 0.0001 && aproxima <= margin) &&
              !(aproxima <= -0.00001 && aproxima >= -margin))) {
        if (estandar[index].toString().length == 3) {
          doubl1 = double.parse(estandar[index]!.substring(0, 1));
          doubl2 = double.parse(estandar[index]!.substring(2, 3));
          toDouble = doubl1 / doubl2;
        } else if (estandar[index]!.toString().length == 4) {
          doubl1 = double.parse(estandar[index]!.substring(0, 1));
          doubl2 = double.parse(estandar[index]!.substring(2, 4));
          toDouble = doubl1 / doubl2;
        } else if (estandar[index]!.toString().length == 5) {
          doubl1 = double.parse(estandar[index]!.substring(0, 2));
          doubl2 = double.parse(estandar[index]!.substring(3, 5));
          toDouble = doubl1 / doubl2;
        }
        double resu = e / q;
        resu = double.parse(resu.toStringAsFixed(4));
        aproxima = toDouble - resu;
        aproxima = double.parse(aproxima.toStringAsFixed(4));

        index++;
      }
      return ('$int1 ${estandar[index - 1]}');
    }
  }

  // static Widget buildTotal(Invoice invoice) {
  //   final netTotal = invoice.items
  //       .map((item) => item.unitPrice * item.quantity)
  //       .reduce((item1, item2) => item1 + item2);
  //   final vatPercent = invoice.items.first.vat;
  //   final vat = netTotal * vatPercent;
  //   final total = netTotal + vat;

  //   return Container(
  //     alignment: Alignment.centerRight,
  //     child: Row(
  //       children: [
  //         Spacer(flex: 6),
  //         Expanded(
  //           flex: 4,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               buildText(
  //                 title: 'Net total',
  //                 value: Utils.formatPrice(netTotal),
  //                 unite: true,
  //               ),
  //               buildText(
  //                 title: 'Vat ${vatPercent * 100} %',
  //                 value: Utils.formatPrice(vat),
  //                 unite: true,
  //               ),
  //               Divider(),
  //               buildText(
  //                 title: 'Total amount due',
  //                 titleStyle: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //                 value: Utils.formatPrice(total),
  //                 unite: true,
  //               ),
  //               SizedBox(height: 2 * PdfPageFormat.mm),
  //               Container(height: 1, color: PdfColors.grey400),
  //               SizedBox(height: 0.5 * PdfPageFormat.mm),
  //               Container(height: 1, color: PdfColors.grey400),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // // static Widget buildFooter(Invoice invoice) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Divider(),
  //         SizedBox(height: 2 * PdfPageFormat.mm),
  //         buildSimpleText(title: 'Address', value: invoice.supplier.address),
  //         SizedBox(height: 1 * PdfPageFormat.mm),
  //         buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
  //       ],
  //     );

  // // static buildSimpleText({
  //   required String title,
  //   required String value,
  // }) {
  //   final style = TextStyle(fontWeight: FontWeight.bold);

  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     crossAxisAlignment: pw.CrossAxisAlignment.end,
  //     children: [
  //       Text(title, style: style),
  //       SizedBox(width: 2 * PdfPageFormat.mm),
  //       Text(value),
  //     ],
  //   );
  // }

  // // static buildText({
  //   required String title,
  //   required String value,
  //   double width = double.infinity,
  //   TextStyle? titleStyle,
  //   bool unite = false,
  // }) {
  //   final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

  //   return Container(
  //     width: width,
  //     child: Row(
  //       children: [
  //         Expanded(child: Text(title, style: style)),
  //         Text(value, style: unite ? style : null),
  //       ],
  //     ),
  //   );
  // }
