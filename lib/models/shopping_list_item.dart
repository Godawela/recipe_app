class ShoppingListItem {
  final String name;
  final String quantity;
  bool isChecked;

  ShoppingListItem({
    required this.name,
    required this.quantity,
    this.isChecked = false,
  });
}