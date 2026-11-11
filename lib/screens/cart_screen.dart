import 'package:flutter/material.dart';

import '../data/app_state.dart';
import '../theme/app_theme.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = AppState.instance.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              onPressed: () {
                _showClearCartDialog(context);
              },
              icon: const Icon(
                Icons.delete_outline,
              ),
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];

                      return _buildCartItem(item);
                    },
                  ),
                ),

                _buildBottomSummary(),
              ],
            ),
    );
  }

  Widget _buildCartItem(item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              item.food.imageUrl,
              width: 85,
              height: 85,
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  width: 85,
                  height: 85,
                  color: Colors.grey.shade200,
                  child: const Icon(
                    Icons.fastfood,
                    color: AppTheme.primaryColor,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  item.food.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  '₹${item.food.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    _smallQuantityButton(
                      icon: Icons.remove,
                      onPressed: () {
                        AppState.instance.decreaseQuantity(
                          item.food.id,
                        );
                        refresh();
                      },
                    ),

                    SizedBox(
                      width: 35,
                      child: Center(
                        child: Text(
                          item.quantity.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    _smallQuantityButton(
                      icon: Icons.add,
                      onPressed: () {
                        AppState.instance.increaseQuantity(
                          item.food.id,
                        );
                        refresh();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  AppState.instance.removeFromCart(
                    item.food.id,
                  );
                  refresh();
                },
                icon: const Icon(
                  Icons.close,
                  size: 20,
                  color: Colors.grey,
                ),
              ),
              Text(
                '₹${item.totalPrice.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }

  Widget _buildBottomSummary() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        25,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        children: [
          _summaryRow(
            'Subtotal',
            '₹${AppState.instance.subtotal.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 10),
          _summaryRow(
            'Delivery Fee',
            AppState.instance.deliveryFee == 0
                ? 'FREE'
                : '₹${AppState.instance.deliveryFee.toStringAsFixed(0)}',
            valueColor: AppState.instance.deliveryFee == 0
                ? Colors.green
                : null,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Divider(),
          ),
          _summaryRow(
            'Total',
            '₹${AppState.instance.total.toStringAsFixed(0)}',
            isTotal: true,
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const CheckoutScreen(),
                  ),
                );
              },
              child: const Text(
                'Proceed to Checkout',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String title,
    String value, {
    bool isTotal = false,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 17 : 14,
            fontWeight:
                isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal
                ? AppTheme.textColor
                : AppTheme.greyColor,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 19 : 14,
            fontWeight: FontWeight.bold,
            color: valueColor ??
                (isTotal
                    ? AppTheme.primaryColor
                    : AppTheme.textColor),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor
                    .withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 60,
                color: AppTheme.primaryColor,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Add some delicious food to get started!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.greyColor,
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.restaurant_menu,
              ),
              label: const Text('Explore Food'),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearCartDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear Cart?'),
          content: const Text(
            'Are you sure you want to remove all items from your cart?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                AppState.instance.clearCart();
                Navigator.pop(context);
                refresh();
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }
}