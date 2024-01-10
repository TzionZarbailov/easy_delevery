import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/models/restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({
    super.key,
    required this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.9,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            clipBehavior: Clip.hardEdge,
            elevation: 2,
            child: InkWell(
              onTap: onTap,
              splashColor: myColors.buttonColor.withOpacity(0.5),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: restaurant.restaurantImage != null
                          ? DecorationImage(
                              image: restaurant.restaurantImage!.image,
                              fit: BoxFit.cover,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 25,
                          ),
                          width: 375,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                myColors.buttonColor.withOpacity(0.8),
                                Colors.white.withOpacity(0.4),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${restaurant.name} | ${restaurant.city}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List<Restaurant> restaurants = [
  const Restaurant(
    id: '521',
    name: 'פיצה זותא',
    address: 'צבי תדמור 10',
    city: 'חולון',
    phoneNumber: '0527715057',
    workHours: '11:00/00:00',
    isOpen: true,
    restaurantImage: Image(
      image: NetworkImage(
          "https://imageproxy.wolt.com/menu/menu-images/5e31b8bffc976d04113c03ee/e8a24902-3140-11ed-ac42-fece14553f35____________.jpeg"),
    ),
  ),
  const Restaurant(
    id: '522',
    name: 'מוזס שופ',
    address: 'צבי תדמור 5',
    city: 'חולון',
    phoneNumber: '0527715055',
    workHours: '11:00/00:00',
    isOpen: true,
    restaurantImage: Image(
      image: NetworkImage(
          "https://imageproxy.wolt.com/venue/5f4376a5d45c89d466ee15ce/8f182b88-9cbe-11ed-9a53-22d5e8c71181__________whatsapp__2023_01_25______11.16.31.jpg"),
    ),
  ),
  const Restaurant(
    id: '523',
    name: 'גולדה',
    address: 'יריחו 10',
    city: 'חולון',
    phoneNumber: '0527715059',
    workHours: '11:00/00:00',
    isOpen: true,
    restaurantImage: Image(
      image: NetworkImage(
          "https://www.goldamotzkin.co.il/wp-content/uploads/2021/12/15613362700441_b.jpg"),
    ),
  ),
  const Restaurant(
    id: '525',
    name: 'טורטיה בר',
    address: 'צבי תדמור 12',
    city: 'חולון',
    phoneNumber: '0542149401',
    workHours: '11:00/00:00',
    isOpen: true,
    restaurantImage: Image(
      image: NetworkImage(
          "https://imageproxy.wolt.com/venue/5e1c8c3ffb1b66ead9006623/0464628a-5d61-11ea-b091-0a586479e855_yaelitz-19.jpg"),
    ),
  ),
  const Restaurant(
    id: '527',
    name: 'קפה קפה',
    address: 'אלופי צה"ל 19',
    city: 'חולון',
    phoneNumber: '0527715054',
    workHours: '11:00/00:00',
    isOpen: true,
    restaurantImage: Image(
      image: NetworkImage(
          'https://images.rest.co.il/Customers/80349835/224eb6fb7fcd4ab5ae5241332b2d6241.jpg'),
    ),
  ),
];
