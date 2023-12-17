import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: odalar.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Odalar'),
          ),
          body: Column(
            children: <Widget>[
              Container(
                child: TabBar(
                  isScrollable: true,
                  tabs: odalar.map((Oda oda) => Tab(text: oda.isim)).toList(),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: odalar.map((Oda oda) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: OdaDetay(oda: oda),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Oda {
  final String isim;
  final String detay;

  Oda(this.isim, this.detay);
}

final List<Oda> odalar = <Oda>[
  Oda('Oda 1', 'Oda 1 detayları...'),
  Oda('Oda 2', 'Oda 2 detayları...'),
  Oda('Oda 2', 'Oda 2 detayları...'),
  Oda('Oda 2', 'Oda 2 detayları...'),

  // Diğer odalar...
];

class OdaDetay extends StatelessWidget {
  const OdaDetay({Key? key,required this.oda}) : super(key: key);

  final Oda oda;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(oda.isim),
            subtitle: Text(oda.detay),
          ),
        ],
      ),
    );
  }
}
