import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/menu_item_list.dart';
import 'package:easy_delevery/models/order.dart';
import 'package:easy_delevery/models/restaurant.dart';
import 'package:easy_delevery/screens/consumer_screens/shopping_cart.dart';
import 'package:easy_delevery/services/restaurant_services.dart';
import 'package:flutter/material.dart';

class RestaurantDetails extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetails({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  // Initialize newIndex
  List<Order> orders = [];

  @override
  Widget build(BuildContext context) {
    // * ValueNotifier to keep track of the selected category
    final selectedCategory = ValueNotifier<String>('הכל');

    return Scaffold(
      body: FutureBuilder<Restaurant>(
        future: RestaurantServices().getRestaurantById(widget.restaurantId),
        builder: (context, snapshot) {
          // * If the connection is waiting, show a loading indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: myColors.buttonColor,
              ),
            );
            // * If the connection is done, but there is no data, show a message
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      //* restaurant image from network
                      Image.network(
                        snapshot.data!.restaurantImage!,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),

                      //* back button
                      Positioned(
                        top: 30.0,
                        left: 7.0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back,
                              size: 30, color: Colors.white),
                          onPressed: () {
                            // * Close the bottom sheet
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // underline
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
                //* continer for the restaurant name and address
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFF8E3CA),
                        Color(0xC8F4AE5C),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // restaurant name and address in one text widget
                      Text(
                        "${snapshot.data!.name} | ${snapshot.data!.address}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // restaurant categories with TabBar
                DefaultTabController(
                  // * The number of tabs is equal to the number of categories
                  length: snapshot.data!.categories!.length,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TabBar(
                      onTap: (index) {
                        // * When a category is tapped, set the selectedCategory value
                        selectedCategory.value =
                            snapshot.data!.categories![index].name;
                      },
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      indicatorColor: myColors.buttonColor,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: snapshot.data!.categories!
                          .map(
                            (category) => Tab(
                              text: category.name,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),

                // * get the menu items for the selected category
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: MediaQuery.of(context).size.height / 2,
                  child: ValueListenableBuilder<String>(
                    valueListenable: selectedCategory,
                    builder: (context, value, child) {
                      // * If menuItems is null or empty, return an empty Container
                      if (snapshot.data!.menuItems == null ||
                          snapshot.data!.menuItems!.isEmpty) {
                        return Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'אין פריטים בתפריט',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        );
                      } else {
                        // * If the selected category is 'הכל', show all the menu items
                        if (value == 'הכל') {
                          return MenuItemList(
                            documentId: widget.restaurantId,
                            menuItems: snapshot.data!.menuItems!,
                            category: value,
                            onOrderAdded: (order) {
                              setState(() {
                                orders.add(order);
                              });
                            },
                          );
                        }
                        // * If there are no menu items for the selected category, return a Container with a message
                        else if (!snapshot.data!.menuItems!
                            .any((item) => item.category == value)) {
                          return Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'אין פריטים בקטגוריה הנבחרת',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          );
                        } else {
                          // * If the selected category is a specific category, show the menu items for that category
                          return MenuItemList(
                            documentId: widget.restaurantId,
                            menuItems: snapshot.data!.menuItems!,
                            category: value,
                            onOrderAdded: (order) {
                              setState(() {
                                orders.add(order);
                              });
                            },
                          );
                        }
                      }
                    },
                  ),
                ),
                // Add a button for ending the order
                Container(
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFF8E3CA),
                        Color(0xC8F4AE5C),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.yellow[800],
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: Order.getTotalQuantity(orders) == 0
                        ? null
                        : () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShoppingCart(
                                  orders: orders,
                                  restaurantDocId: widget.restaurantId,
                                ),
                              ),
                            );

                            if (result != orders) {
                              setState(() {
                                orders.contains(result);
                              });
                            }
                          },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'סיום הזמנה',
                          style: TextStyle(
                            color: Order.getTotalQuantity(orders) == 0
                                ? Colors.grey
                                : Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ), // Text for the button
                        Badge(
                          backgroundColor: Colors.white,
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          label: Text(
                            Order.getTotalQuantity(orders).toString(),
                            style: TextStyle(
                              color: Order.getTotalQuantity(orders) == 0
                                  ? Colors.grey
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          child: Icon(
                            Icons.shopping_cart,
                            color: Order.getTotalQuantity(orders) == 0
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ), // Icon for the button
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
