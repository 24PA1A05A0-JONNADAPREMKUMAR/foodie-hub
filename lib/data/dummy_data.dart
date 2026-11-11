import '../models/food.dart';
import '../models/restaurant.dart';

class DummyData {
  // --------------------------------------------------
  // RESTAURANTS
  // --------------------------------------------------

  static final List<Restaurant> restaurants = [
    Restaurant(
      id: 'r1',
      name: 'Spice Garden',
      description:
          'Authentic Indian cuisine prepared with fresh ingredients and traditional spices.',
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
      cuisine: 'Indian • Biryani',
      deliveryTime: '25-30 min',
      distance: '1.2 km',
    ),

    Restaurant(
      id: 'r2',
      name: 'Pizza Paradise',
      description:
          'Delicious handcrafted pizzas with fresh toppings and cheesy goodness.',
      rating: 4.6,
      imageUrl:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591',
      cuisine: 'Pizza • Italian',
      deliveryTime: '20-25 min',
      distance: '2.1 km',
    ),

    Restaurant(
      id: 'r3',
      name: 'Burger House',
      description:
          'Juicy burgers, crispy fries and refreshing drinks made for burger lovers.',
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1571091718767-18b5b1457add',
      cuisine: 'Burgers • Fast Food',
      deliveryTime: '15-20 min',
      distance: '1.8 km',
    ),

    Restaurant(
      id: 'r4',
      name: 'Dragon Bowl',
      description:
          'Aromatic Chinese dishes prepared with authentic flavors and fresh vegetables.',
      rating: 4.5,
      imageUrl:
          'https://images.unsplash.com/photo-1563245372-f21724e3856d',
      cuisine: 'Chinese • Asian',
      deliveryTime: '30-35 min',
      distance: '2.5 km',
    ),

    Restaurant(
      id: 'r5',
      name: 'Andhra Spice',
      description:
          'Authentic Andhra meals and spicy local specialties.',
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=900&q=80',
      cuisine: 'Andhra • Indian',
      deliveryTime: '25-30 min',
      distance: '1.8 km',
    ),

    Restaurant(
      id: 'r6',
      name: 'The Dessert Lab',
      description:
          'Cakes, brownies, ice creams and delicious desserts.',
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1551024506-0bccd828d307?auto=format&fit=crop&w=900&q=80',
      cuisine: 'Desserts • Bakery',
      deliveryTime: '20-25 min',
      distance: '2.1 km',
    ),

    Restaurant(
      id: 'r7',
      name: 'Green Bowl',
      description:
          'Healthy salads, fresh bowls and nutritious meals.',
      rating: 4.6,
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=900&q=80',
      cuisine: 'Healthy • Salads',
      deliveryTime: '20-25 min',
      distance: '2.5 km',
    ),

    Restaurant(
      id: 'r8',
      name: 'Tandoori Tales',
      description:
          'North Indian tandoori dishes and rich curries.',
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=900&q=80',
      cuisine: 'North Indian • Tandoori',
      deliveryTime: '30-35 min',
      distance: '3.0 km',
    ),
  ];

  // --------------------------------------------------
  // FOOD ITEMS
  // --------------------------------------------------

  static final List<Food> foods = [
    Food(
      id: 'f1',
      name: 'Chicken Biryani',
      description:
          'Aromatic basmati rice cooked with tender chicken and traditional spices.',
      price: 220,
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1589302168068-964664d93dc0?auto=format&fit=crop&w=800&q=80',
      category: 'Biryani',
      restaurantName: 'Spice Garden',
    ),

    Food(
      id: 'f2',
      name: 'Margherita Pizza',
      description:
          'Classic pizza topped with mozzarella cheese, tomato sauce and fresh basil.',
      price: 299,
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1574071318508-1cdbab80d002',
      category: 'Pizza',
      restaurantName: 'Pizza Paradise',
    ),

    Food(
      id: 'f3',
      name: 'Classic Burger',
      description:
          'Juicy grilled chicken patty with fresh lettuce, tomato and creamy sauce.',
      price: 189,
      rating: 4.6,
      imageUrl:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
      category: 'Burgers',
      restaurantName: 'Burger House',
    ),

    Food(
      id: 'f4',
      name: 'Paneer Tikka',
      description:
          'Soft paneer cubes marinated with spices and grilled to perfection.',
      price: 180,
      rating: 4.5,
      imageUrl:
          'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8',
      category: 'Indian',
      restaurantName: 'Spice Garden',
    ),

    Food(
      id: 'f5',
      name: 'Veg Noodles',
      description:
          'Stir-fried noodles with fresh vegetables and delicious Asian sauces.',
      price: 160,
      rating: 4.4,
      imageUrl:
          'https://images.unsplash.com/photo-1569718212165-3a8278d5f624',
      category: 'Chinese',
      restaurantName: 'Dragon Bowl',
    ),

    Food(
      id: 'f6',
      name: 'Chocolate Cake',
      description:
          'Rich and soft chocolate cake covered with creamy chocolate frosting.',
      price: 140,
      rating: 4.9,
      imageUrl:
          'https://images.unsplash.com/photo-1578985545062-69928b1d9587',
      category: 'Desserts',
      restaurantName: 'Sweet Corner',
    ),

    Food(
      id: 'f7',
      name: 'French Fries',
      description:
          'Crispy golden potato fries served with delicious dipping sauce.',
      price: 99,
      rating: 4.5,
      imageUrl:
          'https://images.unsplash.com/photo-1573080496219-bb080dd4f877',
      category: 'Fast Food',
      restaurantName: 'Burger House',
    ),

    Food(
      id: 'f8',
      name: 'Fresh Fruit Bowl',
      description:
          'A healthy bowl filled with fresh seasonal fruits.',
      price: 150,
      rating: 4.6,
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
      category: 'Healthy',
      restaurantName: 'Green Bowl',
    ),

    Food(
      id: 'f9',
      name: 'Butter Chicken',
      description:
          'Creamy tomato-based chicken curry with Indian spices.',
      price: 280,
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=900&q=80',
      category: 'Indian',
      restaurantName: 'Tandoori Tales',
    ),

    Food(
      id: 'f10',
      name: 'Chicken 65',
      description:
          'Crispy and spicy South Indian style chicken starter.',
      price: 220,
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1562967916-eb82221dfb92?auto=format&fit=crop&w=900&q=80',
      category: 'Indian',
      restaurantName: 'Andhra Spice',
    ),

    Food(
      id: 'f11',
      name: 'Veg Fried Rice',
      description:
          'Fragrant fried rice with fresh vegetables.',
      price: 170,
      rating: 4.5,
      imageUrl:
          'https://images.unsplash.com/photo-1603133872878-684f208fb84b?auto=format&fit=crop&w=900&q=80',
      category: 'Chinese',
      restaurantName: 'Dragon Bowl',
    ),

    Food(
      id: 'f12',
      name: 'Chicken Noodles',
      description:
          'Stir-fried noodles with chicken and vegetables.',
      price: 210,
      rating: 4.6,
      imageUrl:
          'https://images.unsplash.com/photo-1612929633738-8fe44f7ec841?auto=format&fit=crop&w=900&q=80',
      category: 'Chinese',
      restaurantName: 'Dragon Bowl',
    ),

    Food(
      id: 'f13',
      name: 'Pepperoni Pizza',
      description:
          'Classic pizza topped with pepperoni and melted cheese.',
      price: 349,
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1628840042765-356cda07504e?auto=format&fit=crop&w=900&q=80',
      category: 'Pizza',
      restaurantName: 'Pizza Paradise',
    ),

    Food(
      id: 'f14',
      name: 'Cheese Burger',
      description:
          'Juicy burger with cheese, lettuce and special sauce.',
      price: 229,
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=900&q=80',
      category: 'Burgers',
      restaurantName: 'Burger House',
    ),

    Food(
      id: 'f15',
      name: 'Gulab Jamun',
      description:
          'Soft milk dumplings soaked in sweet sugar syrup.',
      price: 110,
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1601303516534-0b0b2f7f4b31?auto=format&fit=crop&w=900&q=80',
      category: 'Desserts',
      restaurantName: 'The Dessert Lab',
    ),

    Food(
      id: 'f16',
      name: 'Brownie',
      description:
          'Rich chocolate brownie with a soft and fudgy center.',
      price: 130,
      rating: 4.9,
      imageUrl:
          'https://images.unsplash.com/photo-1564355808539-22fda35bed7e?auto=format&fit=crop&w=900&q=80',
      category: 'Desserts',
      restaurantName: 'The Dessert Lab',
    ),

    Food(
      id: 'f17',
      name: 'Fresh Lemonade',
      description:
          'Refreshing chilled lemonade made with fresh lemons.',
      price: 80,
      rating: 4.5,
      imageUrl:
          'https://images.unsplash.com/photo-1523677011781-c91d1bbe2f9e?auto=format&fit=crop&w=900&q=80',
      category: 'Drinks',
      restaurantName: 'Green Bowl',
    ),

    Food(
      id: 'f18',
      name: 'Caesar Salad',
      description:
          'Fresh lettuce, vegetables and creamy Caesar dressing.',
      price: 190,
      rating: 4.6,
      imageUrl:
          'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?auto=format&fit=crop&w=900&q=80',
      category: 'Healthy',
      restaurantName: 'Green Bowl',
    ),

    Food(
      id: 'f19',
      name: 'Paneer Butter Masala',
      description:
          'Soft paneer cooked in a rich creamy tomato gravy.',
      price: 240,
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?auto=format&fit=crop&w=900&q=80',
      category: 'Indian',
      restaurantName: 'Andhra Spice',
    ),

    Food(
      id: 'f20',
      name: 'Masala Dosa',
      description:
          'Crispy South Indian dosa served with potato masala.',
      price: 120,
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1630383249896-424e482df921?auto=format&fit=crop&w=900&q=80',
      category: 'Indian',
      restaurantName: 'Andhra Spice',
    ),

    Food(
      id: 'food_drink_1',
      name: 'Fresh Lemonade',
      description:
          'Refreshing homemade lemonade with fresh lemon and mint.',
      price: 80,
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1621263764928-df1444c5a8b5?auto=format&fit=crop&w=800&q=80',
      category: 'Drinks',
      restaurantName: 'Green Bowl',
    ),

    Food(
      id: 'food_drink_2',
      name: 'Mango Juice',
      description:
          'Fresh and delicious mango juice made with ripe mangoes.',
      price: 100,
      rating: 4.6,
      imageUrl:
          'https://images.unsplash.com/photo-1623065422902-30a2d299bbe4?auto=format&fit=crop&w=800&q=80',
      category: 'Drinks',
      restaurantName: 'Green Bowl',
    ),

    Food(
      id: 'food_drink_3',
      name: 'Cold Coffee',
      description:
          'Chilled creamy coffee with a smooth and rich taste.',
      price: 120,
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?auto=format&fit=crop&w=800&q=80',
      category: 'Drinks',
      restaurantName: 'The Dessert Lab',
    ),

    Food(
      id: 'food_drink_4',
      name: 'Strawberry Shake',
      description:
          'Creamy strawberry milkshake topped with fresh strawberries.',
      price: 150,
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1572490122747-3968b75cc699?auto=format&fit=crop&w=800&q=80',
      category: 'Drinks',
      restaurantName: 'The Dessert Lab',
    ),
  ];

  // --------------------------------------------------
  // CATEGORIES
  // --------------------------------------------------

  static final List<Map<String, dynamic>> categories = [
    {
      'name': 'Pizza',
      'icon': '🍕',
    },
    {
      'name': 'Burgers',
      'icon': '🍔',
    },
    {
      'name': 'Biryani',
      'icon': '🍛',
    },
    {
      'name': 'Indian',
      'icon': '🥘',
    },
    {
      'name': 'Chinese',
      'icon': '🍜',
    },
    {
      'name': 'Desserts',
      'icon': '🍰',
    },
    {
      'name': 'Drinks',
      'icon': '🥤',
    },
    {
      'name': 'Healthy',
      'icon': '🥗',
    },
  ];
}