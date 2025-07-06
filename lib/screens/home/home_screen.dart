import 'package:flutter/material.dart';
import '../../generated/assets.dart';
import '../../theme/font_theme.dart';
import '../profile/profile_screen.dart';
import '../../widgets/main_tab_screen.dart.dart';
import '../foods/food_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/homeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;

  final List<Map<String, dynamic>> categories = [
    {'icon': Assets.burger, 'label': 'Burger'},
    {'icon': Assets.taco, 'label': 'Taco'},
    {'icon': Assets.drink, 'label': 'Drink'},
    {'icon': Assets.pizza, 'label': 'Pizza'},
  ];

  final List<Map<String, dynamic>> foods = [
    {
      'image': 'assets/images/onboard/onboard_01.png',
      'title': 'Ordinary Burgers',
      'rating': 4.9,
      'distance': '190m',
      'price': '17,230',
      'favorite': true,
    },
    {
      'image': 'assets/images/onboard/onboard_02.png',
      'title': 'Burger With Meat',
      'rating': 4.9,
      'distance': '190m',
      'price': '17,230',
      'favorite': true,
    },
    {
      'image': 'assets/images/onboard/onboard_03.png',
      'title': 'Cheese Burger',
      'rating': 4.8,
      'distance': '200m',
      'price': '16,000',
      'favorite': false,
    },
    {
      'image': 'assets/images/onboard/onboard_01.png',
      'title': 'Veggie Burger',
      'rating': 4.7,
      'distance': '210m',
      'price': '15,500',
      'favorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.homeBg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Your Location',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ],
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(
                                  minWidth: 36,
                                  minHeight: 36,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.notifications_none_outlined,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                  ).pushNamed(ProfileScreen.route);
                                },
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(
                                  minWidth: 36,
                                  minHeight: 36,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'New York City',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(right: 32),
                      child: Text(
                        'Provide the best food for you',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Category Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Find by Category',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text('See All')),
                ],
              ),
            ),
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = _selectedCategory == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = index;
                      });
                    },
                    child: Container(
                      width: 85,
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.orange : Colors.white70,
                        borderRadius: BorderRadius.circular(16),
                        border: isSelected
                            ? Border.all(color: Colors.orange, width: 2)
                            : null,
                      ),
                      child: Column(
                        children: [
                          Image.asset(cat['icon'], width: 25, height: 25),
                          SizedBox(height: 4),
                          Text(
                            cat['label'],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Food Cards
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: GridView.builder(
                  itemCount: foods.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(FoodDetailScreen.route);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Image section
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: Image.asset(
                                    food['image'],
                                    width: double.infinity,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        foods[index]['favorite'] =
                                            !food['favorite'];
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        food['favorite']
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: food['favorite']
                                            ? Colors.red
                                            : Colors.grey,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Content section
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      food['title'],
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${food['rating']}',
                                          style: theme.textTheme.labelMedium,
                                        ),
                                        const SizedBox(width: 12),
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          food['distance'],
                                          style: theme.textTheme.labelMedium,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '${food['price']}',
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
