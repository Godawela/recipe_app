import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../data/recipe_data.dart';
import '../widgets/custom_header.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/category_list.dart';
import '../widgets/recipe_card.dart';
import '../widgets/custom_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
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
      duration: Duration(milliseconds: 800),
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
          .where((recipe) => recipe.name.toLowerCase().contains(query.toLowerCase()))
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
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeader(),
                      SizedBox(height: 30),
                      SearchBarWidget(onChanged: _onSearchChanged),
                      SizedBox(height: 30),
                      CategoryList(
                        selectedIndex: selectedCategoryIndex,
                        onCategorySelected: _onCategorySelected,
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Popular Recipes',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 20),
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

