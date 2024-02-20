class Category {
  final String id; //*This is the id of the category
  final String name; //*This is the name of the category

  const Category({
    required this.id,
    required this.name,
  });

  // map the data from the database to the Category object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // map the data from the Category object to the database
  Category.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'];
}
