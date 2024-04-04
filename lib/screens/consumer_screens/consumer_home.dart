import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_delevery/components/restaurant_list.dart';
import 'package:easy_delevery/components/categories.dart';

class ConsumerHome extends StatefulWidget {
  const ConsumerHome({Key? key}) : super(key: key);

  @override
  State<ConsumerHome> createState() => _ConsumerHomeState();
}

final user = FirebaseAuth.instance.currentUser!;

class _ConsumerHomeState extends State<ConsumerHome> {
  //* ValueNotifier to keep track of the selected category
  final ValueNotifier<String> selectedCategory = ValueNotifier('הכל');

  // * TextEditingController for the search bar
  final TextEditingController searchController = TextEditingController();

  String searchText = '';

  @override
  void initState() {
    super.initState();
    // * Clear the search bar when the category changes
    selectedCategory.addListener(() {
      searchController.clear();
    });

    //* Listen to the search bar changes
    searchController.addListener(() {
      setState(() {
        searchText = searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '?אז מה תרצו להזמין',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'חיפוש',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 30,
                      child: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'קטגוריות',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              //* Categories list view
              Categories(
                onTap: (String category) {
                  selectedCategory.value = category;
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder<String>(
                    valueListenable: selectedCategory,
                    builder: (context, value, child) {
                      if (value == 'הכל') {
                        return const Text(
                          'כל המסעדות',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        );
                      } else {
                        return Text(
                          'מסעדות $value',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),

              //* list view Restaurants
              ValueListenableBuilder<String>(
                valueListenable: selectedCategory,
                builder: (context, value, child) {
                  return RestaurantList(
                    restaurantType: searchController.text.isNotEmpty
                        ? 'הכל'
                        : value.toString(),
                    searchText: searchController.text.isNotEmpty
                        ? searchController.text
                        : null,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
