import 'package:flutter/material.dart';

import '../data/app_state.dart';
import '../data/dummy_data.dart';
import '../widgets/category_card.dart';
import '../widgets/food_card.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/promo_banner.dart';
import '../widgets/custom_bottom_nav.dart';

import 'categories_screen.dart';
import 'restaurant_details_screen.dart';
import 'food_details_screen.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  // Allows another screen to open HomeScreen
  // with a specific bottom-navigation tab selected.
  //
  // 0 = Home
  // 1 = Categories
  // 2 = Orders
  // 3 = Favorites
  // 4 = Profile
  final int initialIndex;

  const HomeScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int selectedIndex;

  final AppState appState = AppState.instance;

  @override
  void initState() {
    super.initState();

    // Start with the requested bottom-navigation tab.
    selectedIndex = widget.initialIndex;
  }

  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // ------------------------------------------------------------
  // OPEN ALL RESTAURANTS
  // ------------------------------------------------------------

  void openAllRestaurants() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AllRestaurantsScreen(),
      ),
    );
  }

  // ------------------------------------------------------------
  // OPEN ALL FOODS
  // ------------------------------------------------------------

  void openAllFoods() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CategoriesScreen(
          selectedCategory: 'All',
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // OPEN CATEGORY
  // ------------------------------------------------------------

  void openCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoriesScreen(
          selectedCategory: category,
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // BUILD HOME CONTENT
  // ------------------------------------------------------------

  Widget buildHomeContent() {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // ======================================================
          // HEADER
          // ======================================================

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                18,
                16,
                8,
              ),
              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '👩‍🍳',
                        style: TextStyle(fontSize: 26),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello Foodie 👋',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'What are you craving?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // CART
                  ListenableBuilder(
                    listenable: appState,
                    builder: (context, child) {
                      final count = appState.itemCount;

                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const CartScreen(),
                                ),
                              ).then((_) {
                                setState(() {});
                              });
                            },
                            icon: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 27,
                            ),
                          ),

                          if (count > 0)
                            Positioned(
                              right: 2,
                              top: 1,
                              child: Container(
                                constraints:
                                    const BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 2,
                                ),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '$count',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // ======================================================
          // LOCATION
          // ======================================================

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFFFF6B35),
                    size: 19,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Tanuku, Andhra Pradesh',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),

          // ======================================================
          // SEARCH
          // ======================================================

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                16,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SearchScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Search for food or restaurants',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ======================================================
          // PROMO BANNER
          // ======================================================

          SliverToBoxAdapter(
            child: PromoBanner(
              onTap: openAllFoods,
            ),
          ),

          // ======================================================
          // CATEGORIES TITLE
          // ======================================================

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                24,
                16,
                12,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const CategoriesScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Color(0xFFFF6B35),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ======================================================
          // CATEGORIES
          // ======================================================

          SliverToBoxAdapter(
            child: SizedBox(
              height: 108,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: DummyData.categories.length,
                itemBuilder: (context, index) {
                  final category =
                      DummyData.categories[index];

                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: CategoryCard(
                      category: category['name']!,
                      icon: category['icon']!,
                      onTap: () {
                        openCategory(
                          category['name']!,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // ======================================================
          // RESTAURANTS TITLE
          // ======================================================

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                25,
                16,
                12,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Restaurants',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  GestureDetector(
                    onTap: openAllRestaurants,
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Color(0xFFFF6B35),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ======================================================
          // RESTAURANTS HORIZONTAL LIST
          // ======================================================

          SliverToBoxAdapter(
            child: SizedBox(
              height: 245,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                scrollDirection: Axis.horizontal,

                itemCount: DummyData.restaurants.length > 4
                    ? 4
                    : DummyData.restaurants.length,

                itemBuilder: (context, index) {
                  final restaurant =
                      DummyData.restaurants[index];

                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 12,
                    ),
                    child: SizedBox(
                      width: 245,
                      child: RestaurantCard(
                        restaurant: restaurant,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  RestaurantDetailsScreen(
                                restaurant: restaurant,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // ======================================================
          // POPULAR FOOD TITLE
          // ======================================================

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                25,
                16,
                12,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Food',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  GestureDetector(
                    onTap: openAllFoods,
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Color(0xFFFF6B35),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ======================================================
          // FOOD GRID
          // ======================================================

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              16,
              0,
              16,
              30,
            ),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final food = DummyData.foods[index];

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

                    // FoodCard handles:
                    // - adding to cart
                    // - SnackBar
                    // - VIEW CART
                    //
                    // Home only rebuilds so the cart badge
                    // is immediately updated.
                    onAdd: () {
                      setState(() {});
                    },
                  );
                },

                childCount: DummyData.foods.length > 6
                    ? 6
                    : DummyData.foods.length,
              ),

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.67,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final screens = [
      buildHomeContent(),
      const CategoriesScreen(),
      const OrdersScreen(),
      const FavoritesScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),

      bottomNavigationBar: CustomBottomNav(
        currentIndex: selectedIndex,
        onTap: changeTab,
      ),
    );
  }
}

// =================================================================
// ALL RESTAURANTS SCREEN
// =================================================================

class AllRestaurantsScreen extends StatelessWidget {
  const AllRestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurants = DummyData.restaurants;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'All Restaurants',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: restaurants.isEmpty
          ? const Center(
              child: Text(
                'No restaurants available',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];

                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                  ),
                  child: SizedBox(
                    height: 245,
                    child: RestaurantCard(
                      restaurant: restaurant,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                RestaurantDetailsScreen(
                              restaurant: restaurant,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}