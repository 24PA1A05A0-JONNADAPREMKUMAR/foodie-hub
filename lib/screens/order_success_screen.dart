import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'home_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  final double totalAmount;

  const OrderSuccessScreen({
    super.key,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                // ==================================================
                // SUCCESS ICON
                // ==================================================

                Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    size: 85,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 30),

                // ==================================================
                // TITLE
                // ==================================================

                const Text(
                  'Order Placed!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Your delicious food is on its way.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.greyColor,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 25),

                // ==================================================
                // ORDER SUMMARY
                // ==================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Order Total',
                        style: TextStyle(
                          color: AppTheme.greyColor,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        '₹${totalAmount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Divider(),

                      const SizedBox(height: 10),

                      const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 18,
                            color: AppTheme.primaryColor,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Estimated delivery: 30–40 min',
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                // ==================================================
                // BACK TO HOME
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 53,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HomeScreen(
                            initialIndex: 0,
                          ),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ==================================================
                // VIEW MY ORDERS
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 53,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HomeScreen(
                            initialIndex: 2,
                          ),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'View My Orders',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}