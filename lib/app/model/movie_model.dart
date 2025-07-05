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

  factory Movie.fromMap(Map<String, dynamic> map, String docId) {
    return Movie(
      id: docId,
      title: map['title'],
      description: map['description'],
      posterUrl: map['poster_url'],
      category: map['category'],
    );
  }
}
