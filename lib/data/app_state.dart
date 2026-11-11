import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/food.dart';

class AppState extends ChangeNotifier {
  // Singleton instance
  static final AppState instance = AppState._internal();

  // Private constructor
  AppState._internal();

  // ============================================================
  // CART
  // ============================================================

  final List<CartItem> cartItems = [];

  double get subtotal {
    double total = 0;

    for (final item in cartItems) {
      total += item.food.price * item.quantity;
    }

    return total;
  }

  double get deliveryFee {
    if (cartItems.isEmpty) {
      return 0;
    }

    // Free delivery above ₹500
    if (subtotal >= 500) {
      return 0;
    }

    return 40;
  }

  double get total {
    return subtotal + deliveryFee;
  }

  int get itemCount {
    int count = 0;

    for (final item in cartItems) {
      count += item.quantity;
    }

    return count;
  }

  // Add food to cart
  void addToCart(
    Food food, {
    int quantity = 1,
  }) {
    final index = cartItems.indexWhere(
      (item) => item.food.id == food.id,
    );

    if (index != -1) {
      cartItems[index].quantity += quantity;
    } else {
      cartItems.add(
        CartItem(
          food: food,
          quantity: quantity,
        ),
      );
    }

    notifyListeners();
  }

  // Increase quantity
  void increaseQuantity(String foodId) {
    final index = cartItems.indexWhere(
      (item) => item.food.id == foodId,
    );

    if (index != -1) {
      cartItems[index].quantity++;
      notifyListeners();
    }
  }

  // Decrease quantity
  void decreaseQuantity(String foodId) {
    final index = cartItems.indexWhere(
      (item) => item.food.id == foodId,
    );

    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        cartItems.removeAt(index);
      }

      notifyListeners();
    }
  }

  // Remove food completely
  void removeFromCart(String foodId) {
    cartItems.removeWhere(
      (item) => item.food.id == foodId,
    );

    notifyListeners();
  }

  // Clear cart
  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }

  // ============================================================
  // FAVORITES
  // ============================================================

  final Set<String> favoriteFoodIds = {};

  bool isFavorite(String foodId) {
    return favoriteFoodIds.contains(foodId);
  }

  void toggleFavorite(String foodId) {
    if (favoriteFoodIds.contains(foodId)) {
      favoriteFoodIds.remove(foodId);
    } else {
      favoriteFoodIds.add(foodId);
    }

    notifyListeners();
  }

  // ============================================================
  // ORDERS
  // ============================================================

  final List<List<CartItem>> orders = [];

  void saveOrder() {
    if (cartItems.isEmpty) {
      return;
    }

    final orderCopy = cartItems
        .map(
          (item) => CartItem(
            food: item.food,
            quantity: item.quantity,
          ),
        )
        .toList();

    orders.insert(0, orderCopy);

    cartItems.clear();

    notifyListeners();
  }

  void placeOrder() {
    saveOrder();
  }
}