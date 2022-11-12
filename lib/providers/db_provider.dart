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
      ancho INTEGER,
      alto INTEGER,
	  
	   FOREIGN KEY(idProduccion) REFERENCES produccion(idProduccion)
	  )
        """);
    await database.execute("""
    CREATE TABLE laterales(
        idlaterales INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	    IdVentana INTEGER,
        valor  REAL,
	    estado INTEGER,
	    FOREIGN KEY(IdVentana) REFERENCES Ventana(IdVentana)
      )""");
    await database.execute("""
     CREATE TABLE cabezarRiel(
        idcabezarRiel INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	    IdVentana INTEGER, 
	    valor  REAL,
	    estado INTEGER,
		  FOREIGN KEY(IdVentana) REFERENCES Ventana(IdVentana)
        )""");
    await database.execute("""
    CREATE TABLE cabezalArferza(
        idcabezalArferza INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
		IdVentana INTEGER, 
	  	valor  REAL,
	  	estado INTEGER,
		FOREIGN KEY(IdVentana) REFERENCES Ventana(IdVentana)
        )""");
    await database.execute("""
    CREATE TABLE llavinEnganche(
          idllavinEnganche INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
		  IdVentana INTEGER,
		  valor  REAL,
		  estado INTEGER,
		  FOREIGN KEY(IdVentana) REFERENCES Ventana(IdVentana)
        )""");
    await database.execute("""
    CREATE TABLE anchoCrital(
          idanchoCrital INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
		  IdVentana INTEGER,
		  valor  REAL,
		  estado INTEGER,
		  FOREIGN KEY(IdVentana) REFERENCES Ventana(IdVentana)
        )""");

    await database.execute("""
    CREATE TABLE altoCrital(
        idaltoCrital INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
		  IdVentana INTEGER,
		  valor  REAL,
		  estado INTEGER,
		  FOREIGN KEY(IdVentana) REFERENCES Ventana(IdVentana)		  
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
    final path = join(directory.path, 'producciones4.db');
    print(path);

    return sql.openDatabase(
      path,
      version: 8,
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
      LisPropiVen degCaA,
      LisPropiVen degLlaEn,
      LisPropiVen degAnCri,
      LisPropiVen degAlCr) async {
    sql.Database? db = await instance.database;
    final idventana = await db!.insert("laterales", degLa.toMap());
    // await db!.insert("laterales", degCaR.toMap());
    await db.insert("cabezarRiel", degCaR.toMap());
    await db.insert("cabezalArferza", degCaA.toMap());
    await db.insert("llavinEnganche", degLlaEn.toMap());
    await db.insert("anchoCrital", degAlCr.toMap());
    await db.insert("altoCrital", degAlCr.toMap());
    print('Laterales Insertado en DB');
    return idventana;
  }

  static Future<int> deleteProducc(ProduccionCre produccionCre) async {
    sql.Database? db = await instance.database;
    final int idpro = await db!.delete("produccion",
        where: "idProduccion = ?", whereArgs: [produccionCre.id]);
    final int idventa = await db
        .delete("ventana", where: "idProduccion = ?", whereArgs: [idpro]);

    db.delete("laterales", where: "idlaterales = ?", whereArgs: [idventa]);
    db.delete("cabezarRiel", where: "idcabezarRiel = ?", whereArgs: [idventa]);
    db.delete("cabezalArferza",
        where: "idcabezalArferza = ?", whereArgs: [idventa]);
    db.delete("llavinEnganche",
        where: "idllavinEnganche = ?", whereArgs: [idventa]);
    db.delete("anchoCrital", where: "idanchoCrital = ?", whereArgs: [idventa]);
    db.delete("altoCrital", where: "idaltoCrital = ?", whereArgs: [idventa]);

    return idpro;
  }

  static Future<int> updateProducc(ProduccionCre produccionCre) async {
    sql.Database? db = await instance.database;
    return db!.update("produccion", produccionCre.toMap(),
        where: "id = ?", whereArgs: [produccionCre.id]);
  }

 static Future<List<ProduccionCre>> getProducc() async {
    sql.Database? db = await instance.database;
    final List<Map<String, dynamic>> producciones =
        await db!.query("produccion");
    final List<Map<String, dynamic>> ventana = 
        await db.query("ventana");
    final List<Map<String, dynamic>> laterales =
        await db.query("ventana");
    final List<Map<String, dynamic>> cabezarRiel =
        await db.query("cabezarRiel");
    final List<Map<String, dynamic>> cabezalArferza =
        await db.query("cabezalArferza");
    final List<Map<String, dynamic>> llavinEnganche =
        await db.query("llavinEnganche");
    final List<Map<String, dynamic>> anchoCrital =
        await db.query("anchoCrital");
    final List<Map<String, dynamic>> altoCrital = 
        await db.query("altoCrital");

    return List.generate(producciones.length, (index) {
      int idpro = producciones[index]['idProduccion'];
      return ProduccionCre(
          id: producciones[index]['idProduccion'],
          tipoVentana: producciones[index]['tipoVentana'],
          cliente: producciones[index]['cliente'],
          direccion: producciones[index]['direccion'],
          telefono: producciones[index]['telefono'],
          items: List.generate(ventana.length, (index) {
            if (idpro == ventana[index]['idProduccion']) {
              int idVen = ventana[index]['IdVentana'];
              return Ventana(
                  idProduccion: ventana[index]['idProduccion'],
                  idVentana: ventana[index]['IdVentana'],
                  ancho: ventana[index]['ancho'],
                  alto: ventana[index]['alto'],
                  laterales: List.generate(laterales.length, (index) {
                    if (laterales[index]['IdVentana'] == idVen) {
                      return LisPropiVen(laterales[index]['valor'],
                          laterales[index]['estado']);
                    } else {
                      return LisPropiVen(0, 0);
                    }
                  }),
                  cabezarRiel: List.generate(cabezarRiel.length, (index) {
                    if (cabezarRiel[index]['idlaterales'] == idVen) {
                      return LisPropiVen(cabezarRiel[index]['valor'],
                          cabezarRiel[index]['estado']);
                    } else {
                      return LisPropiVen(0, 0);
                    }
                  }),
                  llavinEnganche: List.generate(llavinEnganche.length, (index) {
                    if (llavinEnganche[index]['idlaterales'] == idVen) {
                      return LisPropiVen(llavinEnganche[index]['valor'],
                          llavinEnganche[index]['estado']);
                    } else {
                      return LisPropiVen(0, 0);
                    }
                  }),
                  cabezalArferza: List.generate(cabezalArferza.length, (index) {
                    if (cabezalArferza[index]['idlaterales'] == idVen) {
                      return LisPropiVen(cabezalArferza[index]['valor'],
                          cabezalArferza[index]['estado']);
                    } else {
                      return LisPropiVen(0, 0);
                    }
                  }),
                  anchoCrital: List.generate(anchoCrital.length, (index) {
                    if (anchoCrital[index]['idlaterales'] == idVen) {
                      return LisPropiVen(anchoCrital[index]['valor'],
                          anchoCrital[index]['estado']);
                    } else {
                      return LisPropiVen(0, 0);
                    }
                  }),
                  altoCrital: List.generate(altoCrital.length, (index) {
                    if (altoCrital[index]['idlaterales'] == idVen) {
                      return LisPropiVen(altoCrital[index]['valor'],
                          altoCrital[index]['estado']);
                    } else {
                      return LisPropiVen(0, 0);
                    }
                  }));
            } else {
              return Ventana();
            }
          }));
    });
  }
}
