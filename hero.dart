// import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Show Search"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SecondPage(
                    myTag: index.toString()
                  )
                )
              );
            },
            child: Hero(
              tag: index.toString(),
              child: myImage()
            )
          );
        }
      )
    );
  }
  Widget myImage(){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Image.asset(
        'images/image1.jpg',
        height: 100,
        width: 100,
      )
    );
  }
}

class SecondPage extends StatelessWidget{
  final String? myTag;
  
  const SecondPage({
    Key? key, 
    this.myTag}
  ) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Hero(
        tag: myTag!,
        child: Image.asset(
          'images/image1.jpg',
        ),
      )
    );
  }

}