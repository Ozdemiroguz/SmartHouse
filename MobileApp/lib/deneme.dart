import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Kullanıcı adları
  List<String> userNames = ['User1', 'User2', 'User3'];

  // Başlangıçta seçili olan kullanıcı adı
  String selectedUserName = 'User1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kullanıcı Menüsü'),
      ),
      body: Column(
        children: [
          // Kullanıcı adlarını gösteren kısmı oluşturun
          Container(
            height: 50,
            color: Colors.grey,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: userNames.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Kullanıcı adına tıklandığında ilgili ekranı açın
                    setState(() {
                      selectedUserName = userNames[index];
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: selectedUserName == userNames[index]
                        ? Colors.blue
                        : Colors.grey,
                    child: Text(
                      userNames[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Seçili kullanıcının ekranını gösteren kısmı oluşturun
          Expanded(
            child: Center(
              child: Text(
                'Ekran: $selectedUserName',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
