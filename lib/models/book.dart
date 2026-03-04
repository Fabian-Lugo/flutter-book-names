
class Book {
  String? id;
  String? name;
  int? votes;

  Book({
    this.id,
    this.name,
    this.votes,
  });

  factory Book.fromMap(Map<String, dynamic> obj) => Book(
    id: obj['id'],
    name: obj['name'],
    votes: obj['votes']
  );
}
