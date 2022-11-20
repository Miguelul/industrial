// For demo

class LisPropiVen {
  int? idVentana, estado;
  final double valor;
  LisPropiVen(this.valor, this.estado, [this.idVentana]);

  Map<String, dynamic> toMap() {
    return {'IdVentana': idVentana, 'valor': valor, 'estado': estado};
  }

  Map<String, dynamic> toMap2() {
    return {'IdVentana': idVentana, 'estado': estado};
  }
}

class LisPropiVen3 {
  int ?estado;
  final int? idVentana;
  final double? valor;
  final double? valor2;

  LisPropiVen3({this.valor, this.valor2, this.estado, this.idVentana});

  Map<String, dynamic> toMap() {
    return {
      'IdVentana': idVentana,
      'valor': valor,
      'valor2': valor2,
      'estado': estado
    };
  }
}

class Ventana {
  final int? idProduccion;
  final int idVentana;
  final double? ancho, alto;
  final List<LisPropiVen>? laterales,
      cabezarRiel,
      llavinEnganche,
      anchoCrital,
      altoCrital;
  final List<LisPropiVen3>? cabezalArferza;

  Ventana(
      {this.idVentana = 0,
      this.idProduccion,
      this.ancho,
      this.alto,
      this.laterales,
      this.cabezarRiel,
      this.cabezalArferza,
      this.llavinEnganche,
      this.anchoCrital,
      this.altoCrital});

  Map<String, dynamic> toMap() {
    return {'idProduccion': idProduccion, 'ancho': ancho, 'alto': alto};
  }
}

class ProduccionCre {
  final int? id;
  final String? tipoVentana, cliente, direccion, telefono, fecha;
  final List<Ventana> items;

  ProduccionCre(
      {this.id,
      this.fecha,
      this.tipoVentana,
      this.cliente,
      this.direccion,
      this.telefono,
      required this.items});

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'fecha': fecha,
      'tipoVentana': tipoVentana,
      'cliente': cliente,
      'direccion': direccion,
      'telefono': telefono,
      // 'Iditems': items[0].idVentana
    };
  }
}
