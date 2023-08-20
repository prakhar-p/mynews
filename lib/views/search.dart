import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:n_ews/models/article.dart';

import '../helper/widgets.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Article> search = [];
  late String searchnews;
  bool _loading = false;
  TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "My",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                        fontFamily: 'Overpass'),
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey.withOpacity(0.5),
                          fontFamily: 'Overpass'),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () async {
                    if (textEditingController.text.isNotEmpty) {
                      setState(() {
                        _loading = true;
                      });
                      search = [];
                      String url =
                          "https://newsapi.org/v2/everything?q=${textEditingController}&from=2023-08-19&sortBy=popularity&apiKey={API KEY}";
                      var response = await http.get(url);
                      Map<String, dynamic> jsonData = jsonDecode(response.body);
                      jsonData["hits"].forEach((element) {
                        Article article = new Article(
                            title: "title",
                            description: "description",
                            author: "author",
                            content: "content",
                            publshedAt: DateTime.parse("publshedAt"),
                            urlToImage: "urlToImage",
                            articleUrl: "articleUrl");
                        article = Article.fromMap(element['article']);
                        search.add(article);
                      });
                      setState(() {
                        _loading = false;
                      });
                      print("doing it");
                    } else {
                      print("not doing it");
                    }
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xffA2834D),
                                const Color(0xffBC9A5F)
                              ],
                              begin: FractionalOffset.topRight,
                              end: FractionalOffset.bottomLeft)),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.search, size: 18, color: Colors.white),
                        ],
                      )),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(top: 16),
              height:400,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: search.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return NewsTile(
                      imgUrl: search[index].urlToImage ?? "",
                      title: search[index].title ?? "",
                      desc: search[index].description ?? "",
                      content: search[index].content ?? "",
                      posturl: search[index].articleUrl ?? "",
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

