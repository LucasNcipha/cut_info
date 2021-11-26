class Comment {
  late String comment;
  late DateTime created;
  late String userName;
  late String postID;

  Comment(String comment, DateTime created, String userName, String postID) {
    this.comment = comment;
    this.created = created;
    this.userName = userName;
    this.postID = postID;
  }
}
