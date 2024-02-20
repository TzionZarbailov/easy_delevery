// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/screens/business_screens/restaurant_home_screen.dart';
import 'package:easy_delevery/services/restaurant_services.dart';

import 'package:flutter/material.dart';

import '../../models/category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _categoryController = TextEditingController();

  CollectionReference restaurant =
      FirebaseFirestore.instance.collection('restaurants');

  List<String> doc = [];

  late int counter = 1;

  get restaurantId => RestaurantServices().getDocId(doc);

  String getRestaurant() {
    for (var i = 0; i < doc.length; i++) {
      if (doc[i].isNotEmpty) {
        return doc[i];
      }
    }
    return '';
  }

  // get function to update category in restaurant collection
  Future _updateCategory() async {
    DocumentReference docRef = restaurant.doc(getRestaurant());
    DocumentSnapshot docSnapshot = await docRef.get();

    Category newCategory = Category(
      id: counter.toString(), // replace with the correct id
      name: _categoryController.text,
    );

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      if (data['categories'] == null) {
        await docRef.update({
          'categories': [newCategory.toMap()],
        });
      } else {
        List categories = data['categories'];
        categories.add(newCategory.toMap());
        await docRef.update({
          'categories': categories,
        });
      }
    } else {
      await docRef.set({
        'categories': [newCategory.toMap()],
      });
    }
    counter = counter + 1;
    _categoryController.clear();
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  // controller for category text field

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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'עריכת קטגוריות',
                style: TextStyle(
                  color: myColors.buttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              //* Text add category
              const Text(
                'הוספת קטגוריה חדשה',
                style: TextStyle(
                    color: myColors.buttonColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              //* add category text field
              TextFormField(
                controller: _categoryController,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.end,
                decoration: const InputDecoration(
                  hintText: 'שם הקטגוריה',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    borderSide: BorderSide(
                      color: myColors.buttonColor,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    borderSide: BorderSide(
                      color: Colors.yellow,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              //* add myButton
              MyButton(
                text: 'הוספה',
                fontSize: 17,
                horizontal: MediaQuery.of(context).size.width / 3.5,
                vertical: 5,
                onTap: _updateCategory,
              ),

              const SizedBox(height: 35),

              //* delete category
              const Text(
                'מחיקת קטגוריה',
                style: TextStyle(
                  color: myColors.buttonColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              //* all categories
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    const Text(
                      'שם הקטגוריה',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
