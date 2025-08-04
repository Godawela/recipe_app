class Recipe {
  final String name;
  final String image;
  final String time;
  final String difficulty;
  final int calories;
  final double rating;
  final List<String> ingredients;
  final List<String> instructions;

  Recipe({
    required this.name,
    required this.image,
    required this.time,
    required this.difficulty,
    required this.calories,
    required this.rating,
    required this.ingredients,
    required this.instructions,
  });
}