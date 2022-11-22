import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:industrial/providers/db_provider.dart';
import 'package:industrial/screens/produ_terninada.dart';
import 'package:industrial/widgets/search.dart';
import 'package:provider/provider.dart';

import '../providers/cre_produ_prov.dart';
import '../providers/cre_ventana.dart';

// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true, _refresh1 = true;

  void _refresh() async {
    setState(() {
      _refresh1 = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final tipoVentana = Provider.of<TipoVentana>(context);
    final crPruProv = Provider.of<CreProducProv>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    if (_refresh1 == false) {
      crPruProv.init(1);
      _refresh1 = true;
      _isLoading = false;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              'Arinde',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 87, 87, 87)),
            ),
            const Text(
              'Crear es Nuestra Virtud',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w100,
                  color: Color.fromARGB(255, 153, 145, 145)),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    CupertinoButton(
                        onPressed: () => showSearch(
                            context: context, delegate: CustomSearchDelegate()),
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 238, 238, 238),
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            children: const [
                              SizedBox(width: 15),
                              Icon(
                                Icons.search,
                                color: Color.fromARGB(255, 187, 187, 187),
                              ),
                              SizedBox(width: 14),
                              Text('Nombre del Cliente',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 187, 187, 187)))
                            ],
                          ),
                        )),
                    const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Con cual tipo de ventana quieres trabajar',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(221, 66, 66, 66)),
                        )),
                    Container(
                      height: 230,
                      width: double.infinity,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: ListView.builder(
                          itemCount: tipoVentana.ventanasD.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 238, 238, 238),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 15,
                                      top: 15,
                                      child: CupertinoButton(
                                          onPressed: () {
                                            tipoVentana.indexTipo = index;
                                            Navigator.pushReplacementNamed(
                                                context, 'crearProduc');
                                          },
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 5),
                                          color: CupertinoColors.activeBlue,
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          child: const Icon(
                                            CupertinoIcons.add,
                                            size: 23,
                                          )),
                                    ),
                                    Positioned(
                                        bottom: 20,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Container(
                                            width: 95,
                                            child: Text(
                                              tipoVentana
                                                  .ventanasD[index].nombre,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      221, 66, 66, 66)),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Todas la producción',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(221, 66, 66, 66)),
                      ),
                    ),
                    const CardProducc(),
                    ElevatedButton.icon(
                        onPressed: (() async {}),
                        icon: const Icon(Icons.backpack),
                        label: const Text('Login')),
                    ElevatedButton.icon(
                        onPressed: (() {
                          crPruProv.init(1);
                        }),
                        icon: const Icon(Icons.backpack),
                        label: const Text('Crear Producción')),
                  ],
                ),
              ),
            ),
    );
  }
}

class CardProducc extends StatelessWidget {
  const CardProducc({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crearPruduccionPro = Provider.of<CreProducProv>(context);

    return ListView.builder(
        itemCount: crearPruduccionPro.coutProduc2(),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => (CupertinoButton(
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return FadeTransition(
                      opacity: animation1,
                      child: ProduTerminada(
                        nuPro: index,
                        contVen: crearPruduccionPro.coutVentanaByPro(index).toDouble(),
                      ));
                },
              ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 238, 238),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' ${index + 1}   ${crearPruduccionPro.creProducProv[index].cliente} ',
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 87, 87, 87)),
                          ),
                          Text(
                            '${crearPruduccionPro.creProducProv[index].direccion}',
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w100,
                                color: Color.fromARGB(255, 153, 145, 145)),
                          ),
                        ],
                      ),
                    ),
                    CupertinoButton(
                        child: const Icon(Icons.delete_forever),
                        onPressed: () {
                          showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text("Delete File"),
                                  content: const Text(
                                      "Are you sure you want to delete the file?"),
                                  actions: [
                                    CupertinoDialogAction(
                                        child: const Text("YES"),
                                        onPressed: () {
                                          crearPruduccionPro.deleteProducc(
                                              crearPruduccionPro
                                                  .creProducProv[index].id);
                                          Navigator.of(context).pop();
                                        }),
                                    CupertinoDialogAction(
                                        child: const Text("NO"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        })
                                  ],
                                );
                              });
                        })
                  ],
                ),
              ),
            ))));
  }
}
