class Posts {
  late String title;
  late String content;
  late bool hasImage;
  late DateTime created;

  Posts(String title, String content, bool hasImage, DateTime created) {
    this.title = title;
    this.content = content;
    this.hasImage = hasImage;
    this.created = created;
  }
}
