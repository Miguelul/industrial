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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${crPruProv.creProducProv[nuPro!].fecha} \n',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 58, 52, 52), fontSize: 18),
                  ),
                  Text(
                    'Cliente: ${crPruProv.creProducProv[nuPro!].cliente} ',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 58, 52, 52), fontSize: 18),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Direccion:  ${crPruProv.creProducProv[nuPro!].direccion!}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 29, 27, 27), fontSize: 18),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  
                  Text(
                    'Tel: ${crPruProv.creProducProv[nuPro!].telefono}',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 44, 35, 35), fontSize: 18),
                  ),
              
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
