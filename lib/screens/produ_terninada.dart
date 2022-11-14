// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:industrial/models/pruduccion.dart';
import 'package:industrial/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cre_produ_prov.dart';

class ProduTerminada extends StatefulWidget {
  final int nuPro;
  const ProduTerminada({required this.nuPro, super.key});

  @override
  State<ProduTerminada> createState() => _ProduTerminadaState();
}

class _ProduTerminadaState extends State<ProduTerminada>
    with TickerProviderStateMixin {
       bool? estado = false;
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 6, vsync: this);
    

    // return FutureBuilder(
    //     future: crPruProv.init(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return const Center(child: CircularProgressIndicator());
    //       } else {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          AppBarD(nuPro: widget.nuPro),
          SliverToBoxAdapter(
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
                CardProduTerm(select: 1, select2: 2, nuPro: widget.nuPro, estado: estado!,),
                CardProduTerm(
                    select: 3, select3: 10, select4: 15, nuPro: widget.nuPro,estado: estado!),
                CardProduTerm(
                    select: 4, select3: 11, select4: 16, nuPro: widget.nuPro, estado: estado!),
                CardProduTerm(
                    select: 5,
                    select3: 12,
                    select2: 9,
                    select4: 17,
                    nuPro: widget.nuPro, estado: estado!),
                CardProduTerm(
                    select: 6, select3: 13, select4: 18, nuPro: widget.nuPro, estado: estado!),
                CardProduTerm(
                    select: 7,
                    select3: 14,
                    select4: 19,
                    select2: 8,
                    nuPro: widget.nuPro, estado: estado!),
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
  final int nuPro;
  const AppBarD({
    required this.nuPro,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crPruProv = Provider.of<CreProducProv>(context);
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
                    children: [
                      Text(
                        'Cliente: ${crPruProv.creProducProv[nuPro].cliente} ',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Direccion:  ${crPruProv.creProducProv[nuPro].direccion!}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Tel: ${crPruProv.creProducProv[nuPro].telefono}',
                        style: const TextStyle(
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
    
    return SingleChildScrollView(
      child: ListView.builder(
          itemCount: crPruProv.coutVentanaByPro(widget.nuPro),
          shrinkWrap: true,
          itemBuilder: (context, index) {
           
            widget.estado =
                ((crPruProv.verDeglose(widget.select3!, widget.nuPro, index)) ==
                        0)
                    ? false
                    : true;
            print(widget.estado );
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
                  padding: const EdgeInsets.only(left: 20, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            (crPruProv
                                        .creProducProv[crPruProv.coutProduc()]
                                        .items[index]
                                        .cabezalArferza![0]
                                        .valor2 ==
                                    0
                                ? ' 2 Vi  '
                                : ' 3 Vi  '),
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 87, 87, 87)),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    (widget.select != 5)
                                        ? '${crPruProv.toFracc(crPruProv.verDeglose(widget.select!, widget.nuPro, index))}'
                                        : '${crPruProv.toFracc(crPruProv.verDeglose(widget.select!, widget.nuPro, index))}',
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
                              (crPruProv
                                              .creProducProv[
                                                  crPruProv.coutProduc()]
                                              .items[index]
                                              .cabezalArferza![0]
                                              .valor2 !=
                                          0 &&
                                      widget.select == 5)
                                  ? Text(
                                      '${crPruProv.toFracc(crPruProv.verDeglose(widget.select2!, widget.nuPro, index))}',
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 87, 87, 87)),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          (widget.select ==4)
                              ? Checkbox(
                                  value: widget.estado ,
                                  onChanged: (value) {
                                    switch (widget.select) {
                                      case 3:
                                        crPruProv.updateLateral(LisPropiVen(
                                            crPruProv.verDeglose(widget.select!,
                                                widget.nuPro, index),
                                            (true == widget.estado ) ? 0 : 1,
                                            crPruProv.verDeglose(
                                                widget.select4!,
                                                widget.nuPro,
                                                index)));
                                        break;
                                      case 4:
                                        crPruProv.updateRiel(LisPropiVen(
                                            crPruProv.verDeglose(widget.select!,
                                                widget.nuPro, index),
                                            (true == widget.estado ) ? 0 : 1,
                                            crPruProv.verDeglose(
                                                widget.select4!,
                                                widget.nuPro,
                                                index)));
                            
                                        break;
                                      case 5:
                                        crPruProv.updateAlfer(LisPropiVen(
                                            crPruProv.verDeglose(widget.select!,
                                                widget.nuPro, index),
                                            (true == widget.estado ) ? 0 : 1,
                                            crPruProv.verDeglose(
                                                widget.select4!,
                                                widget.nuPro,
                                                index)));
                                      
                                        break;
                                      case 6:
                                        crPruProv.updateLlavi(LisPropiVen(
                                            crPruProv.verDeglose(widget.select!,
                                                widget.nuPro, index),
                                            (true == widget.estado ) ? 0 : 1,
                                            crPruProv.verDeglose(
                                                widget.select4!,
                                                widget.nuPro,
                                                index)));
                                     
                                        break;
                                      case 7:
                                        crPruProv.updateCrital(LisPropiVen(
                                            crPruProv.verDeglose(widget.select!,
                                                widget.nuPro, index),
                                            (true == widget.estado ) ? 0 : 1,
                                            crPruProv.verDeglose(
                                                widget.select4!,
                                                widget.nuPro,
                                                index)));
                                      
                                        break;
                                    }
                                  },
                                )
                              : const SizedBox()
                        ],
                      ),
                      // Text(
                      //   '${crPruProv.toFracc(crPruProv.creProducProv[0].items[index].alto!)}',
                      //   style: TextStyle(
                      //       fontSize: 13,
                      //       fontWeight: FontWeight.w100,
                      //       color: Color.fromARGB(255, 153, 145, 145)),
                      // ),
                    ],
                  ),
                ),
              ),
            ));
          }),
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
