// For demo

class LisPropiVen {
  final int? idVentana, estado;
  final double valor;
  LisPropiVen(this.valor, this.estado, [this.idVentana]);

  Map<String, dynamic> toMap() {
    return {'IdVentana': idVentana, 'valor': valor, 'estado': estado};
  }
}

class Ventana {
  final int? idProduccion;
  final int idVentana;
  final double? ancho, alto;
  final List<LisPropiVen>? laterales,
      cabezarRiel,
      cabezalArferza,
      llavinEnganche,
      anchoCrital,
      altoCrital;

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
  final int id;
  final String? tipoVentana, cliente, direccion, telefono;
  final List<Ventana> items;

  ProduccionCre(
      {required this.id,
      this.tipoVentana,
      this.cliente,
      this.direccion,
      this.telefono,
      required this.items});

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'tipoVentana': tipoVentana,
      'cliente': cliente,
      'direccion': direccion,
      'telefono': telefono,
      // 'Iditems': items[0].idVentana
    };
  }
}
