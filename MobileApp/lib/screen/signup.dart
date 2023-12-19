import 'package:flutter/material.dart';
import 'package:untitled5/screen/login.dart';
import 'package:untitled5/screen/signup2.dart';

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
      home: const signup(),
    );
  }
}


class signup extends StatefulWidget {


  const signup({super.key});




  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var formKey=GlobalKey<FormState>();
  var  tfuserName=TextEditingController();
  var  tfname=TextEditingController();
  var  tfsurname=TextEditingController();
  var tfPassword=TextEditingController();
  var tfconfirmPassword=TextEditingController();
  double ilerleme=1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:null,
        body:Center(

          child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  SizedBox(
                      height:50,
                      child: Image.asset("images/loginlogo.png",)),
                  Text("Smart Home",style: TextStyle(fontSize: 36),),
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 45.0,right: 45,bottom: 15),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: tfname,
                                decoration: InputDecoration(
                                    labelText: "Name",
                                    prefixIcon: Icon(Icons.person_pin),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10)
                                ),
                                validator: (tfinput){
                                  if(tfinput!.isEmpty){
                                    return "Please enter a name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ), Padding(
                            padding: const EdgeInsets.only(left: 45.0,right: 45,bottom: 15),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: tfsurname,
                                decoration: InputDecoration(
                                    labelText: "Surname",
                                    prefixIcon: Icon(Icons.person_pin),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10)
                                ),
                                validator: (tfinput){
                                  if(tfinput!.isEmpty){
                                    return "Please enter a surname";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45.0,right: 45,bottom: 15),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                controller: tfuserName,
                                decoration: InputDecoration(
                                    labelText: "Username",
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10)
                                ),
                                validator: (tfinput){
                                  if(tfinput!.isEmpty){
                                    return "Please enter a username";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ), Padding(
                            padding: const EdgeInsets.only(left: 45.0,right: 45,bottom: 15),
                            child: SizedBox(
                              height: 60,
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
                                validator: (tfinput){
                                  if(tfinput!.isEmpty){
                                    return "Please enter a password";
                                  }
                                  if(tfinput.length<6)
                                    {
                                      return "Your password must consist of at least 6 characters";
                                    }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45.0,right:45,),
                            child: SizedBox(
                              height: 60,
                              child: TextFormField(
                                obscureText: true,
                                controller: tfconfirmPassword,
                                decoration: InputDecoration(
                                    labelText: "Confirm Password",
                                    prefixIcon: Icon(Icons.lock),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10)
                                ),
                                validator: (tfinput){
                                  if(tfinput!.isEmpty){
                                    return "Please enter a password";
                                  }
                                  if(tfinput.length<6)
                                  {
                                    return "Your password must consist of at least 6 characters";
                                  }
                                  if(tfinput! != tfPassword.text)
                                  {
                                    return "Your passwords must match";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                             Padding(
                               padding: const EdgeInsets.only(left: 25,right: 25,top: 15),
                               child: Column(
                                 children: [
                                   Text("Number of room:${ilerleme.toInt()}"),
                                   Slider(value: ilerleme, min:1, max:10,
                                       onChanged: (double i){
                                     setState(() {
                                       ilerleme =i;
                                     });

                                   }),
                                 ],
                               ),
                             ),


                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(onPressed: (){
                              bool kontrolSonucu=formKey.currentState!.validate();
                             if(kontrolSonucu)
                                {
                                  print(ilerleme);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      signup2(tfname.text,tfuserName.text,tfuserName.text,tfPassword.text,ilerleme.toInt())));
                               }
                            }, child: const Text("Sign Up",style: TextStyle(color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  shape: const RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(10)))
                              ),
                            ),
                          )
                        ],
                      )
                  ),

                  Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      GestureDetector(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>login(title: "Login")));
                      },
                        child:Text("Sign In",style:TextStyle(color: Colors.deepPurpleAccent),),),
                      const SizedBox(height: 100,),
                    ],),

                ],
              )
          ),
        )
    );
  }
}
