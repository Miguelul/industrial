// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:industrial/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cre_produ_prov.dart';

class ProduTerminada extends StatefulWidget {
  final int nuPro;
  const ProduTerminada({
   required this.nuPro, super.key});

  @override
  State<ProduTerminada> createState() => _ProduTerminadaState();
}

class _ProduTerminadaState extends State<ProduTerminada>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 6, vsync: this);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          const AppBarD(),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              height: 55,
              child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  labelColor: const Color.fromARGB(255, 0, 0, 0),
                  labelPadding: const EdgeInsets.only(left: 20, right: 20),
                  unselectedLabelColor: const Color.fromARGB(255, 104, 104, 104),
                  indicator: CircleTabIndicator(color: Colors.black, radius: 3),
                  tabs: const [
                    Tab(text: 'Medidas'),
                    Tab(
                      text: 'Laterales',
                    ),
                    Tab(
                      text: 'Cabez Riel',
                    ),
                    Tab(
                      text: 'Cabez Alferza',
                    ),
                    Tab(
                      text: 'Llavi y Enganche',
                    ),
                    Tab(
                      text: 'Cristal Ancho Alto',
                    ),
                  ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.maxFinite,
              height: 600,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: TabBarView(controller: tabController, children: [
                CardProduTerm(select: 1, select2: 2, nuPro: widget.nuPro),
                CardProduTerm(select: 3, nuPro: widget.nuPro),
                CardProduTerm(select: 4, nuPro: widget.nuPro),
                CardProduTerm(select: 5, nuPro: widget.nuPro),
                CardProduTerm(select: 6, nuPro: widget.nuPro),
                CardProduTerm(select: 7, select2: 8, nuPro: widget.nuPro),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: CupertinoButton(
              color: CupertinoColors.activeBlue,
              disabledColor: Colors.grey,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              onPressed: (() {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return FadeTransition(
                          opacity: animation1, child: const HomeScreen());
                    },
                  ),
                );
                // Navigator.push(context, ProduTerminada())
              }),
              child: const Text('Guardar'),
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarD extends StatelessWidget {
  const AppBarD({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crearPruduccionPro = Provider.of<CreProducProv>(context);
    return SliverAppBar(
      leading: CupertinoButton(
        color: CupertinoColors.activeBlue,
        disabledColor: Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        padding: const EdgeInsets.all(7),
        onPressed: (() {
          Navigator.pushReplacementNamed(context, 'home');
        }),
        child: const Icon(
          CupertinoIcons.back,
          size: 17,
        ),
      ),
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
            // Positioned(
            //   child: Image.asset(
            //     'assets/images/casa.jpg',
            //     // fit: BoxFit.cover,
            //   ),
            // ),
            Positioned(
              left: 20,
              bottom: 30,
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Cliente ',
                        // 'Cliente: ${crearPruduccionPro.creProducProv[0].cliente} ',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Direccion',
                        // 'Direccion: ${crearPruduccionPro.creProducProv[0].direccion}',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Tel 4545454545',
                        // 'Tel: ${crearPruduccionPro.creProducProv[0].telefono}',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18),
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
                    Color.fromARGB(95, 14, 13, 13),
                    Color(0x00000000),
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

class TabBarD extends StatelessWidget {
  const TabBarD({
    Key? key,
    required this.titulo,
  }) : super(
          key: key,
        );
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Text(
          titulo,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }
}

class CardProduTerm extends StatelessWidget {
  final int nuPro;
  final int? select, select2;
  const CardProduTerm({
    required this.select,
    this.select2,
    required this.nuPro,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crearPruduccionPro = Provider.of<CreProducProv>(context);

    return SingleChildScrollView(
      child: ListView.builder(
          itemCount: crearPruduccionPro.coutVentana(),
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
                    padding: const EdgeInsets.only(left: 20, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${crearPruduccionPro.toFracc(crearPruduccionPro.verDeglose(select!, nuPro, index))}',
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 87, 87, 87)),
                            ),
                            Text(
                              (select2 == 2) ? '  x  ' + crearPruduccionPro.toFracc(crearPruduccionPro.verDeglose(select2!, nuPro, index)) : (select2 == 8) ? '  x  ' + crearPruduccionPro.toFracc(crearPruduccionPro.verDeglose(select2!, nuPro, index)) : '',
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 87, 87, 87)),
                            ),
                          ],
                        ),
                        // Text(
                        //   '${crearPruduccionPro.toFracc(crearPruduccionPro.creProducProv[0].items[index].alto!)}',
                        //   style: TextStyle(
                        //       fontSize: 13,
                        //       fontWeight: FontWeight.w100,
                        //       color: Color.fromARGB(255, 153, 145, 145)),
                        // ),
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;
  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius - 5);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
