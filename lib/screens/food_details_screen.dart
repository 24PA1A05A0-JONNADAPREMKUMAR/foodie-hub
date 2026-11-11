import 'package:flutter/material.dart';

import '../data/app_state.dart';
import '../models/food.dart';
import '../theme/app_theme.dart';
import 'cart_screen.dart';

class FoodDetailsScreen extends StatefulWidget {
  final Food food;

  const FoodDetailsScreen({
    super.key,
    required this.food,
  });

  @override
  State<FoodDetailsScreen> createState() =>
      _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int quantity = 1;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  double get totalPrice {
    return widget.food.price * quantity;
  }

  // ------------------------------------------------------------
  // ADD TO CART
  // ------------------------------------------------------------

  void addToCart() {
    // Add the exact quantity selected by the user.
    AppState.instance.addToCart(
      widget.food,
      quantity: quantity,
    );

    // Remove any previous SnackBar first.
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Show confirmation SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.food.name} × $quantity added to cart',
        ),
        backgroundColor: AppTheme.primaryColor,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'VIEW CART',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool favorite =
        AppState.instance.isFavorite(widget.food.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 330,
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            actions: [
              Container(
                margin: const EdgeInsets.only(
                  right: 12,
                  top: 8,
                  bottom: 8,
                ),
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      AppState.instance.toggleFavorite(
                        widget.food.id,
                      );
                    });
                  },
                  icon: Icon(
                    favorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.food.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.fastfood,
                      size: 80,
                      color: AppTheme.primaryColor,
                    ),
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                25,
                20,
                30,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // Category
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor
                          .withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.food.category,
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Food name
                  Text(
                    widget.food.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Restaurant
                  Row(
                    children: [
                      const Icon(
                        Icons.restaurant_outlined,
                        size: 18,
                        color: AppTheme.greyColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.food.restaurantName,
                        style: const TextStyle(
                          color: AppTheme.greyColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Rating
                  Row(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.green,
                              size: 17,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.food.rating.toString(),
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Excellent rating',
                        style: TextStyle(
                          color: AppTheme.greyColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // Price
                  Text(
                    '₹${widget.food.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),

                  const SizedBox(height: 22),

                  // About
                  const Text(
                    'About this dish',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    widget.food.description,
                    style: const TextStyle(
                      color: AppTheme.greyColor,
                      height: 1.6,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Quantity
                  const Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      _quantityButton(
                        icon: Icons.remove,
                        onPressed: decreaseQuantity,
                      ),
                      Container(
                        width: 60,
                        height: 45,
                        alignment: Alignment.center,
                        child: Text(
                          quantity.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _quantityButton(
                        icon: Icons.add,
                        onPressed: increaseQuantity,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Total + Add to Cart
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(
                              left: 15,
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  '₹${totalPrice.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: addToCart,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor:
                                AppTheme.primaryColor,
                            minimumSize:
                                const Size(155, 50),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // QUANTITY BUTTON
  // ------------------------------------------------------------

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(13),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}