import 'package:easy_delevery/colors/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Category {
  all,
  burger,
  asian,
  italian,
  mexican,
  dessert,
}

class Categories extends StatelessWidget {
  // finction onTap to the categories in firestore
  final ValueChanged<String> onTap;

  const Categories({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<Category> categories = [
      Category.all,
      Category.burger,
      Category.italian,
      Category.asian,
      Category.mexican,
      Category.dessert,
    ];

    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        reverse: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final category = categories[index];
          String categoryName;
          Icon categoryIcon;

          switch (category) {
            case Category.all:
              categoryName = 'הכל';
              categoryIcon = const Icon(Icons.category);

            case Category.italian:
              categoryName = 'איטלקי';
              categoryIcon = const Icon(Icons.local_pizza);

            case Category.dessert:
              categoryName = 'קינוחים';
              categoryIcon = const Icon(Icons.cake);

            case Category.asian:
              categoryName = 'אסייתי';
              categoryIcon = const Icon(Icons.restaurant);

            case Category.burger:
              categoryName = 'המבורגר';
              categoryIcon = const Icon(Icons.fastfood);

            case Category.mexican:
              categoryName = 'מקסיקני';
              categoryIcon = const Icon(FontAwesomeIcons.pepperHot);
            default:
              categoryName = 'הכל';
              categoryIcon = const Icon(Icons.category);
          }

          return GestureDetector(
            onTap: () => onTap(categoryName),
            
            child: Padding(
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
            ),
          );
        },
      ),
    );
  }
}
