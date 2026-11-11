import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/food.dart';
import '../models/restaurant.dart';
import '../theme/app_theme.dart';
import 'food_details_screen.dart';
import 'restaurant_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() =>
      _SearchScreenState();
}

class _SearchScreenState
    extends State<SearchScreen> {
  final searchController = TextEditingController();

  String searchText = '';

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      setState(() {
        searchText = searchController.text.trim();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Food> get foodResults {
    if (searchText.isEmpty) {
      return [];
    }

    final query = searchText.toLowerCase();

    return DummyData.foods.where((food) {
      return food.name.toLowerCase().contains(query) ||
          food.category.toLowerCase().contains(query) ||
          food.restaurantName
              .toLowerCase()
              .contains(query);
    }).toList();
  }

  List<Restaurant> get restaurantResults {
    if (searchText.isEmpty) {
      return [];
    }

    final query = searchText.toLowerCase();

    return DummyData.restaurants.where((restaurant) {
      return restaurant.name
              .toLowerCase()
              .contains(query) ||
          restaurant.cuisine
              .toLowerCase()
              .contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final foods = foodResults;
    final restaurants = restaurantResults;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              15,
            ),
            child: TextField(
              controller: searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search food or restaurants...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          searchController.clear();
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,
              ),
            ),
          ),

          Expanded(
            child: searchText.isEmpty
                ? _buildSearchInitial()
                : foods.isEmpty &&
                        restaurants.isEmpty
                    ? _buildNoResults()
                    : ListView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        children: [
                          if (restaurants.isNotEmpty) ...[
                            const Text(
                              'Restaurants',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...restaurants.map(
                              (restaurant) =>
                                  _restaurantResult(
                                restaurant,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],

                          if (foods.isNotEmpty) ...[
                            const Text(
                              'Food',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...foods.map(
                              (food) => _foodResult(food),
                            ),
                          ],

                          const SizedBox(height: 30),
                        ],
                      ),
          ),
        ],
      ),
    );
  }

  Widget _restaurantResult(
    Restaurant restaurant,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            restaurant.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (
              context,
              error,
              stackTrace,
            ) {
              return Container(
                width: 60,
                height: 60,
                color: Colors.grey.shade200,
                child: const Icon(
                  Icons.restaurant,
                  color: AppTheme.primaryColor,
                ),
              );
            },
          ),
        ),
        title: Text(
          restaurant.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '${restaurant.cuisine} • ${restaurant.deliveryTime}',
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.greyColor,
            ),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  RestaurantDetailsScreen(
                restaurant: restaurant,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _foodResult(Food food) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            food.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (
              context,
              error,
              stackTrace,
            ) {
              return Container(
                width: 60,
                height: 60,
                color: Colors.grey.shade200,
                child: const Icon(
                  Icons.fastfood,
                  color: AppTheme.primaryColor,
                ),
              );
            },
          ),
        ),
        title: Text(
          food.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            '${food.restaurantName} • ₹${food.price.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.greyColor,
            ),
          ),
        ),
        trailing: Text(
          '★ ${food.rating}',
          style: const TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  FoodDetailsScreen(food: food),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchInitial() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor
                    .withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search,
                size: 55,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'What are you craving?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Search for your favourite food or restaurant.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 70,
              color: AppTheme.greyColor,
            ),
            const SizedBox(height: 15),
            const Text(
              'No results found',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We could not find anything for "$searchText".',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}