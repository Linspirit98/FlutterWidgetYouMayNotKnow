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
        title: const Text('Interactive Viewer')
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

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightGreen,
//       body: InteractiveViewer(
//         boundaryMargin: const EdgeInsets.all(double.infinity,),
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('Interactive Viewer')
//           )
//         )
//       ),

//     );
//   }
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Offset _offset = const Offset(50, 250);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Flutter Show Search"),
//       ),
//       body: Center(
//         child: LayoutBuilder(
//           builder: (context, constraints){
//             return Stack(
//               children: [
//                 Positioned(
//                   left: _offset.dx,
//                   top: _offset.dy,
//                   child: LongPressDraggable(
//                     feedback: Image.asset(
//                       'images/image1.jpg',
//                       height: 150,
//                       color: Colors.grey[400],
//                       colorBlendMode: BlendMode.colorBurn,
//                     ), 
//                     child: Image.asset(
//                       'images/image1.jpg',
//                       height: 150,
//                     ),
//                     onDragEnd: (details){
//                       setState(() {
//                         double adjustment = MediaQuery.of(context).size.height - constraints.maxHeight;
//                         _offset = Offset(details.offset.dx, details.offset.dy-adjustment);
//                       });
//                     }
//                   ),
//                 )
//               ]
//             );
//           },
//         )
//       )
//     );
//   }
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Flutter Show Search"),
//       ),
//       body: ListView.builder(
//         itemCount: 5,
//         itemBuilder: (BuildContext context, int index) {
//           return GestureDetector(
//             onTap: (){
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => SecondPage(
//                     myTag: index.toString()
//                   )
//                 )
//               );
//             },
//             child: Hero(
//               tag: index.toString(),
//               child: myImage()
//             )
//           );
//         }
//       )
//     );
//   }
//   Widget myImage(){
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Image.asset(
//         'images/image1.jpg',
//         height: 100,
//         width: 100,
//       )
//     );
//   }
// }

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

class CustomSearchDelegate extends SearchDelegate{
  List<String> searchTerms = [
    "Fish",
    "Pork",
    "Beef",
    "Chicken",
    "Broccoli",
    "Shrimp",
    "Spinach",
  ];

  @override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: (){
          query = ''; 
        }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
      }
    );
  }

  @override buildResults(BuildContext context){
    List<String> matchQuery = [];
    for(var food in searchTerms){
      if(food.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(food);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder:(context, index){
        var result = matchQuery[index];
        return ListTile(
          title: Text(result)
        );
      }
    );
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for(var food in searchTerms){
      if(food.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(food);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder:(context, index){
        var result = matchQuery[index];
        return ListTile(
          title: Text(result)
        );
      }
    );
  }

}