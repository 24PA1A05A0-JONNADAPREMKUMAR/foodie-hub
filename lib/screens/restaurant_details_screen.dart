import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/restaurant.dart';
import '../theme/app_theme.dart';
import '../widgets/food_card.dart';
import 'food_details_screen.dart';
import '../data/app_state.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({
    super.key,
    required this.restaurant,
  });

  List get restaurantFoods {
    return DummyData.foods
        .where(
          (food) =>
              food.restaurantName.toLowerCase() ==
              restaurant.name.toLowerCase(),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Restaurant image header
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    restaurant.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.restaurant,
                          size: 70,
                          color: AppTheme.primaryColor,
                        ),
                      );
                    },
                  ),

                  // Dark overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.05),
                          Colors.black.withOpacity(0.75),
                        ],
                      ),
                    ),
                  ),

                  // Restaurant name
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: Text(
                      restaurant.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Restaurant information
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating and delivery details
                  Row(
                    children: [
                      _infoChip(
                        icon: Icons.star,
                        text: restaurant.rating.toString(),
                        iconColor: Colors.amber.shade700,
                      ),
                      const SizedBox(width: 10),
                      _infoChip(
                        icon: Icons.access_time,
                        text: restaurant.deliveryTime,
                      ),
                      const SizedBox(width: 10),
                      _infoChip(
                        icon: Icons.location_on_outlined,
                        text: restaurant.distance,
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Text(
                    restaurant.cuisine,
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    restaurant.description,
                    style: const TextStyle(
                      color: AppTheme.greyColor,
                      height: 1.5,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '${restaurantFoods.length} delicious items',
                    style: const TextStyle(
                      color: AppTheme.greyColor,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),

          // Restaurant food list
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              20,
              0,
              20,
              30,
            ),
            sliver: restaurantFoods.isEmpty
                ? SliverToBoxAdapter(
                    child: _emptyMenu(),
                  )
                : SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final food = restaurantFoods[index];

                        return FoodCard(
                          food: food,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FoodDetailsScreen(food: food),
                              ),
                            );
                          },
                          onAdd: () {
                            AppState.instance.addToCart(food);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${food.name} added to cart'),
                              ),
                            );
                          },
                        );
                      },
                      childCount: restaurantFoods.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.72,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip({
    required IconData icon,
    required String text,
    Color? iconColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 7,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: iconColor ?? AppTheme.primaryColor,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyMenu() {
    return const Padding(
      padding: EdgeInsets.all(40),
      child: Center(
        child: Text(
          'No menu items available.',
          style: TextStyle(
            color: AppTheme.greyColor,
          ),
        ),
      ),
    );
  }
}