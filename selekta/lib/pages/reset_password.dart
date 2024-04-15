import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../data/authentification.dart';
import '../utils/exceptions.dart';
import 'forgot_password.dart';


class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black, Colors.purple, Colors.pink],
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 20,right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60,),
                Row(
                  children: [
                    GestureDetector(
                      child: Icon(Icons.chevron_left,color: Colors.white,),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 100,),
                    Container(
                        height: 64,
                        padding: EdgeInsets.only(top: 20),
                        child: Text("Forgot Password",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                  ],
                ),
                Container(
                    child: Text("Forgot Password",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
                SizedBox(height: 20),

                Container(
                  margin: EdgeInsets.only(left: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'ENTER YOUR USERNAME*',
                          children: <InlineSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                          style: TextStyle(color: Colors.white,fontSize: 12),
                        ),
                      ),                   Container(
                        height: 52,
                        width: 394,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                        child: TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '',
                            hintStyle: TextStyle(color: Colors.white)
                          ),
                          style: TextStyle(color: Colors.white),
                        ),

                      ),
                    ],),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 44,
                  width: 380,
                  child: ElevatedButton(
                    onPressed: () {
                      if(usernameController.text.isEmpty) {
                        EasyLoading.showError(
                            "Please enter your username", dismissOnTap: true,
                            duration: Duration(seconds: 10));
                        return;
                      }
                      Map<String, dynamic> jsonData = {
                        "username": usernameController.text,
                      };
                      forgotPassword(jsonData).then((value){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPassword(userName: usernameController.text)),
                        );
                      }).catchError((onError){
                        if(onError is UnableToProcess){
                          EasyLoading.showError(onError.reason,dismissOnTap: true,duration: Duration(seconds: 10));
                        }else{
                          EasyLoading.showError("An error occurred",dismissOnTap: true,duration: Duration(seconds: 10));
                        }
                      });
                      // Handle sign-up button press
                    },

                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent
                    ),
                    child: Text('Continue',style: TextStyle(color: Colors.white,fontFamily: "Poppins-Reqular")),
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword(userName: usernameController.text,)),
                    );
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Already have an account?",style: TextStyle(fontSize: 12,color: Colors.white)),
                        Text("Login",style: TextStyle(fontSize: 12,color: Colors.pinkAccent),),
                      ],
                    ),
                  ),
                ),
              ],),
          ),
        )
    );

  }
}
