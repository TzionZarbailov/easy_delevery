import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/dialog_box.dart';
import 'package:flutter/material.dart';

class EditMenuForRestaurant extends StatefulWidget {
  const EditMenuForRestaurant({super.key});

  @override
  State<EditMenuForRestaurant> createState() => _EditMenuForRestaurantState();
}

class _EditMenuForRestaurantState extends State<EditMenuForRestaurant> {
  // adding a dish to the menu
  void addDish() {
    // show a dialog with the dish details
    showDialog(
      context: context,
      builder: (context) {
        return const DialogBox();
      },
    );
  }

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
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 5),
          child: FloatingActionButton(
            onPressed: addDish,
            backgroundColor: myColors.buttonColor,
            splashColor: Colors.yellow,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
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
                'עריכת תפריט מסעדה',
                style: TextStyle(
                  color: myColors.buttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
