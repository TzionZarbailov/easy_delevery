class MenuItem {
  final String name;
  final List<String> description;
  final double price;
  final String category;
  final String image;
  late int quantity;

  MenuItem({
    required this.name,
    required this.description,
    this.quantity = 1,
    this.price = 0.0,
    this.category = 'הכל',
    this.image = '',
  });

  // get quantity of the order List
  static int getTotalQuantity(List<MenuItem> items) {
    int totalQuantity = 0;
    for (MenuItem item in items) {
      totalQuantity += item.quantity;
    }
    return totalQuantity;
  }

  // map the data from the database to the MenuItem object
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'image': image,
    };
  }

  // map the data from the MenuItem object to the database
  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      name: map['name'],
      description: List<String>.from(map['description']), // Change this line
      price: (map['price'] as num).toDouble(),
      category: map['category'],
      image: map['image'],
    );
  }
}
