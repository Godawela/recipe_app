import 'package:flutter/material.dart';
import 'package:recipe_app/data/fav_recipe.dart';
import 'package:recipe_app/screens/cooking_timer_screen.dart';
import 'package:recipe_app/screens/favourite_screen.dart';
import 'package:recipe_app/screens/profile_screen.dart';
import 'package:recipe_app/screens/shopping_list_screen.dart';
import '../models/recipe.dart';
import '../data/recipe_data.dart';
import '../widgets/custom_header.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_list.dart';
import '../widgets/recipe_card.dart';
import '../widgets/custom_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  List<Recipe> recipes = [];
  List<Recipe> filteredRecipes = [];
  int selectedCategoryIndex = 0;
  int currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    recipes = RecipeData.getRecipes();
    filteredRecipes = recipes;
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      filteredRecipes = recipes
          .where((recipe) =>
              recipe.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onCategorySelected(int index) {
    setState(() {
      selectedCategoryIndex = index;
      // In a real app, you would filter by category here
      filteredRecipes = recipes;
    });
  }

  void _onNavTap(int index) {
    setState(() {
      currentNavIndex = index;
    });

    // Navigate to different screens based on the selected tab
    switch (index) {
      case 0:
        // Already on Home, do nothing
        break;
      case 1:
        // Navigate to Favorites
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FavoritesScreen(
              favoriteRecipes: FavRecipe.getRecipes(),
            ),
          ),
        );
        break;
      case 2:
        // Navigate to Shopping
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ShoppingListScreen()),
        );
        break;
      case 3:
        // Navigate to Timer
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CookingTimerScreen()),
        );
        break;
      case 4:
        // Navigate to Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomHeader(),
                      const SizedBox(height: 30),
                      SearchBarWidget(onChanged: _onSearchChanged),
                      const SizedBox(height: 30),
                      CategoryList(
                        selectedIndex: selectedCategoryIndex,
                        onCategorySelected: _onCategorySelected,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Popular Recipes',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300 + (index * 100)),
                      curve: Curves.easeInOut,
                      child: RecipeCard(
                        recipe: filteredRecipes[index],
                        index: index,
                      ),
                    );
                  },
                  childCount: filteredRecipes.length,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentNavIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
