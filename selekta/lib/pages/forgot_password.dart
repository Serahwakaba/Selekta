import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../data/authentification.dart';
import '../utils/app_utils.dart';
import '../utils/exceptions.dart';
import 'Signup.dart';


class ForgotPassword extends StatefulWidget {
  final String userName;
  const ForgotPassword( {required this.userName});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController = TextEditingController();
  bool agreeToTerms = false;
  bool obscurePassword = true;
  String mobile = "";
  String email = "";
  @override
  void initState() {
    getPrefsString("mobile").then((value){
      setState(() {
        mobile=value;
      });
    });
    getPrefsString("email").then((value){
      setState(() {
        email=value;
      });
    });
    // _file = File(filePath);
    super.initState();
  }
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
                          text: 'ENTER  THE 4-DIGIT CODE SENT TO YOUR NUMBER*',
                          children: <InlineSpan>[
                            TextSpan(
                              text: '*',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                          style: TextStyle(color: Colors.white,fontSize: 12),
                        ),
                      ),

                      Container(
                        height: 52,
                        width: 394,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8))
                        ),
                        child: TextField(
                          controller: otpController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '',
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],),
                ),
                SizedBox(height: 20,),
                Container(
                    child: Text("Create Password",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          child: TextField(
                            controller: passwordController,
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(color: Colors.white),

                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Container(
                          height: 50,
                          child: TextField(
                            controller: repeatPasswordController,
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Repeat Password',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          obscurePassword ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 44,
                  width: 380,
                  child: ElevatedButton(
                    onPressed: () {
                      if(otpController.text.isEmpty){
                        EasyLoading.showError("OTP is required",dismissOnTap: true,duration: Duration(seconds: 10));
                        return;
                      }else if(passwordController.text.isEmpty){
                        EasyLoading.showError("Please enter you password",dismissOnTap: true,duration: Duration(seconds: 10));
                        return;
                      }else if(passwordController.text.compareTo(repeatPasswordController.text)!=0){
                        EasyLoading.showError("Repeat password did not match",dismissOnTap: true,duration: Duration(seconds: 10));
                        return;
                      }

                      Map<String, dynamic> jsonData = {
                        "code": otpController,
                        "username": widget.userName,
                        "password":passwordController
                      };

                      resetPassword(jsonData).then((value){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );*/
                      }).catchError((onError){
                        if(onError is UnableToProcess){
                          EasyLoading.showError(onError.reason,dismissOnTap: true,duration: Duration(seconds: 10));
                        }else{
                          EasyLoading.showError("An error occurred",dismissOnTap: true,duration: Duration(seconds: 10));
                        }
                      });

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
                      MaterialPageRoute(builder: (context) => SignUpPage()),
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
