import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_esame/pages/DetailedDrink.dart';

import '../models/cocktail.dart';
import '../models/cocktailList.dart';
import 'package:http/http.dart' as http;

Future<cocktailList> fetchDrinks(String text) async {
  final response = await http.get(Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$text'));

  if (response.statusCode == 200) {
    return cocktailList
        .fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  cocktailList? drinks;
  Cocktail? string;
  List<String> idDrink = [];
  List<String> drinkNames = [];
  List<String> drinkImages = [];

  _loadData(String text) async {
    final result = await fetchDrinks(text);

    setState(() {
      drinks = result;
      drinkNames.clear();
      drinkImages.clear();


      for (var drink in result.drinks) {
        string = Cocktail.fromJson(drink);
        string = Cocktail.fromJson(drink);
        idDrink.add(string!.idDrink!);
        drinkNames.add(string!.strDrink);
        drinkImages.add(string!.strDrinkThumb);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: SearchBar(
            controller: _controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            leading: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  _loadData(_controller.text);
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Inserisci almeno 1 carattere per la ricerca.'),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        Expanded(
            child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: drinkNames.length,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: SizedBox(
                width: 300,
                child: Card(
                  margin: EdgeInsets.only(left: 50, bottom: 100, top: 100),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          drinkNames[index],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                            decoration:
                                BoxDecoration(border: Border.all(width: 5,color: Colors.orangeAccent), borderRadius: BorderRadius.all(Radius.circular(10)) ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  DetailedDrink(title: drinkNames[index], id: idDrink[index],drinkImage: drinkImages[index])),
                                );
                              },
                              child: Image(
                                  image: NetworkImage(
                                      drinkImages[index])),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ))
      ],
    );
  }
}
