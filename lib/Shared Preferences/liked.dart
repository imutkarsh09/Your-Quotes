class Liked {
  String quote;
  String author;

  Liked({
    this.quote,
    this.author,
  });

  Liked.fromMap(Map map)
      : this.quote = map["quote"],
        this.author = map["author"];

  Map toMap() {
    return {
      'quote': this.quote,
      'author': this.author,
    };
  }
}
