import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:industrial/providers/validator_form.dart';
import 'package:industrial/screens/crear_produc.dart';
import 'package:industrial/screens/produ_terninada.dart';
import 'package:industrial/widgets/search.dart';
import 'package:provider/provider.dart';

import '../providers/cre_produ_prov.dart';
import '../providers/cre_ventana.dart';
import '../services/auth_service.dart';
import '../widgets/cupertino_co_men.dart';
import 'agregar_ventana/agregar_vent.dart';

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
    final authService = Provider.of<AuthService>(context, listen: false);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    if (_refresh1 == false) {
      _refresh1 = true;
      _isLoading = false;
    }

    return WillPopScope(
      onWillPop: (() async {
        SystemNavigator.pop();
        return false;
      }),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: false,
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
            actions: [
              IconButton(
                icon: Icon(Icons.login_outlined, color: theme.primaryColor),
                onPressed: () {
                  showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text("Logout"),
                          content: const Text(
                              "Está seguro de que quieres cerrar la seción?"),
                          actions: [
                            CupertinoDialogAction(
                                child: const Text("SI"),
                                onPressed: () {
                                  authService.logout();
                                  Navigator.pushReplacementNamed(
                                      context, 'login');
                                }),
                            CupertinoDialogAction(
                                child: const Text("NO"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        );
                      });
                },
              ),
            ]),
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
                              context: context,
                              delegate: CustomSearchDelegate()),
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
                            'Con cual tipo de ventana quieres trabajar?',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(221, 66, 66, 66)),
                          )),
                      Container(
                        height: height * 0.46,
                        width: double.infinity,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: ListView.builder(
                            itemCount: tipoVentana.ventanasD.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(17.0),
                                child: Container(
                                  width: width * 0.493,
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
                                            onPressed: index != 2
                                                ? () {
                                                    Navigator.of(context).push(
                                                      PageRouteBuilder(
                                                        pageBuilder: (context,
                                                            animation1,
                                                            animation2) {
                                                          return FadeTransition(
                                                              opacity:
                                                                  animation1,
                                                              child:
                                                                  ChangeNotifierProvider(
                                                                create: (context) =>
                                                                    ValidatorForm(),
                                                                child:
                                                                    const CrearProduccion(),
                                                              ));
                                                        },
                                                      ),
                                                    );

                                                    tipoVentana.indexTipo =
                                                        index;
                                                  }
                                                : null,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18, vertical: 5),
                                            color: theme.primaryColor,
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
                                            child: SizedBox(
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
                        padding: EdgeInsets.all(11.0),
                        child: Text(
                          'Todas las Producciones',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(218, 66, 66, 66)),
                        ),
                      ),
                      const CardProducc(),
                    ],
                  ),
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final crearPruduccionPro = Provider.of<CreProducProv>(context);
    final theme = Theme.of(context);
    return ListView.builder(
        reverse: true,
        itemCount: crearPruduccionPro.coutProduc2(),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => (CupertinoButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return FadeTransition(
                        opacity: animation1,
                        child: ProduTerminada(
                          nuPro: index,
                          contVen: crearPruduccionPro
                              .coutVentanaByPro(index)
                              .toDouble(),
                        ));
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              child: Stack(children: [
                Container(
                  height: height * 0.15,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 238, 238),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${crearPruduccionPro.creProducProv[index].id}  ${crearPruduccionPro.creProducProv[index].cliente} ',
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
                              color: Color.fromARGB(255, 126, 117, 117)),
                        ),
                        SizedBox(
                          width: width * 0.65,
                          child: Text(
                            '${crearPruduccionPro.creProducProv[index].fecha}  ${crearPruduccionPro.creProducProv[index].tipoVentana}',
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w100,
                                color: Color.fromARGB(255, 126, 117, 117)),
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 1,
                  top: 1,
                  bottom: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: SizedBox(
                      // color: Colors.red,
                      width: 65,
                      height: 52,
                      child: CupertinoContextMenu2M(
                        actions: [
                          CupertinoContextMenuAction(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) {
                                    return FadeTransition(
                                        opacity: animation1,
                                        child: ChangeNotifierProvider(
                                          create: (context) => ValidatorForm(),
                                          child: AfregarVentanas(
                                            nuPro: index,
                                          ),
                                        ));
                                  },
                                ),
                              );
                            },
                            trailingIcon: CupertinoIcons.pencil,
                            child: const Text("Editar Medidas"),
                          ),
                          CupertinoContextMenuAction(
                            onPressed: () {
                              Navigator.of(context).pop();
                              showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: const Text("Eliminar Producción"),
                                      content: const Text(
                                          "Está seguro que de quieres borrar esta Producción?"),
                                      actions: [
                                        CupertinoDialogAction(
                                            child: const Text("YES"),
                                            onPressed: () {
                                              crearPruduccionPro.deleteProducc(
                                                  index,
                                                  crearPruduccionPro
                                                      .creProducProv[index]
                                                      .id!);
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
                            },
                            isDestructiveAction: true,
                            trailingIcon: CupertinoIcons.delete,
                            child: const Text("Delete"),
                          )
                        ],
                        child: Container(
                          height: 20,
                          width: 55,
                          color: const Color.fromARGB(0, 0, 0, 0),
                          child: Icon(CupertinoIcons.ellipsis_vertical,
                              color: theme.primaryColor, size: 28),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ))));
  }
}
