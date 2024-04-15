import 'package:flutter/material.dart';


class RequestaPage extends StatefulWidget {
  const RequestaPage({super.key});

  @override
  State<RequestaPage> createState() => _RequestaPageState();
}

class _RequestaPageState extends State<RequestaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.purple, Colors.pink],
          ),
        ),
        child: Column(children: [
          SizedBox(height: 60),
          Row(
            children: [
              SizedBox(width: 20,),
              Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,),
              Spacer(),
              Text("Requests",style: TextStyle(fontSize: 16,color: Colors.white)),
              Spacer(),
              Icon(Icons.more_vert,size: 20,color: Colors.white,),
              SizedBox(width: 20,),
            ],),
        Container(
            height: 500,
            margin: EdgeInsets.only(bottom: 0,top: 0),
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index)
                {
                  return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration:  BoxDecoration(
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: ListTile(
                        leading:  Container(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Adjust the radius value as needed
                            child: Image.asset(
                              'assets/dj.jpg',
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text("Marce",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hafe",style: TextStyle(color: Colors.white)),
                            SizedBox(height:10,),
                          ],
                        ),
                        trailing: Container(
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: 30,
                                margin: EdgeInsets.only(top: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFF0096FF
                                      )
                                  ),

                                  onPressed: () {},
                                  child: Text('Play',style: TextStyle(color: Colors.black,fontSize: 10),),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    );

                })
        ),

      ],),) ,
    );
  }
}
