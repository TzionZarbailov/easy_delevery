import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/screens/business_screens/category_screen.dart';
import 'package:easy_delevery/screens/business_screens/edit_menu_for_restaurant.dart';
import 'package:easy_delevery/screens/business_screens/first_picture.dart';
import 'package:flutter/material.dart';

class EditMenu extends StatelessWidget {
  const EditMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          stops: [0.7, 0.8],
          colors: [
            myColors.backgroundColor,
            myColors.buttonColor,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: myColors.buttonColor,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: myColors.buttonColor,
              height: 2,
            ),
          ),
          backgroundColor: Colors.black.withOpacity(0.9),
          actions: const [
            Text(
              'עריכת תפריט',
              style: TextStyle(
                color: myColors.buttonColor,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.person),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
          child: Column(
            children: [
              //* edit first picture for restaurant
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FirstPicture(),
                        ),
                      );
                    },
                    child: const Text(
                      'עריכת תמונה ראשית למסעדה',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              //* edit category for restaurant
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CategoryScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'עריכת קטגוריות למסעדה',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              //* edit menu for restaurant
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditMenuForRestaurant(),
                        ),
                      );
                    },
                    child: const Text(
                      'עריכת תפריט מסעדה',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              MyButton(
                text: 'שמירה',
                horizontal: 45,
                vertical: double.minPositive,
                fontSize: 20,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
