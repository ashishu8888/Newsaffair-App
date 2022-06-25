import 'package:flutter/material.dart';
import 'package:news_affair_app/Helper/data_helper.dart';
import 'package:news_affair_app/Helper/news.dart';
import 'package:news_affair_app/model/article_model.dart';
import 'package:news_affair_app/model/data_model.dart';
import 'package:news_affair_app/widgets/blog_tile.dart';
import 'package:news_affair_app/widgets/catagory_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;
  List<CategorieModel> categories = [];
  List<ArticleModel> articles = [];
  final dataHelper = DataHelper();
  @override
  void initState() {
    super.initState();
    categories = dataHelper.getCategories();
    getNews();
  }

  getNews() async {
    News Newnews = News();
    articles = await Newnews.getNews();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'News',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              'affair',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(
              child: Container(
                child: SpinKitThreeInOut(itemBuilder: (_, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color:
                            index.isEven ? Color(0xFF7a9ee6) : Colors.indigo),
                  );
                }),
              ),
            )
          : Container(
              color: Colors.white30,
              margin: EdgeInsets.all(5),
              // padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // categories...
                  Container(
                    //padding: const EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.white30,
                    height: 60,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: CatagoryTile(
                                  imageUrl: categories[index].imageAssetUrl,
                                  catagoryName:
                                      categories[index].categorieName),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Blogs...

                  Expanded(
                    child: Container(
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
                  ),
                ],
              ),
            ),
    );
  }
}
