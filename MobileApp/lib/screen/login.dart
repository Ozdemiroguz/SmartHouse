import 'package:untitled5/screen/BottomNavigationScreen.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:untitled5/Info.dart';
import 'package:untitled5/screen/home.dart';
import 'package:untitled5/screen/signup.dart';
import 'package:untitled5/services/infoServices.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
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
      home: const login(title: 'Flutter Demo Home Page'),
    );
  }
}

class login extends StatefulWidget {
  const login({super.key, required this.title});



  final String title;

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
   var formKey=GlobalKey<FormState>();
   var  tfuserName=TextEditingController();
   var tfPassword=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:Center(

        child: SingleChildScrollView(
          child: Column(
              children: [
                SizedBox(
                    height:150,
                    child: Image.asset("images/loginlogo.png",)),
                const Text("Smart Home",style: TextStyle(fontSize: 36),),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 45.0,right: 45,bottom: 15),
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              controller: tfuserName,
                              decoration: const InputDecoration(
                                labelText: "Username",
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
                              decoration: const InputDecoration(
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
                          child: SizedBox(height: 40,
                            child: ElevatedButton(onPressed: () async {
                              var user= await getUser("email");
                              // UserProvider'ı al
                              UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

                              // UserProvider üzerinden kullanıcı bilgilerini sakla
                              userProvider.updateUser(user);

                              // Bilgileri aldıktan sonra istediğiniz sayfaya yönlendirme yapabilirsiniz
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) => BottomNavigationScreen(), // Kullanıcı bilgilerini göstereceğiniz sayfa
                              ),);

                              /*FutureBuilder<User>(
                                future: getUser("email"),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(child: Text('Hata: ${snapshot.error}'));
                                  } else {
                                    var user = snapshot.data!;
                                    return Navigtion
                                  }
                                },
                              ),*/

                            }, child: const Text("Sign In",style: TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: const RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(10)))
                            ),
                            ),
                          ),
                        )
                      ],
                    )
                ),
               Row(
                 mainAxisAlignment:MainAxisAlignment.center,
                   children: [
                    Text("Don't have an account?"),
                     GestureDetector(onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));
                     },
                       child:Text("Sign Up",style:TextStyle(color: Colors.deepPurpleAccent),),),
                     const SizedBox(height: 100,),
                  ],),



              ],
            )
        ),
      )
    );
  }
}


