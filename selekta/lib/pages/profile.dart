import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color:  Color(0xFFF150B29)

        ),

        child: Column(children: [
        SizedBox(height: 60),
        Row(
          children: [
          SizedBox(width: 20,),
          Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,),
            Spacer(),
          Text("Profile",style: TextStyle(fontSize: 16,color: Colors.white)),
            Spacer(),

            Icon(Icons.more_vert,size: 20,color: Colors.white,),
            SizedBox(width: 20,),


          ],),
        SizedBox(height: 30,),
        Container(
          width: 80,
          height: 80,
          child:ClipRRect(
            borderRadius: BorderRadius.circular(50), // Adjust the radius value as needed
            child: Image.asset(
              'assets/d.jpg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          )),
        SizedBox(height: 20,),
         Text("Dj Joe Mfalme",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),),
        SizedBox(height: 10,),
        Text("Account Holder",style: TextStyle(color: Colors.white),),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text("1.5k ",style: TextStyle(color: Colors.white),),
          SizedBox(width: 20,),
          Text("67 ",style: TextStyle(color: Colors.white),),
          SizedBox(width: 30,),
          Text("34 ",style: TextStyle(color: Colors.white),),
        ],),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 30),
            Text("Plays",style: TextStyle(color: Colors.white),),
           SizedBox(width: 20),
          Text("Likes",style: TextStyle(color: Colors.white),),
          SizedBox(width: 20),
          Text("Shares",style: TextStyle(color: Colors.white),)
        ],),
        SizedBox(height: 40,),
        Row(children: [
          SizedBox(width: 20),
          Icon(Icons.playlist_add_check_outlined,color: Colors.white,),
          SizedBox(width: 20),
          Text("Recently Events",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
          Spacer(),
          Icon(Icons.chevron_right,size: 20,color: Colors.white,),
          SizedBox(width: 20)
        ],),

        SizedBox(height: 20,),
        Row(children: [
          SizedBox(width: 20),
          Icon(Icons.playlist_add_check_outlined,color: Colors.white,),
          SizedBox(width: 20),

          Text("Past Events",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
        Spacer()     ,
          Icon(Icons.chevron_right,size: 20,color: Colors.white,),
          SizedBox(width: 20)
        ],),
        SizedBox(height: 20,),
        Row(children: [
          SizedBox(width: 20),
          Icon(Icons.playlist_add_check_outlined,color: Colors.white,),
          SizedBox(width: 20),
          Text("Favourites",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
          Spacer(),
          Icon(Icons.chevron_right,size: 20,color: Colors.white,),
          SizedBox(width: 20)
        ],),
        SizedBox(height: 30,),
        Container(child: Text("Log Out",style: TextStyle(color: Colors.red),),)

      ],),),
    );
  }
}
