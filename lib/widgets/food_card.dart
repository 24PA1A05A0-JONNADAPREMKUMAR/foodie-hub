import 'package:flutter/material.dart';

import '../models/food.dart';
import '../data/app_state.dart';
import '../screens/cart_screen.dart';

class FoodCard extends StatelessWidget {
  final Food food;
  final VoidCallback? onTap;
  final VoidCallback? onAdd;

  const FoodCard({
    super.key,
    required this.food,
    this.onTap,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final appState = AppState.instance;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: Image.network(
                    food.imageUrl,
                    height: 125,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 125,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Icon(
                            Icons.fastfood,
                            size: 45,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Rating
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          food.rating.toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Favorite
                Positioned(
                  top: 7,
                  right: 7,
                  child: ListenableBuilder(
                    listenable: appState,
                    builder: (context, child) {
                      final favorite =
                          appState.isFavorite(food.id);

                      return Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            appState.toggleFavorite(food.id);

                            ScaffoldMessenger.of(context)
                                .hideCurrentSnackBar();

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  favorite
                                      ? '${food.name} removed from favorites'
                                      : '${food.name} added to favorites',
                                ),
                                duration:
                                    const Duration(seconds: 1),
                                behavior:
                                    SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(7),
                            child: Icon(
                              favorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 19,
                              color: favorite
                                  ? Colors.pink
                                  : Colors.grey.shade700,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            // Food information
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  10,
                  8,
                  8,
                  7,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      food.restaurantName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const Spacer(),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${food.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6B35),
                          ),
                        ),

                        // Add to Cart
                        Material(
                          color: const Color(0xFFFF6B35),
                          borderRadius:
                              BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius:
                                BorderRadius.circular(10),
                            onTap: () {
                              // Add exactly 1 item
                              appState.addToCart(
                                food,
                                quantity: 1,
                              );

                              // Remove any previous SnackBar
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();

                              // Show new SnackBar
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${food.name} added to cart',
                                  ),
                                  duration:
                                      const Duration(seconds: 1),
                                  behavior:
                                      SnackBarBehavior.floating,
                                  action: SnackBarAction(
                                    label: 'VIEW CART',
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const CartScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );

                              // Notify parent only.
                              // Do NOT show another SnackBar
                              // from HomeScreen.
                              onAdd?.call();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(7),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 19,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}