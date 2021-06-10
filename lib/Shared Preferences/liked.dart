class Liked {
  String id;
  String quote;
  String author;

  Liked({
    this.id,
    this.quote,
    this.author,
  });

  Liked.fromMap(Map map)
      : this.id = map["id"],
        this.quote = map["quote"],
        this.author = map["author"];

  Map toMap() {
    return {
      'id': this.id,
      'quote': this.quote,
      'author': this.author,
    };
  }
}
