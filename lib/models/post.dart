class Posts {
  late String title;
  late String content;
  late bool hasImage;
  late DateTime created;
  late String objectId;
  late String course;

  Posts(String title, String content, bool hasImage, DateTime created,
      String objectId, String course) {
    this.title = title;
    this.content = content;
    this.hasImage = hasImage;
    this.created = created;
    this.objectId = objectId;
    this.course = course;
  }
}
