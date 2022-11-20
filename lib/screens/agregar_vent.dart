import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:industrial/screens/produ_terninada.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../providers/cre_produ_prov.dart';
import '../providers/cre_ventana.dart';
import '../ui/input_decorations.dart';

class AfregarVentanas extends StatefulWidget {
  const AfregarVentanas({
    Key? key,
  }) : super(key: key);

  @override
  State<AfregarVentanas> createState() => _AfregarVentanasState();
}

class _AfregarVentanasState extends State<AfregarVentanas> {
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  bool valueI = false;
  bool value2 = false;
  bool value3 = false;
  var maskFormatter = MaskTextInputFormatter(
      mask: '## #/#',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var maskFormatter2 = MaskTextInputFormatter(
      mask: '### #/#',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final crearPruduccionPro = Provider.of<CreProducProv>(context);
    final tipoVentana = Provider.of<TipoVentana>(context);
    return WillPopScope(
        onWillPop: (() async {
          return false;
        }),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            automaticallyImplyLeading: false,
            title: const Center(
              child: Text(
                'Nueva Producción',
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    CupertinoSwitch(
                        value: valueI,
                        onChanged: ((value) => setState(() {
                              valueI = value;
                            }))),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            child: TextFormField(
                              controller: myController1,
                              inputFormatters: (value2 == false)
                                  ? [maskFormatter]
                                  : [maskFormatter2],
                              autocorrect: false,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              decoration: InputDecorations.authInputDecoration(
                                  hintText: '',
                                  labelText: 'Ancho',
                                  prefixIcon: Icons.account_balance),
                              validator: (value) {
                                return (value != null && value.length >= 6)
                                    ? null
                                    : 'La contraseña debe de ser de 6 caracteres';
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:8),
                            child: Container(
                              width: 70,
                              height: 59,
                              decoration:  BoxDecoration(
                                  color: const Color.fromARGB(255, 238, 238, 238),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Column(
                                children: [
                                  const Text('100 1/2',style: TextStyle(color: Colors.grey,),),
                                  CupertinoSwitch(
                                      value: value2,
                                      onChanged: ((value) => setState(() {
                                            value2 = value;
                                          }))),
                                ],
                              ),
                            ),
                          ),
                        ],
                        // ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            child: TextFormField(
                              controller: myController2,
                              inputFormatters: (value3 == false)
                                  ? [maskFormatter]
                                  : [maskFormatter2],
                              autocorrect: false,
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              decoration: InputDecorations.authInputDecoration(
                                  hintText: '',
                                  labelText: 'Alto',
                                  prefixIcon: Icons.lock_outline),
                              validator: (value) {
                                return (value != null && value.length >= 6)
                                    ? null
                                    : 'La contraseña debe de ser de 6 caracteres';
                              },
                            ),
                          ),
                           Padding(
                             padding: const EdgeInsets.only(left:8),
                            child: Container(
                              width: 70,
                              height: 59,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 238, 238, 238),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Column(
                                children: [
                                  const Text('100 1/2',style: TextStyle(color: Colors.grey,),),
                                  CupertinoSwitch(
                                      value: value3,
                                      onChanged: ((value) => setState(() {
                                            value3 = value;
                                          }))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      //      CupertinoSwitch(
                      // value: value2,
                      // onChanged: ((value) => setState(() {
                      //       value2 = value;
                      //     }))),
                    ),
                    //   ],
                    // ),

                    CupertinoButton(
                      color: CupertinoColors.activeBlue,
                      disabledColor: Colors.grey,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      onPressed: (() {
                        if (tipoVentana.indexTipo == 0) {
                          crearPruduccionPro.addTradi(
                            crearPruduccionPro.converFracDesim(
                                myController1.text, value2),
                            crearPruduccionPro.converFracDesim(
                                myController2.text, value2),
                            (valueI == false) ? 0 : 1,
                          );
                        } else if (tipoVentana.indexTipo == 1) {
                          crearPruduccionPro.addP65(
                              crearPruduccionPro.converFracDesim(
                                  myController1.text, value2),
                              crearPruduccionPro.converFracDesim(
                                  myController2.text, value2));
                        } else if (tipoVentana.indexTipo == 2) {
                          crearPruduccionPro.addP90(
                              crearPruduccionPro.converFracDesim(
                                  myController1.text, value2),
                              crearPruduccionPro.converFracDesim(
                                  myController2.text, value2));
                        }

                        // crearPruduccionPro.prin();
                      }),
                      child: const Text('Ver Data'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CupertinoButton(
                      color: CupertinoColors.activeBlue,
                      disabledColor: Colors.grey,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      onPressed: (() {
                        // crearPruduccionPro.init();
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {
                              return FadeTransition(
                                  opacity: animation1,
                                  child: ProduTerminada(
                                    nuPro: crearPruduccionPro.coutProduc(),
                                  ));
                            },
                          ),
                        );
                        // Navigator.pushReplacementNamed(context, 'produTerminada');
                      }),
                      child: const Text('Guardar'),
                    ),
                    // Container(
                    //   width: 85,
                    //   height: 45,
                    //   color: Colors.deepPurpleAccent,
                    // ),
                    const CardProduccPrimary(),
                  ],
                )),
          ),
        ));
  }
}

class CardProduccPrimary extends StatelessWidget {
  const CardProduccPrimary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crearPruduccionPro = Provider.of<CreProducProv>(context);
    crearPruduccionPro.prin();
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (crearPruduccionPro.coutProduc() == 0)
            ? 0
            : crearPruduccionPro
                .coutVentanaByPro(crearPruduccionPro.coutProduc()),
        shrinkWrap: true,
        itemBuilder: (context, index) => (Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 238, 238),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (crearPruduccionPro
                                    .creProducProv[
                                        crearPruduccionPro.coutProduc()]
                                    .items[index]
                                    .cabezalArferza![0]
                                    .valor2 ==
                                0
                            ? '2 Vi'
                            : '3 Vi'),
                        style: const TextStyle(fontSize: 18),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${crearPruduccionPro.toFracc(crearPruduccionPro.creProducProv[crearPruduccionPro.coutProduc()].items[index].ancho!)} x ${crearPruduccionPro.toFracc(crearPruduccionPro.creProducProv[crearPruduccionPro.coutProduc()].items[index].alto!)}",
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 87, 87, 87)),
                          ),
                          const Text(
                            'Fantino, destra',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w100,
                                color: Color.fromARGB(255, 153, 145, 145)),
                          ),
                        ],
                      ),
                      CupertinoButton(
                        color: CupertinoColors.activeBlue,
                        disabledColor: Colors.grey,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 15),
                        onPressed: (() {
                          crearPruduccionPro.deleteVentana(
                              crearPruduccionPro.coutProduc(),
                              crearPruduccionPro
                                  .creProducProv[
                                      crearPruduccionPro.coutProduc()]
                                  .items[index]
                                  .idVentana);
                        }),
                        child: const Icon(
                          CupertinoIcons.delete,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
