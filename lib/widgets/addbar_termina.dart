import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cre_produ_prov.dart';
import '../screens/total_material.dart';

class AppBarD extends StatelessWidget {
  final int nuPro;
  const AppBarD({
    required this.nuPro,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crPruProv = Provider.of<CreProducProv>(context);
    return SliverAppBar(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      leading: CupertinoButton(
        disabledColor: Color.fromARGB(255, 226, 225, 225),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        padding: const EdgeInsets.all(7),
        onPressed: (() {
          Navigator.pushReplacementNamed(context, 'home');
        }),
        child: const Icon(
          CupertinoIcons.back,
          color: Color.fromARGB(255, 58, 53, 53),
          size: 25,
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35.0),
          bottomRight: Radius.circular(35.0),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CupertinoButton(
            color: Color.fromARGB(127, 212, 207, 204),
            disabledColor: Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            padding: const EdgeInsets.all(7),
            onPressed: (() {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return FadeTransition(
                        opacity: animation1,
                        child: TotalMaterial(nuPro: nuPro));
                  },
                ),
              );
            }),
            child: const Text('Detalles'),
          ),
        ),
      ],
      stretch: true,
      onStretchTrigger: () {
        // Function callback for stretch
        return Future<void>.value();
      },
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
        centerTitle: true,
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              left: 20,
              bottom: 30,
              child: Container(
                // color: Colors.grey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${crPruProv.creProducProv[nuPro].tipoVentana}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 68, 64, 64),
                            fontSize: 15),
                      ),
                      Text(
                        ' ${crPruProv.creProducProv[nuPro].fecha} ',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 68, 64, 64),
                            fontSize: 15),
                      ),
                      Text(
                        'Cliente: ${crPruProv.creProducProv[nuPro].cliente} ',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 68, 64, 64),
                            fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Direccion:  ${crPruProv.creProducProv[nuPro].direccion!}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 68, 64, 64),
                            fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Tel: ${crPruProv.creProducProv[nuPro].telefono}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 68, 64, 64),
                            fontSize: 15),
                      ),
                    ]),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, 0.5),
                  end: Alignment.center,
                  colors: <Color>[
                    Color.fromARGB(108, 255, 255, 255),
                    Color.fromARGB(55, 255, 255, 255),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
