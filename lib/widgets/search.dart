import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:industrial/models/pruduccion.dart';

import 'package:industrial/providers/cre_produ_prov.dart';
import 'package:provider/provider.dart';

import '../screens/produ_terninada.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<ProduccionCre> _listPro = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
        itemCount: _listPro.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => (CupertinoButton(
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) {
                  return FadeTransition(
                      opacity: animation1,
                      child: ProduTerminada(
                        nuPro: index,
                      ));
                },
              ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
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
                      Text(
                        '${_listPro[index].cliente} ',
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 87, 87, 87)),
                      ),
                      Text(
                        '${_listPro[index].direccion}',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w100,
                            color: Color.fromARGB(255, 153, 145, 145)),
                      ),
                    ],
                  ),
                ),
              ),
            ))));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final crearPruduccionPro = Provider.of<CreProducProv>(context);
    int nuPro = 0;
    _listPro = crearPruduccionPro.creProducProv.where((element) {
      return element.cliente!
          .toLowerCase()
          .contains(query.trim().toLowerCase());
    }).toList();
    return ListView.builder(
        itemCount: _listPro.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return (CupertinoButton(
              onPressed: () {
                for (int index2 = 0; index2 <= crearPruduccionPro.creProducProv.length; index2++) {
                  if (crearPruduccionPro.creProducProv[index2].cliente == _listPro[index].cliente) {
                    nuPro = index2;
                    break;
                  }
                }
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return FadeTransition(
                        opacity: animation1,
                        child: ProduTerminada(
                          nuPro: nuPro,
                        ));
                  },
                ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Builder(builder: (context) {
                  return Container(
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
                          Text(
                            '${_listPro[index].cliente} ',
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 87, 87, 87)),
                          ),
                          Text(
                            '${_listPro[index].direccion}',
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w100,
                                color: Color.fromARGB(255, 153, 145, 145)),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              )));
        });
  }
}
