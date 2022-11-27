import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:industrial/screens/produ_terninada.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../providers/cre_produ_prov.dart';
import '../providers/cre_ventana.dart';
import '../providers/validator_form.dart';
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
    final validatorForm = Provider.of<ValidatorForm>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: (() async {
          return false;
        }),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            automaticallyImplyLeading: false,
            title: const Center(
              child: Text(
                'Agregar Medidas',
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
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),

                          Container(
                            width: double.infinity,
                            height: 71,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(6)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              child: Row(
                                children: [
                                  // Spacer(),
                                  const Text(
                                    "Tres Vias",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  CupertinoSwitch(
                                      value: valueI,
                                      onChanged: ((value) => setState(() {
                                            valueI = value;
                                          }))),
                                  const Spacer(),
                                ],
                                // ),
                              ),
                            ),
                          ),

                          Form(
                            key: validatorForm.formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 20),
                              child: Column(
                                children: [
                                  Stack(children: [
                                    Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: myController1,
                                        inputFormatters: (value2 == false)
                                            ? [maskFormatter]
                                            : [maskFormatter2],
                                        autocorrect: false,
                                        obscureText: false,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecorations
                                            .authInputDecoration(
                                                hintText: '',
                                                labelText: 'Ancho',
                                                prefixIcon:
                                                    Icons.account_box_outlined),
                                        validator: (value) {
                                          return (value!.isNotEmpty &&
                                                      value.length == 6 ||
                                                  value.length == 7 ||
                                                  value.length == 3 ||
                                                  value.length == 2)
                                              ? null
                                              : 'Revise la Medida';
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: 2,
                                      right: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: CupertinoSwitch(
                                            value: value2,
                                            onChanged: ((value) => setState(() {
                                                  myController1.text = "";
                                                  value2 = value;
                                                }))),
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Stack(children: [
                                    Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: myController2,
                                        inputFormatters: (value3 == false)
                                            ? [maskFormatter]
                                            : [maskFormatter2],
                                        autocorrect: false,
                                        obscureText: false,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecorations
                                            .authInputDecoration(
                                                hintText: '',
                                                labelText: 'Alto',
                                                prefixIcon: Icons.lock_outline),
                                        validator: (value) {
                                          return (value!.isNotEmpty &&
                                                      value.length == 6 ||
                                                  value.length == 7 ||
                                                  value.length == 3 ||
                                                  value.length == 2)
                                              ? null
                                              : 'Revise la Medida';
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: 2,
                                      right: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: CupertinoSwitch(
                                            value: value3,
                                            onChanged: ((value) => setState(() {
                                                  myController2.text = "";
                                                  value3 = value;
                                                }))),
                                      ),
                                    )
                                  ]),
                                ],
                              ),
                              //      CupertinoSwitch(
                              // value: value2,
                              // onChanged: ((value) => setState(() {
                              //       value2 = value;
                              //     }))),
                            ),
                          ),
                          //   ],
                          // ),

                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                CupertinoButton(
                                  color: CupertinoColors.activeBlue,
                                  disabledColor: Colors.grey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: width * 0.062),
                                  onPressed: (() {
                                    if (validatorForm.isValidForm() == true) {
                                      if (tipoVentana.indexTipo == 0) {
                                        crearPruduccionPro.addTradi(
                                          crearPruduccionPro.converFracDesim(
                                              myController1.text, value2),
                                          crearPruduccionPro.converFracDesim(
                                              myController2.text, value3),
                                          (valueI == false) ? 0 : 1,
                                        );
                                      } else if (tipoVentana.indexTipo == 1) {
                                        crearPruduccionPro.addP65(
                                          crearPruduccionPro.converFracDesim(
                                            myController1.text,
                                            value2,
                                          ),
                                          crearPruduccionPro.converFracDesim(
                                              myController2.text, value3),
                                          (valueI == false) ? 0 : 1,
                                        );
                                      } else if (tipoVentana.indexTipo == 2) {
                                        crearPruduccionPro.addP90(
                                            crearPruduccionPro.converFracDesim(
                                                myController1.text, value2),
                                            crearPruduccionPro.converFracDesim(
                                                myController2.text, value3));
                                      }
                                    }
                                    myController1.text = "";
                                    myController2.text = "";
                                  }),
                                  child: const Text('Add Medidas'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CupertinoButton(
                                  color: CupertinoColors.activeBlue,
                                  disabledColor: Colors.grey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: width * 0.06),
                                  onPressed: (() {
                                    showCupertinoDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: const Text("Aviso"),
                                            content: const Text(
                                                "Revisaste las medidas?"),
                                            actions: [
                                              CupertinoDialogAction(
                                                  child: const Text("YES"),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      PageRouteBuilder(
                                                        pageBuilder: (context,
                                                            animation1,
                                                            animation2) {
                                                          return FadeTransition(
                                                              opacity:
                                                                  animation1,
                                                              child:
                                                                  ProduTerminada(
                                                                nuPro: crearPruduccionPro
                                                                    .coutProduc(),
                                                                contVen: crearPruduccionPro
                                                                    .coutVentanaByPro(
                                                                        crearPruduccionPro
                                                                            .coutProduc())
                                                                    .toDouble(),
                                                              ));
                                                        },
                                                      ),
                                                    );
                                                  }),
                                              CupertinoDialogAction(
                                                  child: const Text("NO"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  })
                                            ],
                                          );
                                        });
                                  }),
                                  child: const Text('Guardar'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text("Todas las Medidad"),
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

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (crearPruduccionPro
                .coutVentanaByPro(crearPruduccionPro.coutProduc()) == 0)
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
