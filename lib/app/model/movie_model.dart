class Movie {
  final String id;
  final String title;
  final String description;
  final String posterUrl;
  final String category;
  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
    required this.category,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      posterUrl: map['poster_url'],
      category: map['category'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'poster_url': posterUrl,
      'category': category,
    };
  }
}
