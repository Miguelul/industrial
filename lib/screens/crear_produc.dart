import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import '../models/pruduccion.dart';
import '../providers/cre_produ_prov.dart';
import '../providers/cre_ventana.dart';
import '../ui/input_decorations.dart';

class CrearProduccion extends StatefulWidget {
  const CrearProduccion({Key? key}) : super(key: key);

  @override
  State<CrearProduccion> createState() => _CrearProduccionState();
}

class _CrearProduccionState extends State<CrearProduccion> {
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
      mask: '###-###-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final crearPruduccionPro = Provider.of<CreProducProv>(context);
    final tipoVentana = Provider.of<TipoVentana>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Center(
          child: Text(
            'Nueva Producción',
            style: TextStyle(
                fontWeight: FontWeight.w100,
                color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ),
      body:  Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(children: [
              Text(tipoVentana.indexTipo == 0 ? tipoVentana.ventanasD[0].nombre:
               tipoVentana.indexTipo == 1 ? tipoVentana.ventanasD[1].nombre:
               tipoVentana.indexTipo == 2 ? tipoVentana.ventanasD[2].nombre:''),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: myController,
                  autocorrect: false,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: '',
                      labelText: 'Nombre del Cliente',
                      prefixIcon: Icons.lock_outline),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: myController2,
                  autocorrect: false,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: '',
                      labelText: 'Dirección',
                      prefixIcon: Icons.lock_outline),
                  validator: (value) {
                    return (value != null && value.length >= 6)
                        ? null
                        : 'La contraseña debe de ser de 6 caracteres';
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  inputFormatters: [maskFormatter],
                  controller: myController3,
                  autocorrect: false,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: '',
                      labelText: 'Telefono',
                      prefixIcon: Icons.lock_outline),
                ),
              ),
              CupertinoButton(
                color: CupertinoColors.activeBlue,
                disabledColor: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                onPressed: (() {
                  if (tipoVentana.indexTipo == 0) {
                    crearPruduccionPro.addVentana(ProduccionCre(
                        tipoVentana: tipoVentana.ventanasD[0].nombre,
                        id: crearPruduccionPro.cout(),
                        cliente: myController.text,
                        direccion: myController2.text,
                        telefono: myController3.text,
                        items: []));
                  } else if (tipoVentana.indexTipo == 1) {
                    crearPruduccionPro.addVentana(ProduccionCre(
                        tipoVentana: tipoVentana.ventanasD[1].nombre,
                        id: crearPruduccionPro.cout(),
                        cliente: myController.text,
                        direccion: myController2.text,
                        telefono: myController3.text,
                        items: []));
                  }else if (tipoVentana.indexTipo == 2) {
                    crearPruduccionPro.addVentana(ProduccionCre(
                        tipoVentana: tipoVentana.ventanasD[2].nombre,
                        id: crearPruduccionPro.cout(),
                        cliente: myController.text,
                        direccion: myController2.text,
                        telefono: myController3.text,
                        items: []));
                  }

                  crearPruduccionPro.prin();
                  Navigator.pushReplacementNamed(context, 'agregarVentana');
                }),
                child: const Text('Siguiente'),
              ),
              const SizedBox(
                height: 15,
              ),
              // CupertinoButton(
              //   child: Text('Ver Data'),
              //   color: CupertinoColors.activeBlue,
              //   disabledColor: Colors.grey,
              //   borderRadius: BorderRadius.all(Radius.circular(15)),
              //   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              //   onPressed: (() {}),
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              // ElevatedButton.icon(
              //     onPressed: (() {
              //       // creProducProv.input = myController.text;
              //       Navigator.pushReplacementNamed(context, 'home');
              //     }),
              //     icon: Icon(Icons.backpack),
              //     label: Text('Atrás')),
            ]),
          ),
        ),
      ),
    );
  }
}
