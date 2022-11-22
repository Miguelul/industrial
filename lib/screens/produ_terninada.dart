// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:industrial/models/pruduccion.dart';
import 'package:industrial/screens/home_screen.dart';
import 'package:industrial/screens/screens.dart';
import 'package:provider/provider.dart';

import '../providers/cre_produ_prov.dart';
import '../widgets/addbar_termina.dart';

class ProduTerminada extends StatefulWidget {
  final int nuPro;
  final double contVen;
  const ProduTerminada({required this.nuPro, required this.contVen ,super.key});

  @override
  State<ProduTerminada> createState() => _ProduTerminadaState();
}

class _ProduTerminadaState extends State<ProduTerminada>
    with TickerProviderStateMixin {
  bool? estado = false;
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 6, vsync: this);
    // final crPruProv = Provider.of<CreProducProv>(context);
    // double height =
    //     0; //crPruProv.coutVentanaByPro(widget.nuPro).toDouble()! * 100;

    print(widget.contVen);
    // return FutureBuilder(
    //     future: crPruProv.init(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(child: CircularProgressIndicator());
    //       } else {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          AppBarD(nuPro: widget.nuPro),
    SliverPersistentHeader(
            delegate: MySliverPersistentHeaderDelegate(
              child: Container(
                color: Colors.white,
                height: 55,
                child: TabBar(
                    controller: tabController,
                    isScrollable: true,
                    labelColor: const Color.fromARGB(255, 0, 0, 0),
                    labelPadding: const EdgeInsets.only(left: 20, right: 20),
                    unselectedLabelColor:
                        const Color.fromARGB(255, 104, 104, 104),
                    indicator:
                        CircleTabIndicator(color: Colors.black, radius: 3),
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
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: widget.contVen*100,
              child: TabBarView(controller: tabController, children: [
                CardProduTerm(
                  select: 1,
                  select3: 10,
                  select2: 2,
                  nuPro: widget.nuPro,
                  estado: estado!,
                ),
                CardProduTerm(
                    select: 3,
                    select3: 10,
                    select4: 15,
                    nuPro: widget.nuPro,
                    estado: estado!),
                CardProduTerm(
                    select: 4,
                    select3: 11,
                    select4: 16,
                    nuPro: widget.nuPro,
                    estado: estado!),
                CardProduTerm(
                    select: 5,
                    select3: 12,
                    select2: 9,
                    select4: 17,
                    nuPro: widget.nuPro,
                    estado: estado!),
                CardProduTerm(
                    select: 6,
                    select3: 13,
                    select4: 18,
                    nuPro: widget.nuPro,
                    estado: estado!),
                CardProduTerm(
                    select: 7,
                    select3: 14,
                    select4: 19,
                    select2: 8,
                    nuPro: widget.nuPro,
                    estado: estado!),
              ]),
            ),
          ),

        ],
      ),
    );
  }
}

class CardProduTerm extends StatefulWidget {
  final int nuPro;
  bool estado;
  final int? select, select2, select3, select4;
  CardProduTerm({
    required this.select,
    required this.estado,
    this.select2,
    this.select3,
    this.select4,
    required this.nuPro,
    Key? key,
  }) : super(key: key);

  @override
  State<CardProduTerm> createState() => _CardProduTermState();
}

class _CardProduTermState extends State<CardProduTerm> {
  @override
  Widget build(BuildContext context) {
    final crPruProv = Provider.of<CreProducProv>(context);
    return ListView.builder(
        itemCount: crPruProv.coutVentanaByPro(widget.nuPro),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // index = index1 - 1;
          widget.estado =
              ((crPruProv.verDeglose(widget.select3!, widget.nuPro, index)) ==
                      0)
                  ? false
                  : true;
          return (Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 238, 238),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          (crPruProv.creProducProv[widget.nuPro].items[index]
                                      .cabezalArferza![0].valor2 ==
                                  0
                              ? ''
                              : ' 3 Vi  '),
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 87, 87, 87)),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${crPruProv.toFracc(crPruProv.verDeglose(widget.select!, widget.nuPro, index))}',
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 87, 87, 87)),
                                ),
                                Text(
                                  (widget.select2 == 2)
                                      ? '  x  ' +
                                          crPruProv.toFracc(
                                              crPruProv.verDeglose(
                                                  widget.select2!,
                                                  widget.nuPro,
                                                  index))
                                      : (widget.select2 == 8)
                                          ? '  x  ' +
                                              crPruProv.toFracc(
                                                  crPruProv.verDeglose(
                                                      widget.select2!,
                                                      widget.nuPro,
                                                      index))
                                          : '',
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 87, 87, 87)),
                                ),
                              ],
                            ),
                            (crPruProv.creProducProv[widget.nuPro].items[index]
                                            .cabezalArferza![0].valor2 !=
                                        0 &&
                                    widget.select == 5)
                                ? Text(
                                    '${crPruProv.toFracc(crPruProv.verDeglose(widget.select2!, widget.nuPro, index))}',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 87, 87, 87)),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const Spacer(),
                        (widget.select != 1)
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Checkbox(
                                  value: widget.estado,
                                  onChanged: (value) {
                                    switch (widget.select) {
                                      case 3:
                                        crPruProv.updateLateral(
                                            LisPropiVen(
                                                crPruProv.verDeglose(
                                                    widget.select!,
                                                    widget.nuPro,
                                                    index),
                                                (value!) ? 1 : 0,
                                                crPruProv.verDeglose(
                                                    widget.select4!,
                                                    widget.nuPro,
                                                    index)),
                                            widget.nuPro,
                                            index,
                                            (value) ? 1 : 0);

                                        break;
                                      case 4:
                                        crPruProv.updateRiel(
                                            LisPropiVen(
                                                crPruProv.verDeglose(
                                                    widget.select!,
                                                    widget.nuPro,
                                                    index),
                                                (value!) ? 1 : 0,
                                                crPruProv.verDeglose(
                                                    widget.select4!,
                                                    widget.nuPro,
                                                    index)),
                                            widget.nuPro,
                                            index,
                                            (value) ? 1 : 0);

                                        break;
                                      case 5:
                                        crPruProv.updateAlfer(
                                            LisPropiVen(
                                                crPruProv.verDeglose(
                                                    widget.select!,
                                                    widget.nuPro,
                                                    index),
                                                (value!) ? 1 : 0,
                                                crPruProv.verDeglose(
                                                    widget.select4!,
                                                    widget.nuPro,
                                                    index)),
                                            widget.nuPro,
                                            index,
                                            (value) ? 1 : 0);

                                        break;
                                      case 6:
                                        crPruProv.updateLlavi(
                                            LisPropiVen(
                                                crPruProv.verDeglose(
                                                    widget.select!,
                                                    widget.nuPro,
                                                    index),
                                                (value!) ? 1 : 0,
                                                crPruProv.verDeglose(
                                                    widget.select4!,
                                                    widget.nuPro,
                                                    index)),
                                            widget.nuPro,
                                            index,
                                            (value) ? 1 : 0);

                                        break;
                                      case 7:
                                        crPruProv.updateCrital(
                                            LisPropiVen(
                                                crPruProv.verDeglose(
                                                    widget.select!,
                                                    widget.nuPro,
                                                    index),
                                                (value!) ? 1 : 0,
                                                crPruProv.verDeglose(
                                                    widget.select4!,
                                                    widget.nuPro,
                                                    index)),
                                            widget.nuPro,
                                            index,
                                            (value) ? 1 : 0);
                                        break;
                                    }
                                  },
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
        });
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

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  MySliverPersistentHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Positioned.fill(
          top: 0 - shrinkOffset,
          child: Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: child,
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 54;

  @override
  double get minExtent => 54;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
