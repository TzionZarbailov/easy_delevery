// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/services/auth_services.dart';

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

  int counter = 0;

  // get function to update category in restaurant collection
  Future<void> _updateCategory() async {
    try {
      DocumentReference docRef = restaurant.doc(AuthServices.getUid);
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
    } catch (e) {
      print('Error updating category: $e');
    }
  }

  // delete category function for restaurant service

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //* text for no categories available
    Widget textWidget = const Text(
      'אין קטגוריות זמינות',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );

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
        body: SingleChildScrollView(
          child: Padding(
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
                  onTap: () {
                    if (_categoryController.text.isNotEmpty &&
                        _categoryController.text.trim() != '') {
                      _updateCategory();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            textAlign: TextAlign.right,
                            'אנא הכנס שם קטגוריה',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
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
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: RestaurantServices().getCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? CircularProgressIndicator(
                                  color: Colors.orange[700],
                                )
                              : textWidget,
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.docs.isNotEmpty) {
                        DocumentSnapshot restaurantDoc = snapshot
                            .data!.docChanges
                            .firstWhere((document) =>
                                document.doc.id == AuthServices.getUid)
                            .doc;

                        Map<String, dynamic> data =
                            restaurantDoc.data() as Map<String, dynamic>;

                        if (data['categories'] is List) {
                          List<Map<String, dynamic>> categoriesList =
                              List<Map<String, dynamic>>.from(
                                  data['categories']);

                          if (categoriesList.isEmpty) {
                            return Center(
                              child: textWidget,
                            );
                          } else {
                            return ListView.builder(
                              itemCount: categoriesList.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> categoryMap =
                                    categoriesList[index];
                                String categoryName = categoryMap[
                                    'name']; // replace 'name' with the actual key
                                return ListTile(
                                  title: Text(
                                    categoryName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  leading: IconButton(
                                    onPressed: () {
                                      RestaurantServices().deleteCategory(
                                          restaurantDoc.id,
                                          restaurantDoc['categories'][index]);
                                    }, // replace with the actual function
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        } else {
                          return Center(
                            child: textWidget,
                          );
                        }
                      } else {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange[700],
                            ),
                          );
                        } else {
                          return Center(
                            child: textWidget,
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
