
import 'package:flutter/material.dart';
import 'package:untitled5/screen/login.dart';
import 'package:untitled5/screen/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  signup2("","","","",1),

    );
  }
}

class signup2 extends StatefulWidget {
  final String name;
  String surname;
  String userName;
  int roomNumber;
  String password;

  signup2(this.name, this.surname, this.userName,  this.password ,this.roomNumber,);


  @override
  State<signup2> createState() => _signup2State();
}

class _signup2State extends State<signup2> {

  var formKey=GlobalKey<FormState>();
  var  tfuserName=TextEditingController();
  var tfPassword=TextEditingController();
  var tfEmail=TextEditingController();
  var tfPhone=TextEditingController();
  String? selectedRoom;
  List<String> roomOptions = [
    'Living Room',
    'Bedroom',
    'Kitchen',
    'Children Room',
    'Bathroom',
    'Home Office',
  ]; // Odaların listesi
  List<String?> selectedRooms = List.filled(5, null);

  List<TextEditingController> controllers = []; // TextEditingController listesi

  @override
  void initState() {
    super.initState();

    // Başlangıç sayısı kadar TextEditingController oluştur
    controllers = List.generate(widget.roomNumber, (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: null,
        body:Center(

          child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      height:80,
                      child: Image.asset("images/loginlogo.png",)),
                  Text("Registration process is in progress!",style: TextStyle(fontSize: 16),),
                  Form(
                    key: formKey,
                    child: Column(
                      children: List.generate(
                        5,
                            (index) => Padding(
                          padding: const EdgeInsets.only(left: 45.0, right: 45, top: 15),
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(10),
                                        )
                                    ),
                                    icon: Icon(Icons.arrow_drop_down, color: Colors.grey), // Dropdown'un başına ikon ekledik
                                    value: selectedRooms[index],
                                    items: roomOptions.map((room) {
                                      return DropdownMenuItem<String>(
                                        value: room,
                                        child: Row(
                                      children: [
                                      Icon(Icons.room),
                                      Text(room),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedRooms[index] = value;
                                      });
                                    },

                                    hint:Row(
                                      children: [
                                        Icon(Icons.room),
                                        Text("Choose Room"),
                                      ],
                                    ),

                                  ),



                        ),
                      )
                        ..add(
                        Padding(
                          padding: const EdgeInsets.only(left: 45.0, right: 45, top: 15),
                          child: TextFormField(
                            controller: tfEmail,
                            decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(Icons.mail),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            ),
                          ),
                        ),
                      )..add(
                        Padding(
                          padding: const EdgeInsets.only(left: 45.0, right: 45, top: 15),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: tfPhone,
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            ),
                          ),
                        ),
                      )
                        ..add(
                        Padding(
                          padding: const EdgeInsets.only(top:20.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom( backgroundColor: Colors.deepPurple,
                                shape: const RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(10)))),
                            onPressed: () {
                              // TODO: Implement the action when the button is pressed
                              //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>login(title: "title")),(route)=>false);
                              // Form değerlerini işleme alabilirsiniz
                              for (int i = 0; i < selectedRooms.length; i++) {
                                print('Room ${i + 1}: ${selectedRooms[i]}');
                              }
                              print('Email: ${tfEmail.text}');
                              print('Phone Number: ${tfPhone.text}');
                            },
                            child: Text("Complete Registration",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      )
                    ),
                  ),





                ],
              )
          ),
        )
    );
  }
}
/*Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 45.0,right: 45,bottom: 15),
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: tfuserName,
                                decoration: InputDecoration(
                                    labelText: "Kullanıcı Adı",
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10)
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45.0,right:45,),
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                obscureText: true,
                                controller: tfPassword,
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    prefixIcon: Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10)
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(onPressed: (){}, child: const Text("Giris",style: TextStyle(color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  shape: const RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(10)))
                              ),
                            ),
                          )
                        ],
                      )
                  ),*/

/* TextFormField(
                            controller: controllers[index],
                            decoration: InputDecoration(
                              labelText: "Room ${index + 1} name",
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            ),
                          ),*/