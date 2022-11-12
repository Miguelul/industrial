import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:industrial/models/pruduccion.dart';
import 'package:industrial/providers/db_provider.dart';

class CreProducProv extends ChangeNotifier {
  final List<ProduccionCre> _creProducProv = [];
  UnmodifiableListView<ProduccionCre> get creProducProv =>
      UnmodifiableListView(_creProducProv);
  int idProdu = 0, idVentana = 0, idDeglo = 0;

  init() async {
    try {
      _creProducProv.addAll(await DBProvider.getProducc());
    } catch (e) {
      print('ERRO AL CARGAR BASE DE DATO');
    }
  }

  addVentana(ProduccionCre produccion) async {
    _creProducProv.add(produccion);
    idProdu = await DBProvider.insertProducc(produccion);
    print('$idProdu///');
    notifyListeners();
  }

  deleteVentana(index) {
    _creProducProv
        .indexWhere((_produc) => _produc.id == creProducProv[index].id);
    notifyListeners();
  }

  verDeglose(int select, int nuPro, int items) async {
    final Map text3 = {
      1: _creProducProv[nuPro].items[items].ancho,
      2: _creProducProv[nuPro].items[items].alto,
      3: _creProducProv[nuPro].items[items].laterales![0].valor,
      4: _creProducProv[nuPro].items[items].cabezarRiel![0].valor,
      5: _creProducProv[nuPro].items[items].cabezalArferza![0].valor,
      6: _creProducProv[nuPro].items[items].llavinEnganche![0].valor,
      7: _creProducProv[nuPro].items[items].anchoCrital![0].valor,
      8: _creProducProv[nuPro].items[items].altoCrital![0].valor,
    };
    return text3[select];
  }

  addTradi(double ancho, double alto) async {
    int n = _creProducProv.length;
    idVentana = 1;
    try {
      Ventana medida = Ventana(
        ancho: ancho,
        alto: alto,
        laterales: [LisPropiVen(alto - 0.5, 0)],
        cabezarRiel: [LisPropiVen(alto - 0.5, 0)],
        cabezalArferza: [LisPropiVen((ancho - 0.5) / 2, 0)],
        llavinEnganche: [LisPropiVen(alto - 0.875, 0)],
        anchoCrital: [LisPropiVen(ancho / 2 - 2.0625, 0)],
        altoCrital: [LisPropiVen(alto - 4, 0)],
      );
      final int idVe = await DBProvider.insertVentana(
          Ventana(idProduccion: idProdu, ancho: ancho, alto: alto));
      print('$idVe****');

      final int deglo = await DBProvider.insertDeglo(
          LisPropiVen(medida.laterales![0].valor, medida.laterales![0].estado,
              idVentana),
          LisPropiVen(medida.cabezarRiel![0].valor,
              medida.cabezarRiel![0].estado, idVentana),
          LisPropiVen(medida.cabezalArferza![0].valor,
              medida.cabezalArferza![0].estado, idVentana),
          LisPropiVen(medida.llavinEnganche![0].valor,
              medida.llavinEnganche![0].estado, idVentana),
          LisPropiVen(medida.anchoCrital![0].valor,
              medida.anchoCrital![0].estado, idVentana),
          LisPropiVen(medida.altoCrital![0].valor, medida.altoCrital![0].estado,
              idVentana));

      print('$deglo +++');
      _creProducProv[n - 1].items.add(medida);
    } catch (err) {
      print('amarillo');
    }

    notifyListeners();
  }

  addP65(double ancho, double alto) {
    int n = _creProducProv.length;

    try {
      Ventana medida = Ventana(
        ancho: ancho,
        alto: alto,
        laterales: [LisPropiVen(alto - 1, 0)],
        cabezarRiel: [LisPropiVen(alto - 0.5, 0)],
        cabezalArferza: [LisPropiVen((ancho - 0.5) / 2, 0)],
        llavinEnganche: [LisPropiVen(alto - 0.875, 0)],
        anchoCrital: [LisPropiVen(ancho / 2 - 2.0625, 0)],
        altoCrital: [LisPropiVen(alto - 4, 0)],
      );

      _creProducProv[n - 1].items.add(medida);
    } catch (err) {
      print('amarillo');
    }

    notifyListeners();
  }

  addP90(double ancho, double alto) {
    int n = _creProducProv.length;

    try {
      Ventana medida = Ventana(
        ancho: ancho,
        alto: alto,
        laterales: [LisPropiVen(alto - 2, 0)],
        cabezarRiel: [LisPropiVen(alto - 0.5, 0)],
        cabezalArferza: [LisPropiVen((ancho - 0.5) / 2, 0)],
        llavinEnganche: [LisPropiVen(alto - 0.875, 0)],
        anchoCrital: [LisPropiVen(ancho / 2 - 2.0625, 0)],
        altoCrital: [LisPropiVen(alto - 4, 0)],
      );

      _creProducProv[n - 1].items.add(medida);
    } catch (err) {
      print('amarillo');
    }

    notifyListeners();
  }

  converFracDesim(String medida) {
    double doubl1 = 0, doubl2 = 0, doubl3 = 0;

    if (medida.length == 6) {
      doubl1 = double.parse(medida.substring(0, 2));
      doubl2 = double.parse(medida.substring(2, 4));
      doubl3 = double.parse(medida.substring(5, 6));
      return doubl1 + (doubl2 / doubl3);
    } else if (medida.length == 2) {
      return double.parse(medida);
    }
  }

  toFracc(double num1) {
    if (num1 >= 0) {
      Type type = num1.runtimeType;
      if (type.toString() == 'double') {
        int int1 = num1.floor();
        double desimal = num1 - int1;
        double a, b;
        double aux;
        a = 1;
        b = 1;
        aux = 1;
        while (!(aux == desimal)) {
          aux = a / b;
          if (aux < desimal) {
            a++;
          } else if (aux > desimal) {
            a--;
            b++;
          }
        }
        return ('$int1 ${a.toInt()}/${b.toInt()}').toString();
      } else if (type.toString() == 'int') {
        return num1.toString();
      }
    } else {
      return 0;
    }
  }

  // deleteDefaVen() {
  //   int n = _creProducProv.length;
  //   if (_creProducProv[n - 1].items[0].alto == 0) {
  //     print('+++++$n ++++++');
  //     _creProducProv[n - 1].items.removeAt(0);
  //   }
  // }

  cout() {
    return _creProducProv.length;
  }

  coutProduc() {
    int n = _creProducProv.length;
    return n - 1;
  }

  coutVentana() {
    int n = _creProducProv.length;
    return _creProducProv[n - 1].items.length;
  }

  prin() {
    int i = 0;
    int n = 0;
    for (i = 0; i < _creProducProv.length; i++) {
      print(
        '[${_creProducProv[i].id}\n ${_creProducProv[i].cliente}\n ${_creProducProv[i].direccion} \n${_creProducProv[i].telefono} ]',
      );
      for (n = 0; n < _creProducProv[i].items.length; n++) {
        print(
            '\n [Ancho: ${_creProducProv[i].items[n].ancho} \n Altotura: ${_creProducProv[i].items[n].alto} \n Laterales: ${_creProducProv[i].items[n].laterales![0].valor} \nCabezalRiel: ${_creProducProv[i].items[n].cabezarRiel![0].valor} \n Cabezal Aferza: ${_creProducProv[i].items[n].cabezalArferza![0].valor} \n LlavinEngnache: ${_creProducProv[i].items[n].llavinEnganche![0].valor} \n AnchoCristal:  ${_creProducProv[i].items[n].anchoCrital![0].valor} \n AltoCrital: ${_creProducProv[i].items[n].altoCrital![0].valor} \n  ');
      }
    }
    return _creProducProv;
  }
}
