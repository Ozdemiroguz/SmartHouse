import 'package:flutter/material.dart';
import '../models/color.dart';
import 'home.dart';
import 'userScreen.dart';
import 'package:get/get.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color darkBack=ColorConverter.hexToColor("49108B");
    Color softBack=ColorConverter.hexToColor("7E30E1");
    Color pink=ColorConverter.hexToColor("E26EE5");
    return GetBuilder<BottomNavigationController>(
        init: BottomNavigationController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              body: IndexedStack(
                index: 0,
                children: [
                  [
                    HomePage(),
                    HomePage(),
                    UserInfo(),

                  ][controller.index]
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                elevation: 25,
                currentIndex: controller.index,
                onTap: controller.setIndex,
                selectedLabelStyle: TextStyle(fontSize: 1),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                  items: [

                  BottomNavigationBarItem(

                    icon: Icon(Icons.home),
                    label: 'a',
                    backgroundColor:softBack,

                  ),

                  BottomNavigationBarItem(
                    icon: Icon(Icons.verified_user),
                    label: '',

                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.signal_cellular_alt),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: '',
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class BottomNavigationController extends GetxController {
  int index = 0;
  var value = 20.0.obs;

  void setIndex(int index) {
    this.index = index;
    update();
  }

  void setValue(double value) {
    this.value.value = value;
  }
}