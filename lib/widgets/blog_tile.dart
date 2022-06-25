import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_affair_app/views/article_view.dart';

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  const BlogTile(
      {Key? key,
      required this.url,
      required this.imageUrl,
      required this.title,
      required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(url: url)));
      },
      child: Card(
        color: Colors.white70,
        //shape: ShapeBorder(),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.grey, width: 2, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        child: Container(
          //decoration: BoxDecoration(borderRadius: ),
          //margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(8),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  desc,
                  style: const TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
