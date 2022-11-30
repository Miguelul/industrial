import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:industrial/models/pruduccion.dart';
import 'package:industrial/providers/db_provider.dart';

class CreProducProv extends ChangeNotifier {
  final List<ProduccionCre> _creProducProv = [];
  UnmodifiableListView<ProduccionCre> get creProducProv =>
      UnmodifiableListView(_creProducProv);
  int idProdu = 0;

  init(int op) async {
    if (op == 1) {
      try {
        _creProducProv.clear();
        _creProducProv.addAll(await DBProvider.getProducc());
        notifyListeners();
      } catch (e) {
        print('ERRO AL CARGAR BASE DE DATO');
      }
    } else {
      try {
        _creProducProv.clear();
        _creProducProv.addAll(await DBProvider.getProducc());
        notifyListeners();
      } catch (e) {
        print('ERRO AL CARGAR BASE DE DATO');
      }
    }
  }

  addProducc(ProduccionCre produccion) async {
    _creProducProv.add(produccion);
    idProdu = await DBProvider.insertProducc(produccion);
  }

  sumMateriales(int nuPro, int totalDe) {
    double totalf = 0;
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
      if (creProducProv[nuPro].items[index].cabezalArferza![0].valor2 == 0) {
        total[1] = total[1]! +
            creProducProv[nuPro].items[index].laterales![0].valor * 2;
        total[2] =
            total[2]! + creProducProv[nuPro].items[index].cabezarRiel![0].valor;
        total[3] = total[3]! +
            creProducProv[nuPro].items[index].cabezalArferza![0].valor! * 2;
        total[4] = total[4]! +
            creProducProv[nuPro].items[index].llavinEnganche![0].valor * 2;
        total[5] = index + 1;
        total[6] = (index+1)*4;
        total[7] = total[7]! +
            (creProducProv[nuPro].items[index].anchoCrital![0].valor +
                    creProducProv[nuPro].items[index].altoCrital![0].valor) *
                4;
        totalf = total[totalDe]!;
      } else {
        total[8] = total[8]! +
            creProducProv[nuPro].items[index].laterales![0].valor * 2;
        total[9] = total[9]! +
            creProducProv[nuPro].items[index].cabezarRiel![0].valor;
        total[10] = total[10]! +
            creProducProv[nuPro].items[index].cabezalArferza![0].valor! * 3;
        total[11] = total[11]! +
            creProducProv[nuPro].items[index].llavinEnganche![0].valor * 2;
        total[12] = total[12]! +
            creProducProv[nuPro].items[index].llavinEnganche![0].valor * 4;
        total[13] = index + 1;
        total[14] = (index+1)*6;
        total[15] = total[15]! +
            (creProducProv[nuPro].items[index].anchoCrital![0].valor +
            creProducProv[nuPro].items[index].altoCrital![0].valor)*6;
        totalf = total[totalDe]!;
      }
    }

    return double.parse(totalf.toStringAsFixed(2));
  }

  toFullPi(double value) {
    return value = value / 21;
  }

  deleteProducc(index) async {
    await DBProvider.deleteProducc(index);
    init(1);
  }

  deleteVentana(int idPr, int idVe) async {
    _creProducProv[idPr].items.removeWhere((item) => item.idVentana == idVe);
    notifyListeners();
    await DBProvider.deleteVentana(idVe);
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

  updateAlfer(LisPropiVen lateral, int nuPro, int nuItems, int estado) async {
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

  coutProduc2() {
    int n = _creProducProv.length;
    return n;
  }

  addTradi(double ancho, double alto, int cantidaVia, int nuPro) async {
    print("```````````````$ancho  x $alto    $cantidaVia ");
    try {
      Ventana medida = Ventana(
        ancho: ancho,
        alto: alto,
        laterales: [LisPropiVen(alto - 0.5, 0)],
        cabezarRiel: (cantidaVia == 0)
            ? [LisPropiVen(ancho - 0.5, 0)]
            : [LisPropiVen(ancho - 0.25, 0)],
        cabezalArferza: (cantidaVia == 0)
            ? [LisPropiVen3(valor: (ancho - 0.5) / 2, valor2: 0, estado: 0)]
            : [
                LisPropiVen3(
                    valor: (ancho / 3) + 0.25,
                    valor2: (ancho / 3) - 0.5,
                    estado: 0)
              ],
        llavinEnganche: [LisPropiVen(alto - 0.875, 0)],
        anchoCrital: (cantidaVia == 0)
            ? [LisPropiVen(ancho / 2 - 2.0625, 0)]
            : [LisPropiVen((ancho / 3) - (1.5), 0)],
        altoCrital: [LisPropiVen(alto - 4, 0)],
      );
      int idVen = await DBProvider.insertVentana(
          Ventana(idProduccion: idProdu, ancho: ancho, alto: alto));

      try {
        await DBProvider.insertDeglo(
            LisPropiVen(
                medida.laterales![0].valor, medida.laterales![0].estado, idVen),
            LisPropiVen(medida.cabezarRiel![0].valor,
                medida.cabezarRiel![0].estado, idVen),
            LisPropiVen3(
                valor: medida.cabezalArferza![0].valor,
                valor2: (medida.cabezalArferza![0].valor2),
                estado: 0,
                idVentana: idVen),
            LisPropiVen(medida.llavinEnganche![0].valor,
                medida.llavinEnganche![0].estado, idVen),
            LisPropiVen(medida.anchoCrital![0].valor,
                medida.anchoCrital![0].estado, idVen),
            LisPropiVen(medida.altoCrital![0].valor,
                medida.altoCrital![0].estado, idVen));
      } catch (e) {
        print('Error al Guadar desglose Tradicional');
      }

      _creProducProv[nuPro].items.add(medida);
    } catch (err) {
      print('amarillo');
    }
    // prin();
    init(1);
  }

  addP65(double ancho, double alto, int cantidaVia, int nuPro) async {
    int idVen = await DBProvider.insertVentana(
        Ventana(idProduccion: idProdu, ancho: ancho, alto: alto));

    try {
      Ventana medida = Ventana(
        ancho: ancho,
        alto: alto,
        laterales: [LisPropiVen(alto - 0.125, 0)],
        cabezarRiel: [LisPropiVen(ancho - 1.5, 0)],
        cabezalArferza: (cantidaVia == 0)
            ? [LisPropiVen3(valor: (ancho - 1.125) / 2, valor2: 0, estado: 0)]
            : [LisPropiVen3(valor: ((ancho + 0.25) / 3), valor2: 1, estado: 0)],
        llavinEnganche: [LisPropiVen(alto - 2.125, 0)],
        anchoCrital: (cantidaVia == 0)
            ? [LisPropiVen(ancho / 2 - 6.875, 0)]
            : [LisPropiVen((ancho - 7.8125) / 3, 0)],
        altoCrital: [LisPropiVen(alto - 5, 0)],
      );

      try {
        await DBProvider.insertDeglo(
            LisPropiVen(
                medida.laterales![0].valor, medida.laterales![0].estado, idVen),
            LisPropiVen(medida.cabezarRiel![0].valor,
                medida.cabezarRiel![0].estado, idVen),
            LisPropiVen3(
                valor: medida.cabezalArferza![0].valor,
                valor2: (medida.cabezalArferza![0].valor2),
                estado: 0,
                idVentana: idVen),
            LisPropiVen(medida.llavinEnganche![0].valor,
                medida.llavinEnganche![0].estado, idVen),
            LisPropiVen(medida.anchoCrital![0].valor,
                medida.anchoCrital![0].estado, idVen),
            LisPropiVen(medida.altoCrital![0].valor,
                medida.altoCrital![0].estado, idVen));
      } catch (e) {
        print('Error al Guadar desglose Tradicional en DB');
      }

      _creProducProv[nuPro].items.add(medida);
    } catch (err) {
      print('Error al insertar deglose en list');
    }

    init(1);
  }

  addP90(double ancho, double alto, int cantidaVia, int nuPro) async {
    int idVen = await DBProvider.insertVentana(
        Ventana(idProduccion: idProdu, ancho: ancho, alto: alto));

    try {
      Ventana medida = Ventana(
        ancho: ancho,
        alto: alto,
        laterales: [LisPropiVen(alto - 0.125, 0)],
        cabezarRiel: [LisPropiVen(ancho - 1.5, 0)],
        cabezalArferza: (cantidaVia == 0)
            ? [LisPropiVen3(valor: (ancho - 1.125) / 2, valor2: 0, estado: 0)]
            : [LisPropiVen3(valor: ((ancho + 0.25) / 3), valor2: 1, estado: 0)],
        llavinEnganche: [LisPropiVen(alto - 2.125, 0)],
        anchoCrital: (cantidaVia == 0)
            ? [LisPropiVen(ancho / 2 - 6.875, 0)]
            : [LisPropiVen((ancho - 7.8125) / 3, 0)],
        altoCrital: [LisPropiVen(alto - 5, 0)],
      );

      try {
        await DBProvider.insertDeglo(
            LisPropiVen(
                medida.laterales![0].valor, medida.laterales![0].estado, idVen),
            LisPropiVen(medida.cabezarRiel![0].valor,
                medida.cabezarRiel![0].estado, idVen),
            LisPropiVen3(
                valor: medida.cabezalArferza![0].valor,
                valor2: (medida.cabezalArferza![0].valor2),
                estado: 0,
                idVentana: idVen),
            LisPropiVen(medida.llavinEnganche![0].valor,
                medida.llavinEnganche![0].estado, idVen),
            LisPropiVen(medida.anchoCrital![0].valor,
                medida.anchoCrital![0].estado, idVen),
            LisPropiVen(medida.altoCrital![0].valor,
                medida.altoCrital![0].estado, idVen));
      } catch (e) {
        print('Error al Guadar desglose Tradicional en DB');
      }

      _creProducProv[nuPro].items.add(medida);
    } catch (err) {
      print('Error al insertar deglose en list');
    }

    init(1);
  }

  cout() {
    return _creProducProv.length;
  }

  coutVentanaByPro(int nuPro) {
    print(nuPro);
    return _creProducProv[nuPro].items.length;
  }

  converFracDesim(String medida, bool values) {
    print("qqqqqqqqq$medida   $values");
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

  prin() {
    int i = 0;
    int n = 0;
    for (i = 0; i < _creProducProv.length; i++) {
      print(
        '[${_creProducProv[i].id}\n ${_creProducProv[i].tipoVentana}\n ${_creProducProv[i].cliente}\n ${_creProducProv[i].direccion} \n${_creProducProv[i].telefono} ]',
      );
      for (n = 0; n < _creProducProv[i].items.length; n++) {
        print(
            '\n [Ancho: ${_creProducProv[i].items[n].ancho} \n Altotura: ${_creProducProv[i].items[n].alto} \n Laterales: ${_creProducProv[i].items[n].laterales![0].valor} \nCabezalRiel: ${_creProducProv[i].items[n].cabezarRiel![0].valor} \n Cabezal Aferza: ${_creProducProv[i].items[n].cabezalArferza![0].valor} \n  Cabezal Aferza: ${_creProducProv[i].items[n].cabezalArferza![0].valor2} \n LlavinEngnache: ${_creProducProv[i].items[n].llavinEnganche![0].valor} \n AnchoCristal:  ${_creProducProv[i].items[n].anchoCrital![0].valor} \n AltoCrital: ${_creProducProv[i].items[n].altoCrital![0].valor} \n  ');
      }
    }
    return _creProducProv;
  }
}
