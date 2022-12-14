import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../models/pruduccion.dart';

class PdfInvoiceApi {
  static Future<Uint8List> generate(ProduccionCre invoice, DetalleMater detaVe1,
      DetalleMater detaVe2, DetalleMater2 detaVeE) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      orientation: PageOrientation.landscape,
      build: (context) => [
        // buildHeader(invoice),

        buildDetalle(invoice, detaVe1, detaVe2, detaVeE),
        Divider(),
        SizedBox(height: 0.1 * PdfPageFormat.cm),
        buildInvoice(invoice),
      ],
    ));
    return pdf.save();
  }
}

Widget buildInvoice(ProduccionCre invoice) {
  int n = 0;
  final headers = [
    'No.',
    'Alto',
    'Ancho',
    'Lateral',
    'Cab\\Riel',
    'Cab\\Alf',
    'Jambas',
    'Ancho Cris',
    'Alto Cris'
  ];
  final data = invoice.items.map((item) {
    n++;
    return [
      n ,
      toFracc(item.ancho!),
      toFracc(item.alto!),
      " 2       ${toFracc(item.laterales![0].valor)}",
      " 1       ${toFracc(item.cabezarRiel![0].valor)}",
      " 2       ${toFracc(item.cabezalArferza![0].valor!)}${item.cantidaVia != 0 && invoice.tipoVentana == "Ventanas Tradicional"? "\n 1       ${toFracc(item.cabezalArferza![0].valor2!)}" : ''}",
      " ${item.cantidaVia == 0 ? '2' : '3'}       ${toFracc(item.llavinEnganche![0].valor)}",
      " ${item.cantidaVia == 0 ? '2' : '3'}       ${toFracc(item.anchoCrital![0].valor)}",
      toFracc(item.altoCrital![0].valor),
    ];
  }).toList();

  return Table.fromTextArray(
    headers: headers,
    data: data,
    // border: null,
    headerStyle: TextStyle(fontWeight: FontWeight.bold),
    headerDecoration: const BoxDecoration(color: PdfColors.grey300),
    cellHeight: 30,
    cellAlignments: {
      0: Alignment.center,
      1: Alignment.centerLeft,
      2: Alignment.centerLeft,
      3: Alignment.centerLeft,
      4: Alignment.centerLeft,
      5: Alignment.centerLeft,
      6: Alignment.centerLeft,
      7: Alignment.centerLeft,
      8: Alignment.centerLeft,
    },

    border: TableBorder.all(color: PdfColors.grey300),
  );
}

Widget buildDetalle(ProduccionCre invoice, DetalleMater detaVe1,
    DetalleMater detaVe2, DetalleMater2 deta2) {
  return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
    Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //  crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ORDEN DE PRODUCCION',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 0.2 * PdfPageFormat.cm),
              Text(
                '${invoice.tipoVentana}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 0.8 * PdfPageFormat.cm),
              Text("Orden No. :  ${invoice.id!}"),
              Text("CLIENTE :  ${invoice.cliente!}"),
              Text("LOCALIDAD :  ${invoice.direccion!}"),
              Text("FECHA :  ${invoice.fecha!}"),
              Text("TELEFONO :  ${invoice.telefono!}"),
              SizedBox(height: 0.8 * PdfPageFormat.cm),
            ],
          ),
          Column(children: [
            SizedBox(
              height: 64,
            ),
            SizedBox(
                height: 200,
                width: 150,
                child: Table(
                  defaultColumnWidth: const IntrinsicColumnWidth(
                    flex: 1,
                  ),
                  tableWidth: TableWidth.min,
                  border: TableBorder.all(color: PdfColors.grey300),
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          child: Text(
                            'Goma',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            )
                          ),
                          padding: const EdgeInsets.all(5),
                        ),
                        Text(
                          (deta2.goma!/12).toStringAsFixed(2),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          child: Text(
                            'Rueda',
                            textAlign: TextAlign.center,
                             style: TextStyle(
                              fontWeight: FontWeight.bold
                            )
                          ),
                          padding: const EdgeInsets.all(5),
                        ),
                        Text(
                          "${deta2.rueda}",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          child: Text(
                            'Cierre',
                            textAlign: TextAlign.center,
                             style: TextStyle(
                              fontWeight: FontWeight.bold
                            )
                          ),
                          padding: const EdgeInsets.all(5),
                        ),
                        Text(
                          "${deta2.cierre}",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                )),
          ]),
          SizedBox(
              height: 150,
              width: 270,
              child: Table(
                
                defaultColumnWidth: const IntrinsicColumnWidth(
                  flex: 1,
                ),
                tableWidth: TableWidth.min,
          
                border: TableBorder.all(color: PdfColors.grey300),
                children: [
                  TableRow(
                    children: [
                      Padding(
                        child: Text(
                          'Materirales',
                          textAlign: TextAlign.center,
                           style: TextStyle(
                              fontWeight: FontWeight.bold
                            )
                        ),
                        padding: const EdgeInsets.all(5),
                      ),
                      Padding(
                        child: Text(
                          '2 Vías',
                          textAlign: TextAlign.center,
                           style: TextStyle(
                              fontWeight: FontWeight.bold
                            )
                        ),
                        padding: const EdgeInsets.all(5),
                      ),
                      Padding(
                        child: Text(
                          '3 Vías',
                          textAlign: TextAlign.center,
                           style: TextStyle(
                              fontWeight: FontWeight.bold
                            )
                        ),
                        padding: const EdgeInsets.all(5),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text("Laterales Marco"),
                      Text(" ${(detaVe1.lateraMarco/12).toStringAsFixed(2)}"),
                      Text(" ${(detaVe2.lateraMarco/12).toStringAsFixed(2)}"),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text('Cabezal Marco'),
                      Text(' ${(detaVe1.cabezaMarco/12).toStringAsFixed(2)}'),
                      Text(' ${(detaVe2.cabezaMarco/12).toStringAsFixed(2)}'),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        'Riel Marco',
                      ),
                      Text(' ${(detaVe1.rielMarco/12).toStringAsFixed(2)}'),
                      Text(' ${(detaVe2.rielMarco/12).toStringAsFixed(2)}'),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        'Cabezal Hojas',
                      ),
                      Text(' ${(detaVe1.cabeHoja/12).toStringAsFixed(2)}'),
                
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        'Alfeizal Hojas ',
                      ),
                      Text(' ${(detaVe1.alfeHoja/12).toStringAsFixed(2)}'),
            
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        'Jambas Llavín',
                      ),
                      Text(' ${(detaVe1.jambaLavin/12).toStringAsFixed(2)}'),
                
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        'Jambas Enganche',
                      ),
                      Text(' ${(detaVe1.jambaEngan/12).toStringAsFixed(2)}'),
                     
                    ],
                  )
                ],
              ))
        ])
  ]);
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
