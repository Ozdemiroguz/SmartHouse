import 'package:untitled5/Info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<User>getUser(String email)async{

  //Get data from database
//with email
  var tempUser=User(1,"Oğuzhan","Özdemir","qwerty1",'',"53353535");



  return tempUser;
}
class UserProvider extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  // Kullanıcı bilgilerini güncellemek için kullanılacak metod
  void updateUser(User newUser) {
    _currentUser = newUser;
    notifyListeners();
  }

  // Kullanıcıyı null olarak ayarlamak için kullanılacak metod
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
