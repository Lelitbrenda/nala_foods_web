class RestaurantData {
  final String name;
  final String image;
  final double rating;
  final String deliveryTime;
  final String category;
  final bool isPopular;

  const RestaurantData({
    required this.name,
    required this.image,
    required this.rating,
    required this.deliveryTime,
    required this.category,
    this.isPopular = false,
  });
}

class FoodData {
  final String name;
  final String description;
  final String image;
  final double price;
  final String category;
  final String restaurantName;
  final double rating;

  const FoodData({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
    required this.restaurantName,
    required this.rating,
  });
}

final List<RestaurantData> restaurants = [
  RestaurantData(
    name: 'Mlima Restaurant',
    image: 'assets/Images/20260430_182141~2.jpg',
    rating: 4.8,
    deliveryTime: '25-35 min',
    category: 'Main Meals',
    isPopular: true,
  ),
  RestaurantData(
    name: 'Heaven Restaurant',
    image: 'assets/Images/20260430_182141~3.jpg',
    rating: 4.7,
    deliveryTime: '20-30 min',
    category: 'Main Meals',
    isPopular: true,
  ),
  RestaurantData(
    name: 'Nanyuki Restaurant',
    image: 'assets/Images/20260430_182201~2.jpg',
    rating: 4.6,
    deliveryTime: '30-45 min',
    category: 'Main Meals',
    isPopular: true,
  ),
  RestaurantData(
    name: 'Nyama & Chill',
    image: 'assets/Images/20260430_182141.jpg',
    rating: 4.9,
    deliveryTime: '25-40 min',
    category: 'African Grill',
    isPopular: true,
  ),
  RestaurantData(
    name: "Mama's Kitchen",
    image: 'assets/Images/20260515_110508.jpg',
    rating: 4.8,
    deliveryTime: '35-50 min',
    category: 'Home Cooking',
    isPopular: true,
  ),
  RestaurantData(
    name: 'Coastal Delights',
    image: 'assets/Images/20260515_110519.jpg',
    rating: 4.5,
    deliveryTime: '20-35 min',
    category: 'Seafood',
    isPopular: false,
  ),
];

final List<FoodData> popularFoods = [
  FoodData(
    name: 'Nyama Choma',
    description: 'Grilled seasoned beef with kachumbari',
    image: 'assets/Images/20260515_122857.jpg',
    price: 850,
    category: 'Main Meals',
    restaurantName: 'Mlima Restaurant',
    rating: 4.9,
  ),
  FoodData(
    name: 'Chicken Pilau',
    description: 'Spiced rice with tender chicken pieces',
    image: 'assets/Images/20260515_122912.jpg',
    price: 650,
    category: 'Main Meals',
    restaurantName: "Mama's Kitchen",
    rating: 4.8,
  ),
  FoodData(
    name: 'Fresh Fruit Juice',
    description: 'Mixed tropical fruit blend',
    image: 'assets/Images/20260524_194355.png',
    price: 250,
    category: 'Drinks',
    restaurantName: 'Heaven Restaurant',
    rating: 4.6,
  ),
  FoodData(
    name: 'Beef Samosas',
    description: 'Crispy fried pastries with spiced beef',
    image: 'assets/Images/ChatGPT Image May 26, 2026, 09_49_52 AM.png',
    price: 350,
    category: 'Snacks',
    restaurantName: 'Nanyuki Restaurant',
    rating: 4.7,
  ),
  FoodData(
    name: 'Grilled Fish',
    description: 'Whole tilapia grilled to perfection',
    image: 'assets/Images/20260430_182141~2.jpg',
    price: 950,
    category: 'Main Meals',
    restaurantName: 'Coastal Delights',
    rating: 4.9,
  ),
  FoodData(
    name: 'Mandazi',
    description: 'Soft fluffy African doughnuts',
    image: 'assets/Images/20260515_122857.jpg',
    price: 150,
    category: 'Snacks',
    restaurantName: "Mama's Kitchen",
    rating: 4.5,
  ),
  FoodData(
    name: 'Ugali & Sukuma Wiki',
    description: 'Traditional maize meal with collard greens',
    image: 'assets/Images/20260515_110519.jpg',
    price: 450,
    category: 'Main Meals',
    restaurantName: 'Mlima Restaurant',
    rating: 4.7,
  ),
  FoodData(
    name: 'Chocolate Cake',
    description: 'Rich layered chocolate dessert',
    image: 'assets/Images/20260524_194355.png',
    price: 400,
    category: 'Desserts',
    restaurantName: 'Heaven Restaurant',
    rating: 4.8,
  ),
  FoodData(
    name: 'Chapati & Beans',
    description: 'Soft layered flatbread with stewed beans',
    image: 'assets/Images/20260430_182141~3.jpg',
    price: 350,
    category: 'Main Meals',
    restaurantName: 'Nanyuki Restaurant',
    rating: 4.6,
  ),
  FoodData(
    name: 'Mixed Grill Platter',
    description: 'Assorted meats with fries and salad',
    image: 'assets/Images/20260515_122912.jpg',
    price: 1500,
    category: 'Combos',
    restaurantName: 'Nyama & Chill',
    rating: 4.9,
  ),
];
