import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;

import 'package:industrial/models/pruduccion.dart';

class DBProvider {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
       CREATE TABLE produccion(
      idProduccion INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      tipoVentana TEXT,
      cliente TEXT,
      direccion TEXT,
      telefono TEXT
      )
        """);
    await database.execute("""
      CREATE TABLE ventana(
      IdVentana INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	    idProduccion INTEGER,
      ancho REAL,
      alto REAL,
	  
	   FOREIGN KEY(idProduccion) REFERENCES produccion(idProduccion) ON DELETE CASCADE
	  )
        """);
    await database.execute("""
    CREATE TABLE laterales(
        idlaterales INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	    IdVentana INTEGER,
        valor  REAL,
	    estado INTEGER,
	    FOREIGN KEY(IdVentana) REFERENCES Ventana(IdVentana) ON DELETE CASCADE
      )""");
    await database.execute("""
     CREATE TABLE cabezarRiel(
        idcabezarRiel INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	    IdVentana INTEGER, 
	    valor  REAL,
	    estado INTEGER,
		  FOREIGN KEY(IdVentana) REFERENCES Ventana(IdVentana) ON DELETE CASCADE
        )""");
    await database.execute("""
    CREATE TABLE cabezalArferza(
        idcabezalArferza INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
		IdVentana INTEGER, 
	  	valor  REAL,
      valor2  REAL,
	  	estado INTEGER,
		FOREIGN KEY(IdVentana) REFERENCES Ventana(IdVentana) ON DELETE CASCADE
        )""");
    await database.execute("""
    CREATE TABLE llavinEnganche(
          idllavinEnganche INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
		  IdVentana INTEGER,
		  valor  REAL,
		  estado INTEGER,
		  FOREIGN KEY(IdVentana) REFERENCES Ventana(IdVentana) ON DELETE CASCADE
        )""");
    await database.execute("""
    CREATE TABLE anchoCrital(
          idanchoCrital INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
		  IdVentana INTEGER,
		  valor  REAL,
		  estado INTEGER,
		  FOREIGN KEY(IdVentana) REFERENCES Ventana(IdVentana) ON DELETE CASCADE
        )""");

    await database.execute("""
    CREATE TABLE altoCrital(
        idaltoCrital INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
		  IdVentana INTEGER,
		  valor  REAL,
		  estado INTEGER,
		  FOREIGN KEY(IdVentana) REFERENCES Ventana(IdVentana)	ON DELETE CASCADE	  
      )
      """);
  }

  DBProvider._privateConstructor();
  static final DBProvider instance = DBProvider._privateConstructor();

  static sql.Database? _database;
  Future<sql.Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB();
    return _database;
  }

  static Future<sql.Database> _initDB() async {
    // Path de donde almacenaremos la base de datos
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'producciones16.db');
    return sql.openDatabase(
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      path,
      version: 21,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> insertProducc(ProduccionCre produccionCre) async {
    sql.Database? db = await instance.database;
    final idprodu = await db!.insert("produccion", produccionCre.toMap());
    print('producion insertada en DB');

    return idprodu;
  }

  static Future<int> insertVentana(Ventana ventana) async {
    sql.Database? db = await instance.database;
    final idventana = await db!.insert("ventana", ventana.toMap());
    print('Ventana insertada en DB');
    return idventana;
  }

  static Future<int> insertDeglo(
      LisPropiVen degLa,
      LisPropiVen degCaR,
      LisPropiVen3 degCaA,
      LisPropiVen degLlaEn,
      LisPropiVen degAnCri,
      LisPropiVen degAlCr) async {
    sql.Database? db = await instance.database;
    final idventana = await db!.insert("laterales", degLa.toMap());
    await db.insert("cabezarRiel", degCaR.toMap());
    await db.insert("cabezalArferza", degCaA.toMap());
    await db.insert("llavinEnganche", degLlaEn.toMap());
    await db.insert("anchoCrital", degAlCr.toMap());
    await db.insert("altoCrital", degAlCr.toMap());

    print('Desglo Insertado en DB');
    return idventana;
  }

  static Future<int> deleteProducc(int id) async {
    sql.Database? db = await instance.database;

    final int idPro = await db!
        .delete("produccion", where: "idProduccion = ?", whereArgs: [id]);

    print('Producion Borrada $id');
  
    return idPro;
  }

  static Future<int> deleteVentana(int id) async {
    sql.Database? db = await instance.database;
    final int idVent =
        await db!.delete("ventana", where: "IdVentana = ?", whereArgs: [id]);

    return idVent;
  }

  static Future<int> updateProducc(ProduccionCre produccionCre) async {
    sql.Database? db = await instance.database;
    return db!.update("produccion", produccionCre.toMap(),
        where: "id = ?", whereArgs: [produccionCre.id]);
  }
    static Future<int> updateLateral(LisPropiVen proVenta) async {
    sql.Database? db = await instance.database;
    return db!.update("laterales", proVenta.toMap(),
        where: "IdVentana = ?", whereArgs: [proVenta.idVentana]);
  }
   static Future<int> updateRiel(LisPropiVen proVenta) async {
    sql.Database? db = await instance.database;
    return db!.update("cabezarRiel", proVenta.toMap(),
        where: "IdVentana = ?", whereArgs: [proVenta.idVentana]);
  }
   static Future<int> updateLlavi(LisPropiVen proVenta) async {
    sql.Database? db = await instance.database;
    return db!.update("llavinEnganche", proVenta.toMap(),
        where: "IdVentana = ?", whereArgs: [proVenta.idVentana]);
  }
   static Future<int> updateAlfer(LisPropiVen proVenta) async {
    sql.Database? db = await instance.database;
    return db!.update("cabezalArferza", proVenta.toMap(),
        where: "IdVentana = ?", whereArgs: [proVenta.idVentana]);
  }
   static Future<int> updateCrista(LisPropiVen proVenta) async {
    sql.Database? db = await instance.database;
    return db!.update("anchoCrital", proVenta.toMap(),
        where: "IdVentana = ?", whereArgs: [proVenta.idVentana]);
  }

  static Future<List<ProduccionCre>> getProducc() async {
    sql.Database? db = await instance.database;
    final List<Map<String, dynamic>> producciones =
        await db!.query("produccion");
    List<ProduccionCre> producc = [];

    int index = 0;
    while (index < producciones.length) {
      producc.add(ProduccionCre(
        id: producciones[index]['idProduccion'],
        tipoVentana: producciones[index]['tipoVentana'],
        cliente: producciones[index]['cliente'],
        direccion: producciones[index]['direccion'],
        telefono: producciones[index]['telefono'],
        items: await getVenta(producciones[index]['idProduccion']),
      ));

      index++;
    }
    return producc;
  }

  static Future<int> getCoutVenta() async {
    sql.Database? db = await instance.database;
    final List<Map<String, dynamic>> coutVenta = await db!
        .rawQuery('select count(IdVentana) as "ContVenta" from ventana ');
    return coutVenta[0]["ContVenta"];
  }

  static Future<List<Ventana>> getVenta(int idPro) async {
    sql.Database? db = await instance.database;
    final List<Map<String, dynamic>> ventana = await db!
        .rawQuery('select * from ventana where idProduccion=$idPro');
    List<Ventana> ventan = [];
    for (int index = 0; index < ventana.length; index++) {
      int n = ventana[index]['IdVentana'];
      ventan.add(Ventana(
          idProduccion: ventana[index]['idProduccion'],
          idVentana: ventana[index]['IdVentana'],
          ancho: ventana[index]['ancho'],
          alto: ventana[index]['alto'],
          laterales: await getLate(n),
          cabezarRiel: await getCaRiel(n),
          llavinEnganche: await getLLavi(n),
          cabezalArferza: await getCaAlf(n),
          anchoCrital: await getAnchoCristal(n),
          altoCrital: await getAltoCristal(n)));
    }
    return ventan;
  }

  static Future<List<LisPropiVen>> getLate(int idVenta) async {
    sql.Database? db = await instance.database;
    final List<Map<String, dynamic>> laterales = await db!
        .rawQuery('select * from laterales where IdVentana=$idVenta');
    return List.generate(laterales.length, (index) {
      return LisPropiVen(laterales[index]['valor'], laterales[index]['estado'],
          laterales[index]['IdVentana']);
    });
  }

  static Future<List<LisPropiVen>> getCaRiel(int idVenta) async {
    sql.Database? db = await instance.database;
    final List<Map<String, dynamic>> cabezarRiel = await db!
        .rawQuery('select * from cabezarRiel where IdVentana=$idVenta');
    return List.generate(cabezarRiel.length, (index) {
      return LisPropiVen(cabezarRiel[index]['valor'],
          cabezarRiel[index]['estado'], cabezarRiel[index]['IdVentana']);
    });
  }

  static Future<List<LisPropiVen>> getLLavi(int idVenta) async {
    sql.Database? db = await instance.database;
    final List<Map<String, dynamic>> llavinEnganche = await db!
        .rawQuery('select * from llavinEnganche where IdVentana=$idVenta');
    return List.generate(llavinEnganche.length, (index) {
      return LisPropiVen(llavinEnganche[index]['valor'],
          llavinEnganche[index]['estado'], llavinEnganche[index]['IdVentana']);
    });
  }

  static Future<List<LisPropiVen3>> getCaAlf(int idVenta) async {
    sql.Database? db = await instance.database;
    final List<Map<String, dynamic>> cabezalArferza = await db!
        .rawQuery('select * from cabezalArferza where IdVentana=$idVenta');
    return List.generate(cabezalArferza.length, (index) {
      return LisPropiVen3(
          valor: cabezalArferza[index]['valor'],
          valor2: cabezalArferza[index]['valor2'],
          estado: cabezalArferza[index]['estado'],
          idVentana: cabezalArferza[index]['IdVentana']);
    });
  }

  static Future<List<LisPropiVen>> getAnchoCristal(int idVenta) async {
    sql.Database? db = await instance.database;
    final List<Map<String, dynamic>> anchoCrital = await db!
        .rawQuery('select * from anchoCrital where IdVentana=$idVenta');
    return List.generate(anchoCrital.length, (index) {
      return LisPropiVen(anchoCrital[index]['valor'],
          anchoCrital[index]['estado'], anchoCrital[index]['IdVentana']);
    });
  }

  static Future<List<LisPropiVen>> getAltoCristal(int idVenta) async {
    sql.Database? db = await instance.database;
    final List<Map<String, dynamic>> altoCrital =
        await db!.rawQuery('select * from altoCrital where IdVentana=$idVenta');
    return List.generate(altoCrital.length, (index) {
      return LisPropiVen(altoCrital[index]['valor'],
          altoCrital[index]['estado'], altoCrital[index]['IdVentana']);
    });
  }
}
