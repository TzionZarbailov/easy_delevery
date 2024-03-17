import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/services/auth_services.dart';
import 'package:easy_delevery/services/restaurant_services.dart';
import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  final ValueChanged<String> onValueChanged;
  final List<String>? categories;

  const MyDropdownButton({
    required this.onValueChanged,
    super.key,
    this.categories,
  });

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String dropdownValue = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categories != null && widget.categories!.isNotEmpty) {
      dropdownValue =
          dropdownValue.isEmpty ? widget.categories!.first : dropdownValue;
      return DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(
          Icons.arrow_downward,
          color: Colors.white,
        ),
        iconSize: 24,
        elevation: 16,
        underline: Container(
          height: 2,
          color: myColors.buttonColor,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            widget.onValueChanged(dropdownValue);
          });
        },
        items: widget.categories!.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: myColors.buttonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    } else {
      return StreamBuilder<QuerySnapshot>(
        stream: RestaurantServices().getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            DocumentSnapshot restaurantDoc = snapshot.data!.docChanges
                .firstWhere(
                    (document) => document.doc.id == AuthServices().getUid)
                .doc;

            if (restaurantDoc.exists) {
              List<String> data = List<Map<String, dynamic>>.from(
                      restaurantDoc['categories'] as List<dynamic>)
                  .map((category) => category['name'] as String)
                  .toList();

              if (data.isNotEmpty) {
                dropdownValue =
                    dropdownValue.isEmpty ? data.first : dropdownValue;
                return DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: myColors.buttonColor,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      widget.onValueChanged(dropdownValue);
                    });
                  },
                  items: data.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            value,
                            style: const TextStyle(
                              color: myColors.buttonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }
            }
          }
          // Return a fallback widget in case there's no data or no matching document

          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(myColors.buttonColor),
            ),
          );
        },
      );
    }

    // return DropdownButton<String>(
    //   value: dropdownValue,
    //   icon: const Icon(
    //     Icons.arrow_downward,
    //     color: Colors.white,
    //   ),
    //   iconSize: 24,
    //   elevation: 16,
    //   underline: Container(
    //     height: 2,
    //     color: myColors.buttonColor,
    //   ),
    //   onChanged: (String? newValue) {
    //     setState(() {
    //       dropdownValue = newValue!;
    //     });
    //   },
    //   items: widget.categories.map<DropdownMenuItem<String>>((String value) {
    //     return DropdownMenuItem<String>(
    //       value: value,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [
    //           Text(
    //             value,
    //             style: const TextStyle(
    //               color: myColors.buttonColor,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   }).toList(),
    // );
  }
}
