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
        title: Text("Flutter Show Search"),
        actions:[
          IconButton(
            onPressed: (){
              showSearch(
                context: context,
                delegate: CustomSearchDelegate()
              );
            }, 
            icon: const Icon(Icons.search)
          )
        ],
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