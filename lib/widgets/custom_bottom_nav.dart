import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<IconData> icons = [
    Icons.home_outlined,
    Icons.category_outlined,
    Icons.receipt_long_outlined,
    Icons.favorite_border,
    Icons.person_outline,
  ];

  static const List<IconData> selectedIcons = [
    Icons.home,
    Icons.category,
    Icons.receipt_long,
    Icons.favorite,
    Icons.person,
  ];

  static const List<String> labels = [
    'Home',
    'Categories',
    'Orders',
    'Favorites',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: List.generate(
              labels.length,
              (index) {
                final bool selected =
                    currentIndex == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(index),
                    child: AnimatedContainer(
                      duration:
                          const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppTheme.primaryColor
                                .withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min,
                        children: [
                          Icon(
                            selected
                                ? selectedIcons[index]
                                : icons[index],
                            color: selected
                                ? AppTheme.primaryColor
                                : AppTheme.greyColor,
                            size: 22,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            labels[index],
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: selected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: selected
                                  ? AppTheme.primaryColor
                                  : AppTheme.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}