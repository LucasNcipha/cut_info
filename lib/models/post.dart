class Post{
  String? title;
  String? content;
  bool hasImage = false;

  Post(String title, String content,bool hasImage) {
    this.title = title;
    this.content = content;
    this.hasImage = hasImage;
  }
}