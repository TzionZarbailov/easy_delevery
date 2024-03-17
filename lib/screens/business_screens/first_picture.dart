// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/image_picker.dart';
import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/components/my_drop_dowm_button.dart';
import 'package:easy_delevery/services/auth_services.dart';
import 'package:easy_delevery/services/restaurant_services.dart';
import 'package:flutter/material.dart';

class FirstPicture extends StatefulWidget {
  const FirstPicture({super.key});

  @override
  State<FirstPicture> createState() => _FirstPictureState();
}

//* category value from the drop button
String categoryValue = '';

//* image url from the image picker
String imageUrl = '';

//* check if the fields are not empty
Future isExsist(BuildContext context) async {
  try {
    if (imageUrl.isNotEmpty && categoryValue.isNotEmpty) {
      await RestaurantServices().updateRestaurantData(
        AuthServices().getUid,
        {
          'restaurantImage': imageUrl,
          'restaurantType': categoryValue,
        },
      );

      imageUrl = '';
      categoryValue = '';

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '! התמונה וסוג המסעדה נשמרו בהצלחה',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else if (imageUrl.isNotEmpty) {
      await RestaurantServices().updateRestaurantData(
        AuthServices().getUid,
        {'restaurantImage': imageUrl},
      );
      imageUrl = '';

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '! התמונה נשמרה בהצלחה',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else if (categoryValue.isNotEmpty) {
      await RestaurantServices().updateRestaurantData(
        AuthServices().getUid,
        {'restaurantType': categoryValue},
      );
      categoryValue = '';

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '! סוג המסעדה נשמר בהצלחה',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'יש למלא לפחות אחד מהשדות',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (error) {
    print('Error: $error');
  }
}

@override
void dispose() {
  isExsist;
}

class _FirstPictureState extends State<FirstPicture> {
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
                'עריכת תמונה ראשית',
                style: TextStyle(
                  color: myColors.buttonColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 8),
                child: Column(
                  children: [
                    MyImagePicker(
                      onImageSelected: (image) {
                        setState(() {
                          imageUrl = image;
                        });
                      },
                    ),

                    //* Text
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '? איזה סוג מסעדה אתה',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    //* drop button
                    MyDropdownButton(
                      categories: const [
                        '...',
                        'קינוח',
                        'אסייתי',
                        'איטלקי',
                        'המבורגר'
                      ],
                      onValueChanged: (value) {
                        setState(() {
                          categoryValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              MyButton(
                text: 'סיום',
                horizontal: 35,
                vertical: 5,
                onTap: () => isExsist(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
