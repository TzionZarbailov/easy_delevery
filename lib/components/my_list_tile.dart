// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:easy_delevery/colors/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyListTile extends StatelessWidget {
  final String nameDish;
  final String toppingsDish;
  final String priceDish;
  final String imageDish;
  final void Function()? onTap;

  const MyListTile({
    super.key,
    required this.nameDish,
    required this.toppingsDish,
    required this.priceDish,
    required this.imageDish,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.11,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: LinearGradient(
          colors: [
            myColors.backgroundColor.withOpacity(0.9),
            myColors.buttonColor.withOpacity(0.7),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(
          // Add this line
          color: Colors.black.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  return onTap!();
                },
                backgroundColor: Colors.red,
                icon: Icons.delete,
                label: 'מחק',
                borderRadius: BorderRadius.circular(35),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //* name of the dish
                    Text(
                      nameDish,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.right,
                    ),

                    const SizedBox(height: 5),

                    //* toppings of the dish
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: 250,
                          child: Text(
                            toppingsDish,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    //* price of the dish
                    Expanded(
                      child: Text(
                        '₪ ' + priceDish,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    // * image of the dish
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: imageDish.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(imageDish),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: imageDish.isEmpty
                          ? const Icon(
                              Icons.fastfood,
                              color: Colors.white,
                              size: 50,
                            )
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
