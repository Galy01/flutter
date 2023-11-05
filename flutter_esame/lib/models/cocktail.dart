class Cocktail {
  final String strDrink;
  final String strDrinkThumb;
  final String? idDrink;
  final String? strIngredient1;
  final String? strIngredient2;
  final String? strIngredient3;
  final String? strIngredient4;
  final String? strIngredient5;
  final String? strIngredient6;
  final String? strIngredient7;
  final String? strIngredient8;
  final String? strIngredient9;
  final String? strIngredient10;
  final String? strIngredient11;
  final String? strIngredient12;
  final String? strIngredient13;
  final String? strIngredient14;
  final String? strIngredient15;
  final String? strInstructions;
  final String? strInstructionsIT;

  Cocktail({
    required this.strDrink,
    required this.strDrinkThumb,
    this.idDrink,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strInstructions,
    this.strInstructionsIT,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
        strDrink: json['strDrink'],
        strDrinkThumb: json['strDrinkThumb'],
        idDrink: json['idDrink'],
        strIngredient1: json['strIngredient1'],
        strIngredient2: json['strIngredient2'],
        strIngredient3: json['strIngredient3'],
        strIngredient4: json['strIngredient4'],
        strIngredient5: json['strIngredient5'],
        strIngredient6: json['strIngredient6'],
        strIngredient7: json['strIngredient7'],
        strIngredient8: json['strIngredient8'],
        strIngredient9: json['strIngredient9'],
        strIngredient10: json['strIngredient10'],
        strIngredient11: json['strIngredient11'],
        strIngredient12: json['strIngredient12'],
        strIngredient13: json['strIngredient13'],
        strIngredient14: json['strIngredient14'],
        strIngredient15: json['strIngredient15'],
        strInstructions: json['strInstructions'],
        strInstructionsIT: json['strInstructionsIT']);
  }
}
