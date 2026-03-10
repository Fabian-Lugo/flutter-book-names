class Book {
  final String? id;
  final String? name;
  final int? votes;

  const Book({
    this.id,
    this.name,
    this.votes,
  });

  factory Book.fromMap(Map<String, dynamic> obj) => Book(
    id: obj['id'],
    name: obj['name'],
    votes: obj['votes'],
  );
}