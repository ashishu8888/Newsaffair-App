import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_affair_app/Helper/category_news.dart';
import 'package:news_affair_app/model/article_model.dart';
import 'package:news_affair_app/widgets/blog_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CatagoryView extends StatefulWidget {
  final String category;

  const CatagoryView({Key? key, required this.category}) : super(key: key);
  @override
  State<CatagoryView> createState() => _CatagoryViewState();
}

class _CatagoryViewState extends State<CatagoryView> {
  bool _isLoading = true;
  List<ArticleModel> articles = [];

  @override
  void initState() {
    super.initState();

    getNews();
  }

  getNews() async {
    CategoryNews Newnews = CategoryNews();
    articles = await Newnews.getNews(widget.category);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.category}',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black12,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(
              child: Container(
                child: SpinKitThreeInOut(itemBuilder: (_, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: index.isEven ? Color(0xFF7a9ee6) : Colors.blue),
                  );
                }),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 7),
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                  child: BlogTile(
                                url: articles[index].url,
                                imageUrl: articles[index].urlToimage,
                                title: articles[index].title,
                                desc: articles[index].description,
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
