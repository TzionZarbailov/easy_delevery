import 'package:easy_delevery/models/menu_item.dart';
import 'package:easy_delevery/models/order.dart';

import 'package:easy_delevery/services/auth_services.dart';
import 'package:flutter/material.dart';

class MenuItemList extends StatefulWidget {
  final String documentId;
  final List<MenuItem> menuItems;
  final String category;
  final Function(Order)? onOrderAdded;

  const MenuItemList({
    super.key,
    required this.documentId,
    required this.menuItems,
    required this.category,
    this.onOrderAdded,
  });

  @override
  State<MenuItemList> createState() => _MenuItemListState();
}

class _MenuItemListState extends State<MenuItemList> {
  bool isToppingSelected = false;

  List<Order> orders = [];

  void selectMenuItem(BuildContext context, int index) {
    showModalBottomSheet(
      backgroundColor: Colors.grey[300],
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        int quantity = 1;
        Map<String, bool> toppingSelected = {};
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4 - 50,
                        ),
                        Positioned(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                            child: Image.network(
                              widget.menuItems[index].image,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10, // Adjust this value to position the button
                          top: 10, // Adjust this value to position the button
                          child: GestureDetector(
                            child: Container(
                              height: MediaQuery.of(context).size.height / 23,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFF8E3CA),
                                    Color(0xC8F4AE5C),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.yellow[700],
                                  shadowColor: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 130,
                          right: 130,
                          bottom: 7,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 15,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFF8E3CA),
                                  Color(0xC8F4AE5C),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    iconTheme: const IconThemeData(
                                      opacity:
                                          1.0, // Full opacity can give the illusion of a bolder icon
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.remove),
                                    iconSize: 20,
                                    onPressed: () {
                                      if (quantity > 1) {
                                        setState(() {
                                          quantity--;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    iconTheme: const IconThemeData(
                                      opacity:
                                          1, // Full opacity can give the illusion of a bolder icon
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.add),
                                    iconSize: 20,
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.menuItems[index].name,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ש"ח ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          widget.menuItems[index].price.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // get the description of the menu item from the menuItems list
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.menuItems[index].description.join(
                              ' , '), // join the list elements with a space
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    ...widget.menuItems[index].description.map((topping) {
                      // Initialize the selected state of the topping if it hasn't been initialized yet
                      if (toppingSelected[topping] == null) {
                        toppingSelected[topping] =
                            false; // initially all toppings are included
                      }

                      return widget.menuItems[index].category != 'שתיה' &&
                              widget.menuItems[index].category != 'בשתיה' &&
                              widget.menuItems[index].category != 'שתייה'
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(' בלי $topping'),
                                  Checkbox(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    fillColor: MaterialStateProperty.all(
                                      const Color(0xFFF4C58E),
                                    ),
                                    value: toppingSelected[topping],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        toppingSelected[topping] = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height / 4.5,
                            );
                    }).toList(),

                    //* add menu item to cart

                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      height: MediaQuery.of(context).size.height / 17,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFF8E3CA),
                            Color(0xC8F4AE5C),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.yellow[700],
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () async {
                          Order order = Order(
                            consumerId: AuthServices.getEmail,
                            busniessOwnersId: widget.documentId,
                            items: widget.menuItems,
                            totalAmount: quantity,
                            totalPrice:
                                widget.menuItems[index].price * quantity,
                            comments: toppingSelected.keys
                                .where(
                                  (topping) => toppingSelected[topping] == true,
                                )
                                .toList(),
                            orderStatus: 'pending',
                            orderTime: DateTime.now(),
                          );

                          setState(() {
                            orders.add(order);
                          });

                          if (widget.onOrderAdded != null) {
                            widget.onOrderAdded!(order);
                          }

                          Navigator.of(context).pop(order);
                        },
                        child: const Text(
                          'הוספה להזמנה',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.menuItems.length,
        itemBuilder: (context, index) {
          if (widget.menuItems[index].category == widget.category ||
              widget.category == 'הכל') {
            return InkWell(
              onTap: () {
                selectMenuItem(context, index);
              },
              child: Card(
                color: Colors.grey[100],
                elevation: 5,
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(widget.menuItems[index].image),
                  ),
                  title: Text(
                    widget.menuItems[index].name,
                    textDirection: TextDirection.rtl,
                  ),
                  subtitle: Text(
                    '${widget.menuItems[index].price.toString()} ש"ח',
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
