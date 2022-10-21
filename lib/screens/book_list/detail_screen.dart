
import 'package:flutter/material.dart';
import 'package:hello_flutter_wirh_intellij/models/book.dart';

class DetailScreen extends StatelessWidget {
  // final String title;
  // final String description;
  // final String image;
  //
  // const DetailScreen({
  //   super.key,
  //   required this.title,
  //   required this.description,
  //   required this.image
  // });
  final Book book;

  const DetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // late final args = ModalRoute.of(context)!.settings.arguments as DetailData;

    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: Column(
        children: [
          Image.network(book.image),
          const Padding(padding: EdgeInsets.all(3)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                    Text(book.subTitle, style: const TextStyle(fontSize: 18, color: Colors.grey),)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                padding: const EdgeInsets.all(10),
                child: const Center(
                  child: Icon(Icons.star, color: Colors.red)
                )
              )
            ],
          ),
          const Padding(padding: EdgeInsets.all(3)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: const [
                  Icon(Icons.call, color: Colors.blue),
                  Text('Contact', style: TextStyle(color: Colors.blue))
                ],
              ),
              Column(
                children: const [
                  Icon(Icons.near_me, color: Colors.blue),
                  Text('Route', style: TextStyle(color: Colors.blue))
                ],
              ),
              Column(
                children: const [
                  Icon(Icons.save, color: Colors.blue),
                  Text('Save', style: TextStyle(color: Colors.blue))
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: const Text(
                'description description description description description '
                'description description description description description '
                'description description description description description '
                'description description description description description '
                'description description description description description '
                'description description description description description '
                'description description description description description '
            ),
          )
        ],
      )
    );
  }
}
