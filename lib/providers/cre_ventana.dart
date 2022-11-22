import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:industrial/models/ventanas.dart';


class TipoVentana extends ChangeNotifier {
  int indexTipo = 0;
  final List<Ventanas> _ventanasDisp = [
    Ventanas(
      nombre: "Ventanas Tradicional",
    ),
    Ventanas(
      nombre: "Ventanas PS5",
    ),
    Ventanas(
      nombre: "Ventanas P40",
    ),
  ];
  UnmodifiableListView<Ventanas> get ventanasD =>
      UnmodifiableListView(_ventanasDisp);

  addVentana(Ventanas ventanas) {
    _ventanasDisp.add(ventanas);
    notifyListeners();
  }

  deleteVentana(index) {
    _ventanasDisp
        .removeWhere((venta) => venta.nombre == ventanasD[index].nombre);
    notifyListeners();
  }

  String input = '';

  prin() {
    return input;
  }
}
