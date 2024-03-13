class MenuItem {
  final String name;
  final List<String> description;
  final double price;
  final String category;
  final String image;

  const MenuItem({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
  });

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
