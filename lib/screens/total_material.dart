import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/cre_produ_prov.dart';

class TotalMaterial extends StatelessWidget {
  int? nuPro;

  TotalMaterial({this.nuPro, super.key});

  @override
  Widget build(BuildContext context) {
    final crPruProv = Provider.of<CreProducProv>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Color.fromARGB(31, 10, 10, 10),
        ),
        title: const Center(
          child: Text(
            'Detalles de Materiales',
            style: TextStyle(
                fontWeight: FontWeight.w100,
                color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detalle General de la Produción',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(221, 92, 87, 87)),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${crPruProv.creProducProv[nuPro!].fecha}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 58, 52, 52), fontSize: 15),
                    ),
                    Text(
                      'Cliente: ${crPruProv.creProducProv[nuPro!].cliente} ',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 58, 52, 52), fontSize: 15),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Direccion:  ${crPruProv.creProducProv[nuPro!].direccion!}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 29, 27, 27), fontSize: 15),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Tel: ${crPruProv.creProducProv[nuPro!].telefono}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 44, 35, 35), fontSize: 15),
                    ),
                     Text(
                      '${crPruProv.creProducProv[nuPro!].tipoVentana}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 44, 35, 35), fontSize: 15),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 20),

              Stack(alignment: Alignment.topCenter, children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 238, 238, 238),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DataTable(
                        // horizontalMargin: 3,

                        columns: const <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Materiales',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Cantidad',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Role',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],

                        rows: <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Laterales Marco')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 1)}')),
                              const DataCell(Text('Student')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Cabezal Marco')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 2)}')),
                              DataCell(Text('Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Riel Marco')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 2)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Cabezal Hojas')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 3)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Alfeizal Hojas')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 3)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Jambas Llavín')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 4)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Jambas Enganche')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 4)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Cierre Central')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 5)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Rueda')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 6)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Goma')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 7)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //  ),
                Positioned(
                  bottom: 495,
                  child: ClipPath(
                    clipper: MyCustomClipper(),
                    child: Container(
                      width: 170,
                      height: 100,
                      color: const Color.fromARGB(255, 238, 238, 238),
                      child: const Center(
                          child: Text(
                        '2 vias    ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ]),
           const SizedBox(height: 30),
              Stack(alignment: Alignment.topCenter, children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, top: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 238, 238, 238),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: DataTable(
                        // horizontalMargin: 3,

                        columns: const <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Materiales',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Cantidad',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Role',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],

                        rows: <DataRow>[
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Laterales Marco')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 1)}')),
                              const DataCell(Text('Student')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Cabezal Marco')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 2)}')),
                              DataCell(Text('Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Riel Marco')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 2)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Cabezal Hojas')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 3)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Alfeizal Hojas')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 3)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Jambas Llavín')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 4)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Jambas Enganche')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 4)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Cierre Central')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 5)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Rueda')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 6)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                          DataRow(
                            cells: <DataCell>[
                              const DataCell(Text('Goma')),
                              DataCell(Text(
                                  '${crPruProv.sumMateriales(nuPro!, 7)}')),
                              DataCell(Text('Associate Professor')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //  ),
                Positioned(
                  bottom: 495,
                  child: ClipPath(
                    clipper: MyCustomClipper(),
                    child: Container(
                      width: 170,
                      height: 100,
                      color: const Color.fromARGB(255, 238, 238, 238),
                      child: const Center(
                          child: Text(
                        '3 vias    ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '\nDetalles 2 Vias',
                    style: TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    '\nLaterales Marco: ${crPruProv.sumMateriales(nuPro!, 1)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Cabezal Marco: ${crPruProv.sumMateriales(nuPro!, 2)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Riel Marco : ${crPruProv.sumMateriales(nuPro!, 2)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Cabezal Hojas: ${crPruProv.sumMateriales(nuPro!, 3)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Alfeizal Hojas: ${crPruProv.sumMateriales(nuPro!, 3)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Jambas Llavín : ${crPruProv.sumMateriales(nuPro!, 4)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Jambas Enganche : ${crPruProv.sumMateriales(nuPro!, 4)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Cierre Central: ${crPruProv.sumMateriales(nuPro!, 5)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Rueda: ${crPruProv.sumMateriales(nuPro!, 6)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Goma: ${crPruProv.sumMateriales(nuPro!, 7)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '\nDetalles 3 Vias',
                    style: TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    '\nLaterales Marco: ${crPruProv.sumMateriales(nuPro!, 8)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Cabezal Marco: ${crPruProv.sumMateriales(nuPro!, 9)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Riel Marco : ${crPruProv.sumMateriales(nuPro!, 9)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Cabezal Hojas: ${crPruProv.sumMateriales(nuPro!, 10)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Alfeizal Hojas: ${crPruProv.sumMateriales(nuPro!, 10)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Jambas Llavín : ${crPruProv.sumMateriales(nuPro!, 11)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Jambas Enganche : ${crPruProv.sumMateriales(nuPro!, 11)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Cierre Central: ${crPruProv.sumMateriales(nuPro!, 12)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Rueda: ${crPruProv.sumMateriales(nuPro!, 13)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                  Text(
                    'Goma: ${crPruProv.sumMateriales(nuPro!, 14)}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.2489125, size.height * 0.4004200);
    path0.cubicTo(
        size.width * 0.3562000,
        size.height * 0.3996600,
        size.width * 0.5374500,
        size.height * 0.3971600,
        size.width * 0.6236250,
        size.height * 0.3967400);
    path0.cubicTo(
        size.width * 0.7343250,
        size.height * 0.3966200,
        size.width * 0.6638625,
        size.height * 0.5744000,
        size.width * 0.7476875,
        size.height * 0.5983000);
    path0.cubicTo(
        size.width * 0.6223625,
        size.height * 0.5993000,
        size.width * 0.2463875,
        size.height * 0.6008000,
        size.width * 0.1251250,
        size.height * 0.6003000);
    path0.cubicTo(
        size.width * 0.2126375,
        size.height * 0.5773200,
        size.width * 0.1373250,
        size.height * 0.4023200,
        size.width * 0.2489125,
        size.height * 0.4004200);
    path0.close();
    return path0;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.2489125, size.height * 0.4004200);
    path0.cubicTo(
        size.width * 0.3562000,
        size.height * 0.3996600,
        size.width * 0.5374500,
        size.height * 0.3971600,
        size.width * 0.6236250,
        size.height * 0.3967400);
    path0.cubicTo(
        size.width * 0.7343250,
        size.height * 0.3966200,
        size.width * 0.6638625,
        size.height * 0.5744000,
        size.width * 0.7476875,
        size.height * 0.5983000);
    path0.cubicTo(
        size.width * 0.6223625,
        size.height * 0.5993000,
        size.width * 0.2463875,
        size.height * 0.6008000,
        size.width * 0.1251250,
        size.height * 0.6003000);
    path0.cubicTo(
        size.width * 0.2126375,
        size.height * 0.5773200,
        size.width * 0.1373250,
        size.height * 0.4023200,
        size.width * 0.2489125,
        size.height * 0.4004200);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
