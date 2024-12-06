class Meal {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String? strInstructions; // Instruksi masak
  final String? strYoutube; // Link video tutorial

  Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    this.strInstructions,
    this.strYoutube,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      strInstructions: json['strInstructions'],
      strYoutube: json['strYoutube'],
    );
  }
}
