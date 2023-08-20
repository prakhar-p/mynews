class Article{

  String title;
  String author;
  String description;
  String urlToImage;
  DateTime publshedAt;
  String content;
  String articleUrl;

  Article({required this.title,required this.description,required this.author,required this.content,required this.publshedAt,
    required this.urlToImage, required this.articleUrl});

  factory Article.fromMap(Map<String,dynamic> parsedJson){
    return Article(
      title: parsedJson["title"],
      description: parsedJson["description"],
      author: parsedJson["author"],
      content: parsedJson["content"],
      publshedAt: DateTime.parse(parsedJson["publshedAt"]),
      urlToImage: parsedJson["urlToImage"], articleUrl: parsedJson["articleUrl"]
    );
  }

}