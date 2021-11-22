class Comment {
  late String comment;
  late DateTime created;
  late String userName;

  Comment(String comment, DateTime created, String userName) {
    this.comment = comment;
    this.created = created;
    this.userName = userName;
  }
}
