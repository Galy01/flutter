
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DetailedDrink.dart';


class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<String> lista = [];
  List<String> listaImg = [];
  List<String> listaId = [];

  @override
  void initState() {
    super.initState();
    loadFavouriteDrinks();
  }

   loadFavouriteDrinks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lista = prefs.getStringList("List") ?? [];
      listaImg = prefs.getStringList("ListImg") ?? [];
      listaId = prefs.getStringList("ListId") ?? [];
    });
  }




  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: lista.length,
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
                      lista[index],
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
                              MaterialPageRoute(builder: (context) =>  DetailedDrink(title: lista[index], id: listaId[index],drinkImage: listaImg[index])),
                            );
                          },
                          child: Image(
                              image: NetworkImage(
                                 listaImg[index])),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
