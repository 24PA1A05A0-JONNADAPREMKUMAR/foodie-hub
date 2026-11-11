import 'package:flutter/material.dart';

import '../data/app_state.dart';
import '../data/dummy_data.dart';
import '../models/food.dart';
import '../widgets/food_card.dart';
import 'food_details_screen.dart';

class CategoriesScreen extends StatefulWidget {
  final String? selectedCategory;

  const CategoriesScreen({
    super.key,
    this.selectedCategory,
  });

  @override
  State<CategoriesScreen> createState() =>
      _CategoriesScreenState();
}

class _CategoriesScreenState
    extends State<CategoriesScreen> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();

    selectedCategory =
        widget.selectedCategory ?? 'All';
  }

  List<Food> get filteredFoods {
    if (selectedCategory == 'All') {
      return DummyData.foods;
    }

    return DummyData.foods.where((food) {
      return food.category.toLowerCase() ==
          selectedCategory.toLowerCase();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final foods = filteredFoods;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // CATEGORY LIST
          SizedBox(
            height: 105,
            child: ListView.builder(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount:
                  DummyData.categories.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _categoryItem(
                    'All',
                    '🍽️',
                  );
                }

                final category =
                    DummyData.categories[index - 1];

                return _categoryItem(
                  category['name']!,
                  category['icon']!,
                );
              },
            ),
          ),

          // SELECTED CATEGORY
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              5,
              16,
              5,
            ),
            child: Row(
              children: [
                Text(
                  selectedCategory == 'All'
                      ? 'All Foods'
                      : '$selectedCategory Foods',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${foods.length} items',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // FOOD GRID
          Expanded(
            child: foods.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.no_food_outlined,
                          size: 60,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'No foods found',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: foods.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.67,
                    ),
                    itemBuilder: (context, index) {
                      final food = foods[index];

                      return FoodCard(
                        food: food,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  FoodDetailsScreen(
                                food: food,
                              ),
                            ),
                          );
                        },
                        onAdd: () {
                          setState(() {
                            AppState.instance.addToCart(food);
                          });

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(
                              content: Text(
                                '${food.name} added to cart',
                              ),
                              duration:
                                  const Duration(seconds: 1),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _categoryItem(
    String name,
    String icon,
  ) {
    final isSelected =
        selectedCategory == name;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = name;
        });
      },
      child: Container(
        width: 78,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            AnimatedContainer(
              duration:
                  const Duration(milliseconds: 200),
              height: 62,
              width: 62,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFFF6B35)
                    : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  icon,
                  style:
                      const TextStyle(fontSize: 27),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}