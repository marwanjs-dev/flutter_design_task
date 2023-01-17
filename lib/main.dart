import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:task_design/Models/pets.dart';
import 'package:task_design/utils/constants.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _controller;
  List<Pet> _petlist2 = [];
  @override
  void initState() {
    _petlist2 = petList;
    _controller = TextEditingController();
    super.initState();
  }

  void _searchPet(String query) {
    List<Pet> results = [];
    if (query.isEmpty) {
      results = petList;
    } else {
      results = petList.where((pet) {
        final petTitle = pet.pet.toLowerCase();
        final input = query.toLowerCase();
        return petTitle.contains(input);
      }).toList();
    }
    setState(() {
      _petlist2 = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Pet Market",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "BalsamiqSans",
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 220, 220, 220),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search by Pet name",
                hintStyle: TextStyle(fontFamily: "BalsamiqSans"),
                fillColor: const Color.fromARGB(255, 220, 220, 220),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged: (value) => _searchPet(value),
            ),
            SizedBox(
              height: sh * 0.05,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 220, 220, 220),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        height: sh * 0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                _petlist2[index].image,
                                height: sh * 0.12,
                                width: 120,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              height: sh * 0.13,
                              width: sw * 0.4,
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      _petlist2[index].pet,
                                      style: const TextStyle(
                                        fontFamily: "BalsamiqSans",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: sh * 0.007,
                                    ),
                                    Text(_petlist2[index].type,
                                        style: const TextStyle(
                                          fontFamily: "BalsamiqSans",
                                        )),
                                    SizedBox(
                                      height: sh * 0.015,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.pets),
                                        SizedBox(
                                          width: sw * 0.008,
                                        ),
                                        Text(
                                          "Pet Love: ${_petlist2[index].petLove}",
                                          style: const TextStyle(
                                              fontFamily: "BalsamiqSans",
                                              color: Color.fromARGB(
                                                  239, 241, 138, 4)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    thickness: 0,
                    height: 5,
                    color: Color.fromARGB(255, 220, 220, 220),
                  ),
                  itemCount: _petlist2.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
