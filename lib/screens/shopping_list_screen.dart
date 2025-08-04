import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:recipe_app/models/shopping_list_item.dart';



class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  List<ShoppingListItem> shoppingList = [];

  void _addToShoppingList(Recipe recipe) {
    setState(() {
      for (String ingredient in recipe.ingredients) {
        // Parse ingredient to extract quantity and name
        List<String> parts = ingredient.split(' ');
        String quantity = parts.isNotEmpty ? parts[0] : '';
        String name = parts.length > 1 ? parts.sublist(1).join(' ') : ingredient;
        
        shoppingList.add(ShoppingListItem(
          name: name,
          quantity: quantity,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              setState(() {
                shoppingList.clear();
              });
            },
          ),
        ],
      ),
      body: shoppingList.isEmpty
          ? _buildEmptyShoppingList()
          : ListView.builder(
              itemCount: shoppingList.length,
              itemBuilder: (context, index) {
                final item = shoppingList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: CheckboxListTile(
                    title: Text(
                      item.name,
                      style: TextStyle(
                        decoration: item.isChecked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(item.quantity),
                    value: item.isChecked,
                    onChanged: (value) {
                      setState(() {
                        item.isChecked = value ?? false;
                      });
                    },
                    activeColor: Colors.orange[600],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyShoppingList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            'Your shopping list is empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add ingredients from recipes to get started!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}