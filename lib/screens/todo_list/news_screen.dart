import 'package:flutter/material.dart';
import 'package:hello_flutter_wirh_intellij/models/news.dart';
import 'package:hello_flutter_wirh_intellij/providers/news_api.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsApi newsApi = NewsApi();
  List<News> news = [];
  bool isLoading = true;

  Future<void> initNews() async {
    news = await newsApi.getNews();
  }

  @override
  void initState() {
    super.initState();
    initNews().then((_) => setState(() {
      isLoading = false;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('뉴스 화면'),),
      body: isLoading
        ? const Center(child: CircularProgressIndicator(),)
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // item 갯수 per 1행
              childAspectRatio: 2 / 3, // item 의 가로 / 세로 비율
              crossAxisSpacing: 20, // 수평 padding
              mainAxisSpacing: 20, // 수직 padding
            ),
          itemCount: news.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    news[index].title,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    news[index].description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              )
            );
          },
        )
    );
  }
}
