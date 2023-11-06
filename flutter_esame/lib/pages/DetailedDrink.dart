import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cocktail.dart';
import '../models/cocktailList.dart';
import 'package:http/http.dart' as http;

Future<cocktailList> fetchDrinksDetail(String text) async {
  final response = await http.get(Uri.parse(
      'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$text'));

  if (response.statusCode == 200) {
    return cocktailList
        .fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.orangeAccent),
        useMaterial3: true,
      ),
      home:
          const DetailedDrink(title: 'Esame Cocktails', id: "", drinkImage: ""),
    );
  }
}

class DetailedDrink extends StatefulWidget {
  const DetailedDrink(
      {super.key,
      required this.title,
      required this.id,
      required this.drinkImage});

  final String title;
  final String? id;
  final String? drinkImage;

  @override
  State<DetailedDrink> createState() => _DetailedDrinkState();
}

class _DetailedDrinkState extends State<DetailedDrink> {
  cocktailList? drinks;
  Cocktail? string;
  String drinkName = "";
  bool controllo = false;
  List<String> ingredientList = [];
  String? idDrink;
  String? istructions = "";
  List<String> lista = [];
  List<String> listaImg = [];
  List<String> listaId = [];

  @override
  void initState() {
    super.initState();
  }

  isFavourite() async {
    final prefs = await SharedPreferences.getInstance();
     lista = prefs.getStringList("List") ?? [];

    setState(() {
      controllo = lista.contains(drinkName);
    });
  }

  void addFavouriteDrink() async {
    final prefs = await SharedPreferences.getInstance();
     lista = prefs.getStringList("List") ?? [];

    final prefImg = await SharedPreferences.getInstance();
    listaImg = prefImg.getStringList("ListImg") ?? [];

    final prefId = await SharedPreferences.getInstance();
    listaId = prefId.getStringList("ListId") ?? [];

    if(!lista.contains(drinkName)){
       lista.add(drinkName);
       listaImg.add(widget.drinkImage!);
       listaId.add(widget.id!);

     }


    await prefs.setStringList("List", lista);
    await prefId.setStringList("ListId", listaId);
    await prefImg.setStringList("ListImg", listaImg);
  }

  void removeFavouriteDrink() async {
    final prefs = await SharedPreferences.getInstance();
    lista = prefs.getStringList("List") ?? [];

    final prefImg = await SharedPreferences.getInstance();
    listaImg = prefImg.getStringList("ListImg") ?? [];

    final prefId = await SharedPreferences.getInstance();
    listaId = prefId.getStringList("ListId") ?? [];

   lista.removeWhere((item) => item == drinkName);
    await prefs.setStringList("List", lista);


    listaId.removeWhere((item) => item == widget.id!);
    await prefId.setStringList("ListId", listaId);

    listaImg.removeWhere((item) => item == widget.drinkImage!);
    await prefImg.setStringList("ListImg", listaImg);
  }

  _loadData(String? text) async {
    final result = await fetchDrinksDetail(text!);

    setState(() {
      drinks = result;
      string = Cocktail.fromJson(result.drinks[0]);
      drinkName = string!.strDrink;

      void addIngredientIfNotExists(String? ingredient) {
        if (ingredient != null && !ingredientList.contains(ingredient)) {
          ingredientList.add(ingredient);
        }
      }

      if (string!.strInstructionsIT != null) {
        istructions = string!.strInstructionsIT;
      } else {
        istructions = string!.strInstructions;
      }

      addIngredientIfNotExists(string!.strIngredient1);
      addIngredientIfNotExists(string!.strIngredient2);
      addIngredientIfNotExists(string!.strIngredient3);
      addIngredientIfNotExists(string!.strIngredient4);
      addIngredientIfNotExists(string!.strIngredient5);
      addIngredientIfNotExists(string!.strIngredient6);
      addIngredientIfNotExists(string!.strIngredient7);
      addIngredientIfNotExists(string!.strIngredient8);
      addIngredientIfNotExists(string!.strIngredient9);
      addIngredientIfNotExists(string!.strIngredient10);
      addIngredientIfNotExists(string!.strIngredient11);
      addIngredientIfNotExists(string!.strIngredient12);
      addIngredientIfNotExists(string!.strIngredient13);
      addIngredientIfNotExists(string!.strIngredient14);
      addIngredientIfNotExists(string!.strIngredient15);


      isFavourite();


    });
  }

  @override
  Widget build(BuildContext context) {
    _loadData(widget.id);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.orangeAccent, width: 6)),
                  child: Image(
                    image: NetworkImage(widget.drinkImage!),
                    width: 250,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    if(controllo == false){
                      addFavouriteDrink();
                    }else{
                      removeFavouriteDrink();
                    }

                  },
                  icon: controllo
                      ? const Icon(Icons.star, size: 30,color: Colors.orangeAccent)
                      : const Icon(Icons.star_border_outlined, size: 30),color: Colors.orangeAccent),
              const Text(
                "Ingredienti:",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ingredientList.length,
                    itemBuilder: (context, index) {
                      return Text(
                        ingredientList[index] + " - ",
                        style: const TextStyle(
                            fontSize: 20, color: Colors.orangeAccent),
                      );
                    },
                  ),
                ),
              ),
              const Divider(
                height: 30,
                thickness: 2,
                color: Colors.blue,
              ),
              const Text(
                "Istruzioni:",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  istructions!,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
