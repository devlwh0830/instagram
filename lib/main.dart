import 'package:flutter/material.dart';
import 'style.dart' as style;

void main() {
  runApp(
      MaterialApp(
        theme: style.themes,
        home: MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram",style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.add_box_outlined),
            iconSize: 30,
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 510,
                    width: double.infinity,
                    child: Image.asset('octopus.jpg',scale: 1,),
                ),
                SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '     좋아요 100',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '     글쓴이',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,),
                      ),
                      Text(
                        '     글내용',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,),
                      ),
                    ],
                  )
                ),
                SizedBox(
                  height: 510,
                  width: double.infinity,
                  child: Image.asset('octopus.jpg',scale: 1,),
                ),
                SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '     좋아요 100',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '     글쓴이',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,),
                        ),
                        Text(
                          '     글내용',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,),
                        ),
                      ],
                    )
                ),
                SizedBox(
                  height: 510,
                  width: double.infinity,
                  child: Image.asset('octopus.jpg',scale: 1,),
                ),
                SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '     좋아요 100',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '     글쓴이',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,),
                        ),
                        Text(
                          '     글내용',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,),
                        ),
                      ],
                    )
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
              label : '홈',
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              label : '샵',
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag)
          )
        ],
      ),
    );
  }
}
