import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:selekta/data/authentification.dart';
import 'package:selekta/pages/reset_password.dart';

import '../utils/exceptions.dart';
import 'MyHomePage.dart';
import 'forgot_password.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SingleTickerProviderStateMixin{

  bool rememberMe = false;
  late TabController _tabController;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController  mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
    rememberMe = newValue;

    if (rememberMe) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome',style: TextStyle(color: Colors.purple,fontWeight: FontWeight.w600),),
        bottom: TabBar(
          controller: _tabController,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 2.0, color: Colors.purple), // Customize the width and color of the line
            insets: EdgeInsets.symmetric(horizontal: 100.0), // Adjust the insets as needed
          ),
          tabs: [
            Container(

                child: Tab(text: 'Login')),
            Container(
                child: Tab(text: 'Sign Up')),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.purple, Colors.pink],
          ),
        ),
        child: TabBarView(
            controller: _tabController,
            children:[
              Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 SizedBox(height: 50,),
                    Container(
                      child: Text("Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),),),
                    SizedBox(height: 20,),
                    Container(child: Text("PHONE NUMBER",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.white),),),
                    SizedBox(height: 10,),

                    Container(

                      child: TextField(
                        controller: userNameController,
                        decoration: InputDecoration(
                          hintText: '0703661311',
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.only(left: 20,right: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),

                          ),
                        ),
                        style: TextStyle(color: Colors.white),

                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(child: Text("PASSWORD",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.white),),),
                    SizedBox(height: 10,),

                    Container(

                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Enter Your Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.only(left: 20,right: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),

                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                        onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                            );
                        },
                        child: Text("Forgot Password?",style: TextStyle(fontSize: 16,color: Colors.white),)),
                    SizedBox(height: 20,),

                    Row(children: [
                      Container(
                        height: 100,
                        child: Checkbox(
                          value: rememberMe,
                          onChanged: (newValue) {
                            setState(() {
                              rememberMe = newValue!;
                            });
                          },
                        ),
                      )     ,
                      Text("Remember me",style: TextStyle(fontSize: 16,color: Colors.white),),
                    ],),
                    Container(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: () {
                          var payload = {
                            "username": userNameController.text,
                            "password": passwordController.text,
                          };
                          if(userNameController.text.isEmpty ){
                            EasyLoading.showError("Please enter your user name",dismissOnTap: true,duration:Duration(seconds: 10));
                            return;
                          }else if(passwordController.text.isEmpty){
                            EasyLoading.showError("Please enter your password",dismissOnTap: true,duration:Duration(seconds: 10));
                            return;
                          }
                          login(payload).then((value){

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyHomePage()),
                            );
                          }).catchError((onError){
                            if (onError is UnableToProcess){
                              EasyLoading.showError(onError.reason,dismissOnTap: true,duration: Duration(seconds: 20));
                            }else{
                              EasyLoading.showError("An error occurred, please try again",dismissOnTap: true,duration: Duration(seconds: 20));
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pinkAccent, // Background color of the button
                          onPrimary: Colors.white, // Text color of the button
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Button padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Rounded corners
                          ),
                        ),
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                  ],),),

              SingleChildScrollView(
                child: Container(
                            margin: EdgeInsets.only(left: 20,right: 20),
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                SizedBox(height: 50,),
                
                Container(
                            child: Text("Sign Up",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),),),
                          SizedBox(height: 20,),
                            Container(child: Text("USER NAME",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.white),),),
                SizedBox(height: 10,),
                Container(
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    hintText: 'enter username',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.only(left: 20,right: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                            ),
                SizedBox(height: 20,),
                Container(child: Text("PHONE NUMBER",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.white),),),
                SizedBox(height: 10,),
                Container(
                  child: TextField(
                    controller: mobileController,
                    decoration: InputDecoration(
                      hintText: '0703661311',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(left: 20,right: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20,),
                Container(child: Text("EMAIL",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.white),),),
                SizedBox(height: 10,),
                Container(
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'enter email address',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(left: 20,right: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                
                      ),
                    ),
                    style: TextStyle(color: Colors.white),

                  ),
                ),
                SizedBox(height: 20,),
                Container(child: Text("PASSWORD",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.white),),),
                SizedBox(height: 10,),
                Container(
                  child: TextField(
                     controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "Enter Your Password",
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.only(left: 20,right: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),

                  ),
                ),
                SizedBox(height: 20,),
                Container(child: Text("CONFIRM PASSWORD",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300,color: Colors.white),),),
                SizedBox(height: 10,),
                
                Container(
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "Re-enter Your Password",
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.only(left: 20,right: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10,),
                Row(children: [
                  Container(
                    height: 100,
                    child: Checkbox(
                      value: rememberMe,
                      onChanged: (newValue) {
                        setState(() {
                          rememberMe = newValue!;
                        });
                      },
                    ),
                  )     ,
                  Text("Remember me",style: TextStyle(fontSize: 16,color: Colors.white),),
                ],),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      var payload = {
                        "username": userNameController.text,
                        "role_id": 1,
                        "password": passwordController.text,
                        "mobile": mobileController.text,
                        "email": emailController.text,
                        "fullname": "John Doe",
                        "country": "USA"
                      };
                      if(mobileController.text.isEmpty ){
                        EasyLoading.showError("Please enter your phone number",dismissOnTap: true,duration:Duration(seconds: 10));
                        return;
                      }else if(passwordController.text.isEmpty){
                        EasyLoading.showError("Please enter your password",dismissOnTap: true,duration:Duration(seconds: 10));
                        return;
                      }
                      signUp(payload).then((value){

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                      }).catchError((onError){
                        if (onError is UnableToProcess){
                          EasyLoading.showError(onError.reason,dismissOnTap: true,duration: Duration(seconds: 20));
                        }else{
                          EasyLoading.showError("An error occurred, please try again",dismissOnTap: true,duration: Duration(seconds: 20));
                        }
                      });
                      // Handle sign-up button press
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent, // Background color of the button
                      onPrimary: Colors.white, // Text color of the button
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                            ],),),
              ),
        ]),
      ),
    );
  }
}
