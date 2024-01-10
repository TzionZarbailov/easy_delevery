import 'package:easy_delevery/colors/my_colors.dart';
import 'package:flutter/material.dart';

enum Category {
  all,
  burger,
  asian,
  italian,
  dessert,
}

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Category> categories = [
      Category.dessert,
      Category.asian,
      Category.italian,
      Category.burger,
      Category.all,
    ];

    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categories[index];
          String categoryName;
          Icon categoryIcon;

          switch (category) {
            case Category.all:
              categoryName = 'הכל';
              categoryIcon = const Icon(Icons.category);
              break;
            case Category.italian:
              categoryName = 'איטלקי';
              categoryIcon = const Icon(Icons.local_pizza);
              break;
            case Category.dessert:
              categoryName = 'קינוחים';
              categoryIcon = const Icon(Icons.cake);
              break;
            case Category.asian:
              categoryName = 'אסייתי';
              categoryIcon = const Icon(Icons.restaurant);
              break;
            case Category.burger:
              categoryName = 'המבורגר';
              categoryIcon = const Icon(Icons.fastfood);
              break;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: myColors.buttonColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        categoryIcon.icon,
                        color: Colors.grey[700],
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        categoryName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
