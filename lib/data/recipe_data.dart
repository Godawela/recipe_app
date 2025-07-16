import '../models/recipe.dart';

class RecipeData {
  static List<Recipe> getRecipes() {
    return [
      Recipe(
        name: 'Avocado Toast',
        image: '🥑',
        time: '5 min',
        difficulty: 'Easy',
        calories: 320,
        rating: 4.5,
        ingredients: ['2 slices bread', '1 avocado', 'Salt & pepper', 'Lime juice'],
        instructions: ['Toast bread slices', 'Mash avocado with lime', 'Spread on toast', 'Season with salt & pepper'],
      ),
      Recipe(
        name: 'Pasta Carbonara',
        image: '🍝',
        time: '20 min',
        difficulty: 'Medium',
        calories: 580,
        rating: 4.8,
        ingredients: ['400g pasta', '200g pancetta', '4 eggs', 'Parmesan cheese'],
        instructions: ['Cook pasta', 'Fry pancetta', 'Mix eggs with cheese', 'Combine all ingredients'],
      ),
      Recipe(
        name: 'Chicken Tikka',
        image: '🍗',
        time: '45 min',
        difficulty: 'Hard',
        calories: 450,
        rating: 4.7,
        ingredients: ['500g chicken', 'Yogurt', 'Spices', 'Onions'],
        instructions: ['Marinate chicken', 'Prepare spice mix', 'Grill chicken', 'Serve with rice'],
      ),
      Recipe(
        name: 'Greek Salad',
        image: '🥗',
        time: '10 min',
        difficulty: 'Easy',
        calories: 280,
        rating: 4.3,
        ingredients: ['Tomatoes', 'Cucumber', 'Feta cheese', 'Olives', 'Olive oil'],
        instructions: ['Chop vegetables', 'Add feta and olives', 'Drizzle with olive oil', 'Toss and serve'],
      ),
    ];
  }
}
