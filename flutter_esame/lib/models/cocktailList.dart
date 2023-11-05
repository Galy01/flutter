class cocktailList {
  final List drinks;

  const cocktailList({
    required this.drinks,
  });

  factory cocktailList.fromJson(Map<String, dynamic> json) {
    return cocktailList(
      drinks: json['drinks']! as List,
    );
  }
}