import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/models/restaurant.dart';
import 'package:easy_delevery/services/restaurant_services.dart';
import 'package:flutter/material.dart';

class RestaurantDetails extends StatelessWidget {
  final String restaurantId;

  const RestaurantDetails({
    super.key,
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Restaurant>(
        future: RestaurantServices().getRestaurantById(restaurantId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
                      Image.network(
                        snapshot.data!.restaurantImage!,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Positioned(
                        top: 30.0,
                        left: 7.0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back,
                              size: 30, color: Colors.white),
                          onPressed: () {
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
                  color: myColors.buttonColor,
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
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),

                // restaurant categories with TabBar
                DefaultTabController(
                  length: snapshot.data!.categories!.length,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TabBar(
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      indicatorColor: Colors.orange,
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
              ],
            );
          }
        },
      ),
    );
  }
}
