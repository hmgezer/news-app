class CategoryModel {
  final name, imageUrl;

  CategoryModel({this.name, this.imageUrl});
}

List<CategoryModel> categories = [
  CategoryModel(
      name: "Top stories", imageUrl: "assets/images/categories/topnews.jpg"),
  CategoryModel(
      name: "World", imageUrl: "assets/images/categories/topnews.jpg"),
  CategoryModel(
      name: "Business", imageUrl: "assets/images/categories/topnews.jpg"),
  CategoryModel(
      name: "Sports", imageUrl: "assets/images/categories/topnews.jpg"),
  CategoryModel(name: "Tech", imageUrl: "assets/images/categories/topnews.jpg"),
  CategoryModel(
      name: "Education", imageUrl: "assets/images/categories/topnews.jpg"),
  CategoryModel(
      name: "Music", imageUrl: "assets/images/categories/topnews.jpg"),
  CategoryModel(
      name: "Lifestyle", imageUrl: "assets/images/categories/topnews.jpg"),
  CategoryModel(
      name: "Fashion", imageUrl: "assets/images/categories/topnews.jpg"),
  CategoryModel(
      name: "Health and Fitness",
      imageUrl: "assets/images/categories/topnews.jpg"),
  CategoryModel(
      name: "Art and Culture",
      imageUrl: "assets/images/categories/topnews.jpg"),
  CategoryModel(
      name: "Travel", imageUrl: "assets/images/categories/topnews.jpg"),
];

class News {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  String publishedAt;

  News(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.content,
      this.publishedAt});
}
