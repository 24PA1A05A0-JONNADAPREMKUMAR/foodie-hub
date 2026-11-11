import 'package:flutter/material.dart';
import '../data/app_state.dart';
import '../data/dummy_data.dart';
import '../widgets/food_card.dart';
import 'food_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppState.instance;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: appState,
        builder: (context, child) {
          final favoriteFoods = DummyData.foods
              .where(
                (food) =>
                    appState.favoriteFoodIds.contains(food.id),
              )
              .toList();

          if (favoriteFoods.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        size: 50,
                        color: Colors.pink.shade300,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'No Favorites Yet',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Tap the heart icon on your favorite foods.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favoriteFoods.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.67,
            ),
            itemBuilder: (context, index) {
              final food = favoriteFoods[index];

              return FoodCard(
                food: food,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          FoodDetailsScreen(food: food),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}