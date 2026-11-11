import 'package:flutter/material.dart';

import '../data/app_state.dart';
import '../theme/app_theme.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() =>
      _CheckoutScreenState();
}

class _CheckoutScreenState
    extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController =
      TextEditingController(text: 'Prem Kumar');

  final phoneController =
      TextEditingController(text: '9876543210');

  final addressController =
      TextEditingController(
    text: 'Tanuku, Andhra Pradesh',
  );

  String selectedPayment = 'Cash on Delivery';

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void placeOrder() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final total = AppState.instance.total;
    
    AppState.instance.saveOrder();

    AppState.instance.clearCart();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrderSuccessScreen(
          totalAmount: total,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon:
                    Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon:
                    Icon(Icons.phone_outlined),
              ),
              validator: (value) {
                if (value == null ||
                    value.length != 10) {
                  return 'Enter a valid 10-digit number';
                }
                return null;
              },
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Delivery Address',
                prefixIcon:
                    Icon(Icons.location_on_outlined),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().length < 5) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),

            const SizedBox(height: 30),

            const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _paymentOption(
              title: 'Cash on Delivery',
              subtitle:
                  'Pay when your order arrives',
              icon: Icons.payments_outlined,
            ),

            const SizedBox(height: 10),

            _paymentOption(
              title: 'UPI',
              subtitle:
                  'Pay securely using UPI',
              icon: Icons.account_balance_outlined,
            ),

            const SizedBox(height: 10),

            _paymentOption(
              title: 'Credit / Debit Card',
              subtitle:
                  'Visa, Mastercard and more',
              icon: Icons.credit_card_outlined,
            ),

            const SizedBox(height: 30),

            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _summaryRow(
                    'Items',
                    '${AppState.instance.itemCount}',
                  ),
                  const SizedBox(height: 10),
                  _summaryRow(
                    'Subtotal',
                    '₹${AppState.instance.subtotal.toStringAsFixed(0)}',
                  ),
                  const SizedBox(height: 10),
                  _summaryRow(
                    'Delivery',
                    AppState.instance.deliveryFee == 0
                        ? 'FREE'
                        : '₹${AppState.instance.deliveryFee.toStringAsFixed(0)}',
                  ),
                  const Divider(height: 25),
                  _summaryRow(
                    'Total',
                    '₹${AppState.instance.total.toStringAsFixed(0)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: placeOrder,
                child: Text(
                  'Place Order • ₹${AppState.instance.total.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final bool selected =
        selectedPayment == title;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        setState(() {
          selectedPayment = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.primaryColor
                  .withOpacity(0.08)
              : Colors.white,
          borderRadius:
              BorderRadius.circular(16),
          border: Border.all(
            color: selected
                ? AppTheme.primaryColor
                : Colors.black12,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected
                  ? AppTheme.primaryColor
                  : AppTheme.greyColor,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppTheme.greyColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: title,
              groupValue: selectedPayment,
              activeColor:
                  AppTheme.primaryColor,
              onChanged: (value) {
                setState(() {
                  selectedPayment = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(
    String title,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 17 : 14,
            fontWeight: isTotal
                ? FontWeight.bold
                : FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 19 : 14,
            fontWeight: FontWeight.bold,
            color: isTotal
                ? AppTheme.primaryColor
                : AppTheme.textColor,
          ),
        ),
      ],
    );
  }
}