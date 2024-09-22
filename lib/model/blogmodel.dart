class Blogmodel {
  late String id;
  late String title;
  late String image;
  late String description;

  Blogmodel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
  });

  Blogmodel.fromJson(Map<String, dynamic> map) {
    id = map['id']?? 0;
    title = map['title'] ?? '';
    image = map['img'] ?? '';
    description = map['description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'img': image,
      'description': description,
    };
  }
}
