import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:industrial/models/pruduccion.dart';
import 'package:industrial/screens/produ_terninada.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../providers/cre_produ_prov.dart';
import '../../providers/validator_form.dart';
import '../../services/notifications_service.dart';
import '../../ui/input_decorations.dart';
import '../../widgets/cupertino_co_men.dart';

// ignore: must_be_immutable
class AfregarVentanas extends StatefulWidget {
  int? nuPro;
  AfregarVentanas({
    this.nuPro,
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
    final validatorForm = Provider.of<ValidatorForm>(context);
    final theme = Theme.of(context);
    // crearPruduccionPro.init(1);

    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
        onWillPop: (() async {
          await Navigator.pushReplacementNamed(context, 'home');
          crearPruduccionPro.estadoEditVe(0);
          myController1.text = "";
          myController2.text = "";
          return false;
        }),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            leading: CupertinoButton(
              disabledColor: const Color.fromARGB(255, 226, 225, 225),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              padding: const EdgeInsets.all(7),
              onPressed: (() async {
                await Navigator.pushReplacementNamed(context, 'home');
                myController1.text = "";
                myController2.text = "";

                crearPruduccionPro.estadoEditVe(0);
              }),
              child: const Icon(
                CupertinoIcons.back,
                color: Color.fromARGB(255, 201, 196, 196),
                size: 25,
              ),
            ),

            // automaticallyImplyLeading: false,
            title: const Text(
              'Control de Medidas',
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  color: Color.fromARGB(255, 105, 104, 104)),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(35),
                              bottomRight: Radius.circular(35))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: double.infinity,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${crearPruduccionPro.creProducProv[widget.nuPro!].cliente}          ${crearPruduccionPro.creProducProv[widget.nuPro!].tipoVentana}",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w100,
                                        color:
                                            Color.fromARGB(255, 167, 160, 160)),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Tres Vías",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w100,
                                            color: Color.fromARGB(
                                                255, 126, 117, 117)),
                                      ),
                                      CupertinoSwitch(
                                          value: valueI,
                                          onChanged: ((value) => setState(() {
                                                valueI = value;
                                              }))),
                                      const Spacer(),
                                    ],
                                  ),
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
                                    SizedBox(
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
                                                prefixIcon: CupertinoIcons
                                                    .doc_plaintext),
                                        validator: (value) {
                                          return (value!.isNotEmpty &&
                                                      value.length == 6 ||
                                                  value.length == 7 ||
                                                  value.length == 3 ||
                                                  value.length == 2 &&
                                                      value2 == false)
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
                                    SizedBox(
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
                                                prefixIcon: CupertinoIcons
                                                    .doc_plaintext),
                                        validator: (value) {
                                          return (value!.isNotEmpty &&
                                                      value.length == 6 ||
                                                  value.length == 7 ||
                                                  value.length == 3 ||
                                                  value.length == 2 &&
                                                      value3 == false)
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
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                CupertinoButton(
                                  color: theme.primaryColor,
                                  disabledColor: Colors.grey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: width * 0.075),
                                  onPressed: crearPruduccionPro
                                              .estadoEditVe(3) ==
                                          0
                                      ? () {
                                          if (validatorForm.isValidForm() ==
                                              true) {
                                            NotificationsService.showSnackbar(
                                                "Ventana Add ${crearPruduccionPro.coutVentanaByPro(widget.nuPro!) + 1}  ${myController1.text} x ${myController2.text}");
                                            if (crearPruduccionPro
                                                    .creProducProv[
                                                        widget.nuPro!]
                                                    .tipoVentana ==
                                                "Ventanas Tradicional") {
                                              crearPruduccionPro.addTradi(
                                                  crearPruduccionPro
                                                      .converFracDesim(
                                                          myController1.text,
                                                          value2),
                                                  crearPruduccionPro
                                                      .converFracDesim(
                                                          myController2.text,
                                                          value3),
                                                  (valueI == false) ? 0 : 1,
                                                  widget.nuPro!);
                                            } else if (crearPruduccionPro
                                                    .creProducProv[
                                                        widget.nuPro!]
                                                    .tipoVentana ==
                                                "Ventanas P-65") {
                                              crearPruduccionPro.addP65(
                                                  crearPruduccionPro
                                                      .converFracDesim(
                                                    myController1.text,
                                                    value2,
                                                  ),
                                                  crearPruduccionPro
                                                      .converFracDesim(
                                                          myController2.text,
                                                          value3),
                                                  (valueI == false) ? 0 : 1,
                                                  widget.nuPro!);
                                            } else if (crearPruduccionPro
                                                    .creProducProv[
                                                        widget.nuPro!]
                                                    .tipoVentana ==
                                                "Ventanas P-92") {
                                              crearPruduccionPro.addP92(
                                                  crearPruduccionPro
                                                      .converFracDesim(
                                                          myController1.text,
                                                          value2),
                                                  crearPruduccionPro
                                                      .converFracDesim(
                                                          myController2.text,
                                                          value3),
                                                  (valueI == false) ? 0 : 1,
                                                  widget.nuPro!);
                                            }
                                            myController1.text = "";
                                            myController2.text = "";
                                          }
                                        }
                                      : () {
                                          if (validatorForm.isValidForm() ==
                                              true) {
                                            if (crearPruduccionPro
                                                    .creProducProv[
                                                        widget.nuPro!]
                                                    .tipoVentana ==
                                                "Ventanas Tradicional") {
                                              crearPruduccionPro.updateVentana(
                                                  Ventana(
                                                      idProduccion:
                                                          crearPruduccionPro
                                                              .ventaTemp
                                                              .idProduccion,
                                                      idVentana: crearPruduccionPro
                                                          .ventaTemp.idVentana,
                                                      cantidaVia:
                                                          (valueI == false)
                                                              ? 0
                                                              : 1,
                                                      ancho: crearPruduccionPro
                                                          .converFracDesim(
                                                              myController1
                                                                  .text,
                                                              value2),
                                                      alto: crearPruduccionPro.converFracDesim(
                                                          myController2.text,
                                                          value3)),
                                                  crearPruduccionPro
                                                      .creProducProv[widget.nuPro!]
                                                      .tipoVentana!,
                                                  widget.nuPro!,
                                                  crearPruduccionPro.nuVenTemk);
                                              NotificationsService.showSnackbar(
                                                  "Ventana Editada ${crearPruduccionPro.coutVentanaByPro(widget.nuPro!) + 1}  ${myController1.text} x ${myController2.text}");
                                            } else if (crearPruduccionPro
                                                    .creProducProv[
                                                        widget.nuPro!]
                                                    .tipoVentana ==
                                                "Ventanas P-65") {
                                              crearPruduccionPro.updateVentana(
                                                  Ventana(
                                                      idProduccion:
                                                          crearPruduccionPro
                                                              .ventaTemp
                                                              .idProduccion,
                                                      idVentana: crearPruduccionPro
                                                          .ventaTemp.idVentana,
                                                      cantidaVia:
                                                          (valueI == false)
                                                              ? 0
                                                              : 1,
                                                      ancho: crearPruduccionPro
                                                          .converFracDesim(
                                                              myController1
                                                                  .text,
                                                              value2),
                                                      alto: crearPruduccionPro.converFracDesim(
                                                          myController2.text,
                                                          value3)),
                                                  crearPruduccionPro
                                                      .creProducProv[widget.nuPro!]
                                                      .tipoVentana!,
                                                  widget.nuPro!,
                                                  crearPruduccionPro.nuVenTemk);
                                              NotificationsService.showSnackbar(
                                                  "Ventana Editada ${crearPruduccionPro.coutVentanaByPro(widget.nuPro!) + 1}  ${myController1.text} x ${myController2.text}");
                                            } else if (crearPruduccionPro
                                                    .creProducProv[
                                                        widget.nuPro!]
                                                    .tipoVentana ==
                                                "Ventanas P-92") {
                                              crearPruduccionPro.updateVentana(
                                                  Ventana(
                                                      idProduccion:
                                                          crearPruduccionPro
                                                              .ventaTemp
                                                              .idProduccion,
                                                      idVentana: crearPruduccionPro
                                                          .ventaTemp.idVentana,
                                                      cantidaVia:
                                                          (valueI == false)
                                                              ? 0
                                                              : 1,
                                                      ancho: crearPruduccionPro
                                                          .converFracDesim(
                                                              myController1
                                                                  .text,
                                                              value2),
                                                      alto: crearPruduccionPro.converFracDesim(
                                                          myController2.text,
                                                          value3)),
                                                  crearPruduccionPro
                                                      .creProducProv[widget.nuPro!]
                                                      .tipoVentana!,
                                                  widget.nuPro!,
                                                  crearPruduccionPro.nuVenTemk);
                                              NotificationsService.showSnackbar(
                                                  "Ventana Editada ${crearPruduccionPro.coutVentanaByPro(widget.nuPro!) + 1}  ${myController1.text} x ${myController2.text}");
                                            }

                                            setState(() {
                                              crearPruduccionPro
                                                  .estadoEditVe(0);
                                            });
                                            myController1.text = "";
                                            myController2.text = "";
                                          }
                                        },
                                  child: Text(
                                      (crearPruduccionPro.estadoEditVe(3) == 0)
                                          ? 'Add Medidas'
                                          : 'Guardar Edicion'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CupertinoButton(
                                  color: theme.primaryColor,
                                  disabledColor: Colors.grey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 13, horizontal: width * 0.06),
                                  onPressed: (() async {
                                    if (crearPruduccionPro
                                            .coutVentanaByPro(widget.nuPro!) !=
                                        0) {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return FadeTransition(
                                                opacity: animation1,
                                                child: ProduTerminada(
                                                  nuPro: widget.nuPro!,
                                                  contVen: crearPruduccionPro
                                                      .coutVentanaByPro(
                                                          widget.nuPro!)
                                                      .toDouble(),
                                                ));
                                          },
                                        ),
                                      );
                                    } else {
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: const Text("Aviso"),
                                            content: const Text(
                                                "Tienes que añadir minimo una medida"),
                                            actions: [
                                              CupertinoDialogAction(
                                                  child: const Text("OK"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }),
                                  child: const Text('Ver Deglose'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text("Todas las Medidas",
                        style: TextStyle(
                            fontWeight: FontWeight.w100,
                            color: Color.fromARGB(255, 126, 117, 117))),
                    const SizedBox(
                      height: 7,
                    ),
                    CardProduccPrimary(
                      nuPro: widget.nuPro!,
                      myController1: myController1,
                      myController2: myController2,
                    ),
                  ],
                )),
          ),
        ));
  }
}

// ignore: must_be_immutable
class CardProduccPrimary extends StatelessWidget {
  TextEditingController? myController1, myController2;
  int nuPro;
  CardProduccPrimary({
    required this.nuPro,
    this.myController1,
    this.myController2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crearPruduccionPro = Provider.of<CreProducProv>(context);
    final theme = Theme.of(context);
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: crearPruduccionPro.coutVentanaByPro(nuPro),
        shrinkWrap: true,
        itemBuilder: (context, index) => (Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 9),
              child: Stack(children: [
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 238, 238),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          " ${index + 1} ",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 87, 87, 87)),
                        ),
                        const VerticalDivider(
                          width: 15,
                          thickness: 1,
                          color: Color.fromARGB(255, 87, 87, 87),
                          indent: 1,
                          endIndent: 1,
                        ),
                        Text(
                          (crearPruduccionPro.creProducProv[nuPro].items[index]
                                      .cantidaVia ==
                                  0
                              ? '2 Vi  '
                              : '3 Vi  '),
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 87, 87, 87)),
                        ),
                        Text(
                          "${crearPruduccionPro.toFracc(crearPruduccionPro.creProducProv[nuPro].items[index].ancho!)} x ${crearPruduccionPro.toFracc(crearPruduccionPro.creProducProv[nuPro].items[index].alto!)}",
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 87, 87, 87)),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 1,
                  top: 1,
                  bottom: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                      // color: Colors.red,
                      width: 60,
                      height: 70,
                      child: CupertinoContextMenu2M(
                          actions: [
                            CupertinoContextMenuAction(
                              onPressed: () {
                                Navigator.of(context).pop();
                                myController1!.text = (crearPruduccionPro
                                    .toFracc(crearPruduccionPro
                                        .creProducProv[nuPro]
                                        .items[index]
                                        .ancho!)
                                    .toString());
                                myController2!.text = (crearPruduccionPro
                                    .toFracc(crearPruduccionPro
                                        .creProducProv[nuPro]
                                        .items[index]
                                        .alto!)
                                    .toString());
                                crearPruduccionPro.pushventanainta(
                                    crearPruduccionPro
                                        .creProducProv[nuPro].items[index],
                                    index);
                                crearPruduccionPro.estadoEditVe(1);
                              },
                              trailingIcon: CupertinoIcons.pencil,
                              child: const Text("Editar"),
                            ),
                            CupertinoContextMenuAction(
                              onPressed: () {
                                Navigator.of(context).pop();

                                NotificationsService.showSnackbar(
                                    "Ventana Eliminda ${crearPruduccionPro.toFracc(crearPruduccionPro.creProducProv[nuPro].items[index].ancho!)} x ${crearPruduccionPro.toFracc(crearPruduccionPro.creProducProv[nuPro].items[index].alto!)}");

                                crearPruduccionPro.deleteVentana(
                                    nuPro,
                                    crearPruduccionPro.creProducProv[nuPro]
                                        .items[index].idVentana);
                              },
                              isDestructiveAction: true,
                              trailingIcon: CupertinoIcons.delete,
                              child: const Text("Eliminar"),
                            )
                          ],
                          child: Container(
                            height: 20,
                            width: 50,
                            color: const Color.fromARGB(0, 0, 0, 0),
                            child: Icon(CupertinoIcons.ellipsis_vertical,
                                color: theme.primaryColor, size: 28),
                          )),
                    ),
                  ),
                ),
              ]),
            )));
  }
}
