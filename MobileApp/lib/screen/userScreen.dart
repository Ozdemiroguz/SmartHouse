import 'package:flutter/material.dart';

void main() {
  runApp(UserInfo());
}


class UserInfo extends StatefulWidget {
  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kullanıcı Bilgileri'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Kullanıcı Adı: ',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'E-posta:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: (){},
                child: Text('Kullanıcıyı Değiştir'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
