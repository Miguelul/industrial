import 'dart:collection';

import 'package:flutter/cupertino.dart';

import 'package:industrial/models/pruduccion.dart';
import 'package:industrial/providers/db_provider.dart';

class CreProducProv extends ChangeNotifier {
  List<ProduccionCre> creProTem = [];
  CreProducProv({
    required this.creProTem,
  }) {
    _creProducProv.clear();

    _creProducProv.addAll(creProTem);

    notifyListeners();
  }
  final List<ProduccionCre> _creProducProv = [];
  UnmodifiableListView<ProduccionCre> get creProducProv =>
      UnmodifiableListView(_creProducProv);

  int idProdu = 0, estadoEditVen = 0;

  estadoEditVe(int estadoEdi) {
    if (estadoEdi != 0 && estadoEdi != 1) {
      return estadoEditVen;
    } else {
      return estadoEditVen = estadoEdi;
    }
  }

  Ventana ventaTemp = Ventana();
  int nuVenTemk = 0;

  pushventanainta(Ventana ventanIsta, int nuVenTem) {
    
    ventaTemp = ventanIsta;
    nuVenTemk = nuVenTem;
    notifyListeners();
  }

  Future<int> init(int op) async {
    if (op == 1) {
      _creProducProv.clear();
      _creProducProv.addAll(await DBProvider.getProducc());
      notifyListeners();
    } else {
      _creProducProv.clear();
      _creProducProv.addAll(await DBProvider.getProducc());
    }
    return 1;
  }

  addProducc(ProduccionCre produccion) async {
    idProdu = await DBProvider.insertProducc(produccion);
    _creProducProv.add(ProduccionCre(
        id: idProdu,
        fecha: produccion.fecha,
        tipoVentana: produccion.tipoVentana,
        cliente: produccion.cliente,
        direccion: produccion.direccion,
        telefono: produccion.telefono,
        items: produccion.items));
  }

  coutProduc2() {
    int n = _creProducProv.length;
    return n;
  }

  sumMateriales(int nuPro, int totalDe) {
    double totalf = 0;
    double n = 0, i = 0;
    Map<int, double> total = {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
      10: 0,
      11: 0,
      12: 0,
      13: 0,
      14: 0,
      15: 0
    };
    for (int index = 0; index < creProducProv[nuPro].items.length; index++) {
      if (creProducProv[nuPro].items[index].cantidaVia == 0) {
        n++;
        total[1] = total[1]! +
            creProducProv[nuPro].items[index].laterales![0].valor * 2;
        total[2] =
            total[2]! + creProducProv[nuPro].items[index].cabezarRiel![0].valor;
        total[3] = total[3]! +
            creProducProv[nuPro].items[index].cabezalArferza![0].valor! * 2;
        total[4] = total[4]! +
            creProducProv[nuPro].items[index].llavinEnganche![0].valor * 2;
        total[5] = total[5]! + n;
        total[6] = total[6]! + n * 4;

        total[7] = total[7]! +
            (creProducProv[nuPro].items[n.toInt() - 1].anchoCrital![0].valor +
                    creProducProv[nuPro]
                        .items[n.toInt() - 1]
                        .altoCrital![0]
                        .valor) *
                4;
        totalf = total[totalDe]!;
      } else {
        i++;
        total[8] = total[8]! +
            creProducProv[nuPro].items[index].laterales![0].valor * 2;
        total[9] =
            total[9]! + creProducProv[nuPro].items[index].cabezarRiel![0].valor;
        total[10] = total[10]! +
            creProducProv[nuPro].items[index].cabezalArferza![0].valor! * 3;
        total[11] = total[11]! +
            creProducProv[nuPro].items[index].llavinEnganche![0].valor * 2;
        total[12] = total[12]! +
            creProducProv[nuPro].items[index].llavinEnganche![0].valor * 4;
        total[5] = total[5]! + (i * 2);
        total[6] = total[6]! + i * 6;

        total[7] = total[7]! +
            (creProducProv[nuPro].items[i.toInt() - 1].anchoCrital![0].valor +
                    creProducProv[nuPro]
                        .items[i.toInt() - 1]
                        .altoCrital![0]
                        .valor) *
                6;
        totalf = total[totalDe]!;
      }
    }

    return double.parse(totalf.toStringAsFixed(2));
  }

  toFullPi(double value) {
    return value = value / 21;
  }

  deleteProducc(int index, int idPro) async {
    _creProducProv.removeWhere((item) => item.id == idPro);
    notifyListeners();
    await DBProvider.deleteProducc(idPro);
  }

  deleteVentana(int idPr, int idVe) async {
    _creProducProv[idPr].items.removeWhere((item) => item.idVentana == idVe);
    notifyListeners();
    await DBProvider.deleteVentana(idVe);
  }

  updateVentana(Ventana ventana, String tipoVeta, int nuPro, int nuVen) async {
    Ventana ventaTem = Ventana(
      idVentana: ventana.idVentana,
      cantidaVia: ventana.cantidaVia,
      idProduccion: ventana.idProduccion,
      ancho: ventana.ancho,
      alto: ventana.alto,
    );

    if (tipoVeta == "Ventanas Tradicional") {
      ventana = degloTradi(
          ventana.ancho!, ventana.alto!, ventana.cantidaVia, ventana.idVentana);
    } else if (tipoVeta == "Ventanas P-65") {
      print(ventana.idVentana);
      ventana = degloP65(
          ventana.ancho!, ventana.alto!, ventana.cantidaVia, ventana.idVentana);
    } else if (tipoVeta == "Ventanas P-92") {
      ventana = degloP92(
          ventana.ancho!, ventana.alto!, ventana.cantidaVia, ventana.idVentana);
    }
    Ventana ventanaFinal = Ventana(
        idProduccion: ventaTem.idProduccion,
        idVentana: ventaTem.idVentana,
        cantidaVia: ventaTem.cantidaVia,
        ancho: ventaTem.ancho,
        alto: ventaTem.alto,
        laterales: ventana.laterales,
        cabezarRiel: ventana.cabezarRiel,
        cabezalArferza: ventana.cabezalArferza,
        llavinEnganche: ventana.llavinEnganche,
        anchoCrital: ventana.anchoCrital,
        altoCrital: ventana.altoCrital);
    print(_creProducProv[nuPro].items[nuVen].cantidaVia);
      _creProducProv[nuPro].items[nuVen] = ventanaFinal;
    notifyListeners();

    await DBProvider.updateVenta(ventaTem);
    await DBProvider.updateLateral(ventana.laterales![0]);
    await DBProvider.updateRiel(ventana.cabezarRiel![0]);
    await DBProvider.updateAlfer(ventana.cabezalArferza![0]);
    await DBProvider.updateLlavi(ventana.llavinEnganche![0]);
    await DBProvider.updateCrista(ventana.anchoCrital![0]);
    await DBProvider.updateLlavi(ventana.altoCrital![0]);
  }

  updateLateral(LisPropiVen lateral, int nuPro, int nuItems, int estado) async {
    _creProducProv[nuPro].items[nuItems].laterales![0].estado = estado;
    notifyListeners();
    await DBProvider.updateLateral(lateral);
  }

  updateRiel(LisPropiVen lateral, int nuPro, int nuItems, int estado) async {
    _creProducProv[nuPro].items[nuItems].cabezarRiel![0].estado = estado;
    notifyListeners();
    await DBProvider.updateRiel(lateral);
  }

  updateLlavi(LisPropiVen lateral, int nuPro, int nuItems, int estado) async {
    _creProducProv[nuPro].items[nuItems].llavinEnganche![0].estado = estado;
    notifyListeners();
    await DBProvider.updateLlavi(lateral);
  }

  updateAlfer(LisPropiVen3 lateral, int nuPro, int nuItems, int estado) async {
    _creProducProv[nuPro].items[nuItems].cabezalArferza![0].estado = estado;
    notifyListeners();
    await DBProvider.updateAlfer(lateral);
  }

  updateCrital(LisPropiVen lateral, int nuPro, int nuItems, int estado) async {
    _creProducProv[nuPro].items[nuItems].anchoCrital![0].estado = estado;
    notifyListeners();
    await DBProvider.updateCrista(lateral);
  }

  verDeglose(int select, int nuPro, int items) {
    final Map text3 = {
      1: _creProducProv[nuPro].items[items].ancho,
      2: _creProducProv[nuPro].items[items].alto,
      3: _creProducProv[nuPro].items[items].laterales![0].valor,
      4: _creProducProv[nuPro].items[items].cabezarRiel![0].valor,
      5: _creProducProv[nuPro].items[items].cabezalArferza![0].valor,
      6: _creProducProv[nuPro].items[items].llavinEnganche![0].valor,
      7: _creProducProv[nuPro].items[items].anchoCrital![0].valor,
      8: _creProducProv[nuPro].items[items].altoCrital![0].valor,
      9: _creProducProv[nuPro].items[items].cabezalArferza![0].valor2,
      10: _creProducProv[nuPro].items[items].laterales![0].estado,
      11: _creProducProv[nuPro].items[items].cabezarRiel![0].estado,
      12: _creProducProv[nuPro].items[items].cabezalArferza![0].estado,
      13: _creProducProv[nuPro].items[items].llavinEnganche![0].estado,
      14: _creProducProv[nuPro].items[items].anchoCrital![0].estado,
      15: _creProducProv[nuPro].items[items].laterales![0].idVentana,
      16: _creProducProv[nuPro].items[items].cabezarRiel![0].idVentana,
      17: _creProducProv[nuPro].items[items].cabezalArferza![0].idVentana,
      18: _creProducProv[nuPro].items[items].llavinEnganche![0].idVentana,
      19: _creProducProv[nuPro].items[items].anchoCrital![0].idVentana,
    };
    return (text3[select]);
  }

  estadoVenta(int nuPro, int items) {
    num total2 = 0;
    for (int i = 10; i <= 14; i++) {
      total2 += verDeglose(i, nuPro, items)!;
    }
    if (total2 == 5) {
      return 1;
    } else {
      return 0;
    }
  }

  coutPosiProduc() {
    int n = _creProducProv.length;
    return (n != 0) ? n - 1 : 0;
  }

  coutProduc() {
    int n = _creProducProv.length;
    return n - 1;
  }

  degloTradi(double ancho, double alto, int cantidaVia, int idVent) {
    Ventana medida = Ventana(
      ancho: ancho,
      alto: alto,
      laterales: [LisPropiVen(alto - 0.5, 0, idVent)],
      cabezarRiel: (cantidaVia == 0)
          ? [LisPropiVen(ancho - 0.5, 0, idVent)]
          : [LisPropiVen(ancho - 0.25, 0, idVent)],
      cabezalArferza: (cantidaVia == 0)
          ? [
              LisPropiVen3(
                  valor: (ancho - 0.5) / 2,
                  valor2: 0,
                  estado: 0,
                  idVentana: idVent)
            ]
          : [
              LisPropiVen3(
                  valor: (ancho / 3) + 0.25,
                  valor2: (ancho / 3) - 0.5,
                  estado: 0,
                  idVentana: idVent)
            ],
      llavinEnganche: [LisPropiVen(alto - 0.875, 0, idVent)],
      anchoCrital: (cantidaVia == 0)
          ? [LisPropiVen(ancho / 2 - 2.0625, 0, idVent)]
          : [LisPropiVen((ancho / 3) - (1.5), 0, idVent)],
      altoCrital: [LisPropiVen(alto - 4, 0, idVent)],
    );
    return medida;
  }

  addTradi(double ancho, double alto, int cantidaVia, int nuPro) async {
    int idVen = await DBProvider.insertVentana(Ventana(
        idProduccion: _creProducProv[nuPro].id,
        ancho: ancho,
        alto: alto,
        cantidaVia: cantidaVia));

    Ventana medida = degloTradi(ancho, alto, cantidaVia, idVen);
    Ventana ventaTem = Ventana(
        idVentana: idVen,
        cantidaVia: cantidaVia,
        idProduccion: _creProducProv[nuPro].id,
        ancho: ancho,
        alto: alto,
        laterales: medida.laterales,
        cabezarRiel: medida.cabezarRiel,
        cabezalArferza: medida.cabezalArferza,
        llavinEnganche: medida.llavinEnganche,
        anchoCrital: medida.anchoCrital,
        altoCrital: medida.altoCrital);

    await DBProvider.insertDeglo(
        LisPropiVen(
            medida.laterales![0].valor, medida.laterales![0].estado, idVen),
        LisPropiVen(
            medida.cabezarRiel![0].valor, medida.cabezarRiel![0].estado, idVen),
        LisPropiVen3(
            valor: medida.cabezalArferza![0].valor,
            valor2: (medida.cabezalArferza![0].valor2),
            estado: 0,
            idVentana: idVen),
        LisPropiVen(medida.llavinEnganche![0].valor,
            medida.llavinEnganche![0].estado, idVen),
        LisPropiVen(
            medida.anchoCrital![0].valor, medida.anchoCrital![0].estado, idVen),
        LisPropiVen(
            medida.altoCrital![0].valor, medida.altoCrital![0].estado, idVen));

    _creProducProv[nuPro].items.add(ventaTem);
    notifyListeners();
  }

  degloP65(double ancho, double alto, int cantidaVia, int idVent) {
    Ventana medida = Ventana(
      ancho: ancho,
      alto: alto,
      laterales: [LisPropiVen(alto - 0.125, 0, idVent)],
      cabezarRiel: [LisPropiVen(ancho - 1.5, 0, idVent)],
      cabezalArferza: (cantidaVia == 0)
          ? [
              LisPropiVen3(
                  valor: (ancho - 1.125) / 2,
                  valor2: 0,
                  estado: 0,
                  idVentana: idVent)
            ]
          : [
              LisPropiVen3(
                  valor: ((ancho + 0.25) / 3),
                  valor2: 1,
                  estado: 0,
                  idVentana: idVent)
            ],
      llavinEnganche: [LisPropiVen(alto - 2.125, 0, idVent)],
      anchoCrital: (cantidaVia == 0)
          ? [LisPropiVen(ancho / 2 - 6.875, 0, idVent)]
          : [LisPropiVen((ancho - 7.8125) / 3, 0, idVent)],
      altoCrital: [LisPropiVen(alto - 5, 0, idVent)],
    );
    return medida;
  }

  addP65(double ancho, double alto, int cantidaVia, int nuPro) async {
    int idVen = await DBProvider.insertVentana(Ventana(
        idProduccion: _creProducProv[nuPro].id,
        ancho: ancho,
        alto: alto,
        cantidaVia: cantidaVia));
    Ventana medida = degloP65(ancho, alto, cantidaVia, idVen);
    Ventana ventaTem = Ventana(
        idVentana: idVen,
        cantidaVia: cantidaVia,
        idProduccion: _creProducProv[nuPro].id,
        ancho: ancho,
        alto: alto,
        laterales: medida.laterales,
        cabezarRiel: medida.cabezarRiel,
        cabezalArferza: medida.cabezalArferza,
        llavinEnganche: medida.llavinEnganche,
        anchoCrital: medida.anchoCrital,
        altoCrital: medida.altoCrital);
    await DBProvider.insertDeglo(
        LisPropiVen(
            medida.laterales![0].valor, medida.laterales![0].estado, idVen),
        LisPropiVen(
            medida.cabezarRiel![0].valor, medida.cabezarRiel![0].estado, idVen),
        LisPropiVen3(
            valor: medida.cabezalArferza![0].valor,
            valor2: (medida.cabezalArferza![0].valor2),
            estado: 0,
            idVentana: idVen),
        LisPropiVen(medida.llavinEnganche![0].valor,
            medida.llavinEnganche![0].estado, idVen),
        LisPropiVen(
            medida.anchoCrital![0].valor, medida.anchoCrital![0].estado, idVen),
        LisPropiVen(
            medida.altoCrital![0].valor, medida.altoCrital![0].estado, idVen));

    _creProducProv[nuPro].items.add(ventaTem);
    notifyListeners();
  }

  degloP92(double ancho, double alto, int cantidaVia, int idVent) {
    Ventana medida = Ventana(
      ancho: ancho,
      alto: alto,
      laterales: [LisPropiVen(alto - 0.125, 0, idVent)],
      cabezarRiel: [LisPropiVen(ancho - 1.5, 0, idVent)],
      cabezalArferza: (cantidaVia == 0)
          ? [
              LisPropiVen3(
                  valor: (ancho - 1.125) / 2,
                  valor2: 0,
                  estado: 0,
                  idVentana: idVent)
            ]
          : [
              LisPropiVen3(
                  valor: ((ancho + 0.25) / 3),
                  valor2: 1,
                  estado: 0,
                  idVentana: idVent)
            ],
      llavinEnganche: [LisPropiVen(alto - 2.125, 0, idVent)],
      anchoCrital: (cantidaVia == 0)
          ? [LisPropiVen(ancho / 2 - 6.875, 0, idVent)]
          : [LisPropiVen((ancho - 7.8125) / 3, 0, idVent)],
      altoCrital: [LisPropiVen(alto - 5, 0, idVent)],
    );
    return medida;
  }

  addP92(double ancho, double alto, int cantidaVia, int nuPro) async {
    int idVen = await DBProvider.insertVentana(Ventana(
        idProduccion: _creProducProv[nuPro].id,
        ancho: ancho,
        alto: alto,
        cantidaVia: cantidaVia));
    Ventana medida = degloTradi(ancho, alto, cantidaVia, idVen);

    await DBProvider.insertDeglo(
        LisPropiVen(
            medida.laterales![0].valor, medida.laterales![0].estado, idVen),
        LisPropiVen(
            medida.cabezarRiel![0].valor, medida.cabezarRiel![0].estado, idVen),
        LisPropiVen3(
            valor: medida.cabezalArferza![0].valor,
            valor2: (medida.cabezalArferza![0].valor2),
            estado: 0,
            idVentana: idVen),
        LisPropiVen(medida.llavinEnganche![0].valor,
            medida.llavinEnganche![0].estado, idVen),
        LisPropiVen(
            medida.anchoCrital![0].valor, medida.anchoCrital![0].estado, idVen),
        LisPropiVen(
            medida.altoCrital![0].valor, medida.altoCrital![0].estado, idVen));

    _creProducProv[nuPro].items.add(medida);

    notifyListeners();
  }

  cout() {
    return _creProducProv.length;
  }

  coutVentanaByPro(int nuPro) {
    return _creProducProv[nuPro].items.length;
  }

  converFracDesim(String medida, bool values) {
    double doubl1 = 0, doubl2 = 0, doubl3 = 0;
    if (values == false) {
      if (medida.length == 6) {
        doubl1 = double.parse(medida.substring(0, 2));
        doubl2 = double.parse(medida.substring(2, 4));
        doubl3 = double.parse(medida.substring(5, 6));
        return doubl1 + (doubl2 / doubl3);
      } else if (medida.length == 2) {
        return double.parse(medida);
      }
    } else {
      if (medida.length == 7) {
        doubl1 = double.parse(medida.substring(0, 3));
        doubl2 = double.parse(medida.substring(3, 5));
        doubl3 = double.parse(medida.substring(6, 7));
        return doubl1 + (doubl2 / doubl3);
      } else if (medida.length == 3) {
        return double.parse(medida);
      }
    }
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
}
