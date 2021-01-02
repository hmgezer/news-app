import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsApp/screens/home/news_detail.dart';
import 'package:newsApp/services/news_service.dart';
import 'package:provider/provider.dart';
import '../../model/categories_model.dart';
import 'package:newsApp/utils.dart';
import '../../reusable/custom_cards.dart';

class HomePage extends StatefulWidget {
  final Map<String, List> newsData;

  const HomePage({Key key, this.newsData}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;
  int currentIndex = 0;
  bool loading = true;
  Map<String, List> _newsData = Map<String, List>();
  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(_smoothScrollToTop);

    super.initState();
  }

  _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(microseconds: 300),
      curve: Curves.ease,
    );
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      loading = Provider.of<NewsService>(context).loading;
      Provider.of<NewsService>(context).getNewsData('ses');
    });
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .1,
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Top News Updates",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Times",
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(left: 25),
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                        labelPadding: EdgeInsets.only(right: 15),
                        indicatorSize: TabBarIndicatorSize.label,
                        controller: _tabController,
                        isScrollable: true,
                        indicator: UnderlineTabIndicator(),
                        labelColor: Colors.black,
                        labelStyle: TextStyle(
                            fontFamily: "Avenir",
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                        unselectedLabelColor: Colors.black45,
                        unselectedLabelStyle: TextStyle(
                            fontFamily: "Avenir",
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        tabs: List.generate(categories.length,
                            (index) => Text(categories[index].name))),
                  ),
                ),
              ];
            },
            body: Container(
              child: TabBarView(
                  controller: _tabController,
                  children: List.generate(
                    categories.length,
                    (index) {
                      var key = categories[index]
                          .imageUrl
                          .toString()
                          .split("/")[3]
                          .split(".")[0]
                          .replaceAll("_", "-");
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        itemBuilder: (context, i) {
                          String time = _newsData[key][i]['pubDate']['__cdata'];
                          DateTime timeIST = DateTime.parse(time.split(" ")[3] +
                              "-" +
                              getMonthNumberFromName(
                                  month: time.split(" ")[2]) +
                              "-" +
                              time.split(" ")[1] +
                              " " +
                              time.split(" ")[4]);
                          timeIST = timeIST
                              .add(Duration(hours: 5))
                              .add(Duration(minutes: 30));
                          return HomePageCard(
                            title: _newsData[key][i]['title']['__cdata'],
                            subtitle: _newsData[key][i]['description']
                                ['__cdata'],
                            time: timeIST.day.toString() +
                                " " +
                                getMonthNumberInWords(month: timeIST.month) +
                                " " +
                                timeIST
                                    .toString()
                                    .split(" ")[1]
                                    .substring(0, 5),
                            imageUrl: _newsData[key][i]['media\$content']
                                ['url'],
                          );
                        },
                        itemCount: _newsData[key]?.length ?? 0,
                      );
                    },
                  )),
            ),
          ),
        ),
        loading
            ? CircularProgressIndicator()
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                          Provider.of<NewsService>(context, listen: false)
                              .newsUs
                              .length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    News news = Provider.of<NewsService>(
                                            context,
                                            listen: false)
                                        .newsUs[index];
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewsDetailScreen(news)));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        .25,
                                    width: MediaQuery.of(context).size.width,
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          Provider.of<NewsService>(context,
                                                  listen: false)
                                              .newsUs[index]
                                              .urlToImage,
                                          fit: BoxFit.fitWidth,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        Positioned(
                                            bottom: 0,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .08,
                                              color: Colors.black87,
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    Provider.of<NewsService>(
                                                            context,
                                                            listen: false)
                                                        .newsUs[index]
                                                        .title,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
