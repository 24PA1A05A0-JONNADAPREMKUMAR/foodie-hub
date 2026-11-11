import 'food.dart';

class CartItem {
  final Food food;
  int quantity;

  CartItem({
    required this.food,
    this.quantity = 1,
  });

  // Calculate total price for this item
  double get totalPrice {
    return food.price * quantity;
  }
}