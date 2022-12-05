import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:industrial/screens/pdfpreview.dart';
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
    double width = MediaQuery.of(context).size.width;
    return SliverAppBar(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      leading: CupertinoButton(
        disabledColor: const Color.fromARGB(255, 226, 225, 225),
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
        SizedBox(
          width: 60,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoButton(
                color: const Color.fromARGB(181, 21, 22, 22),
                disabledColor: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
                onPressed: (() async {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return FadeTransition(
                            opacity: animation1,
                            child: PdfPreviewPage(
                                invoice: crPruProv.creProducProv[nuPro],nuPro: nuPro));
                      },
                    ),
                  );
                }),
                child: const Text(
                  'PDF',
                  style: TextStyle(
                      color: Color.fromARGB(255, 252, 247, 247), fontSize: 16),
                )),
          ),
        ),
        SizedBox(
          width: 100,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoButton(
                color: const Color.fromARGB(181, 21, 22, 22),
                disabledColor: Colors.grey,
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
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
                child: const Text(
                  'Detalles',
                  style: TextStyle(
                      color: Color.fromARGB(255, 252, 247, 247), fontSize: 16),
                )),
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
                // right: 1,
                child: Padding(
              padding: EdgeInsets.only(left: width * 0.50, top: 27, bottom: 27),
              child: Image.asset("assets/images/window.png"),
            )),
            Positioned(
              left: 20,
              bottom: 30,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${crPruProv.creProducProv[nuPro].tipoVentana}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 63, 61, 61),
                          fontSize: 20),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '${crPruProv.creProducProv[nuPro].fecha} ',
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
                    Text(
                      'Dirección:  ${crPruProv.creProducProv[nuPro].direccion!}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 68, 64, 64),
                          fontSize: 15),
                    ),
                    Text(
                      'Tel: ${crPruProv.creProducProv[nuPro].telefono}',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 68, 64, 64),
                          fontSize: 15),
                    ),
                  ]),
            ),
            // const DecoratedBox(
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       begin: Alignment(0.0, 0.5),
            //       end: Alignment.center,
            //       colors: <Color>[
            //         Color.fromARGB(108, 255, 255, 255),
            //         Color.fromARGB(55, 255, 255, 255),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
