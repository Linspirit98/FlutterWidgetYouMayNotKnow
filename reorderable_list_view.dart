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
  List<Color> myColors = [Colors.red, Colors.green, Colors.yellow, Colors.blue, Colors.orange];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reorderable ListView')
      ),
      body: Container(
        height: 50,
        alignment: Alignment.center,
        child: Center(
          child: ReorderableListView(
            scrollDirection: Axis.horizontal,
            onReorder:(oldIndex, newIndex) {
              setState((){
                if(oldIndex < newIndex){
                  newIndex -= 1;
                }
              });
              final Color item = myColors.removeAt(oldIndex);
              myColors.insert(newIndex, item);
            },
            children: <Widget>[
              for (int index = 0; index < myColors.length; index++)
                Container(
                  key: Key(index.toString()),
                  margin: const EdgeInsets.only(right: 5, left: 5),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          color: myColors[index],
                          height: 50,
                          width: 50
                        )
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: (){
                            //remove in unity
                            setState((){
                              myColors.removeAt(index);
                            });
                          },
                          child: const Icon(
                            Icons.do_not_disturb_on_rounded,
                            size: 20,
                          )
                        )
                      ),
                    ]
                  )
                )
            ]
          ),
        )
      )
    );
  }

}