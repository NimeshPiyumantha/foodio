import 'package:flutter/material.dart';
import '../../generated/assets.dart';

class FoodDetailScreen extends StatefulWidget {
  static const String route = '/food_detail';

  const FoodDetailScreen({super.key});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int quantity = 1;

  final Map<String, dynamic> food = {
    'image': Assets.onBoardUi2,
    'title': 'Burger With Meat',
    'price': '12,230',
    'emoji': '🍔',
    'delivery': 'Free Delivery',
    'time': '20 - 30',
    'rating': 4.5,
    'description':
        'Burger with Meat is a typical food from our restaurant, which is made from selected meat and fresh vegetables. This is very recommended for you.',
  };

  final List<Map<String, dynamic>> recommended = [
    {
      'image': Assets.onBoardUi1,
      'title': 'Ordinary Burgers',
      'price': '11,000',
    },
    {
      'image': Assets.onBoardUi3,
      'title': 'Cheese Burger',
      'price': '13,000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  food['image'],
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        food['title'],
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        food['emoji'],
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  Text(
                    '\$ ${food['price']}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.delivery_dining, color: Colors.orange, size: 18),
                  const SizedBox(width: 4),
                  Text(food['delivery'], style: theme.textTheme.labelMedium),
                  const SizedBox(width: 12),
                  Icon(Icons.access_time, color: Colors.orange, size: 18),
                  const SizedBox(width: 4),
                  Text(food['time'], style: theme.textTheme.labelMedium),
                  const SizedBox(width: 12),
                  Icon(Icons.star, color: Colors.orange, size: 18),
                  const SizedBox(width: 4),
                  Text('${food['rating']}', style: theme.textTheme.labelMedium),
                ],
              ),
              const SizedBox(height: 16),
              Text('Description', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                food['description'],
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recommended For You', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: Text('See All')),
                ],
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommended.length,
                  itemBuilder: (context, index) {
                    final rec = recommended[index];
                    return Container(
                      width: 120,
                      margin: EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.asset(
                              rec['image'],
                              width: 120,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  rec['title'],
                                  style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '\$ ${rec['price']}',
                                  style: theme.textTheme.labelLarge?.copyWith(color: Colors.orange),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 80), // For bottom bar spacing
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (quantity > 1) setState(() => quantity--);
                    },
                  ),
                  Text('$quantity', style: theme.textTheme.titleMedium),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() => quantity++);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {},
                child: Text('Add to Cart', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 