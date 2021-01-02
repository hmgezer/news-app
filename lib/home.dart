import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:newsApp/backend/rss_to_json.dart';
import 'package:newsApp/screens/home/homepage.dart';
import 'package:dio/dio.dart';
import 'package:newsApp/services/news_service.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  // Map<String, List> newsData = Map<String, List>();
  bool isLoading = false;
  // getData() async {
  //   Future.wait([
  //     rssToJson('topnews'),
  //     rssToJson('business'),
  //     rssToJson('world'),
  //     rssToJson('sports'),
  //     rssToJson('tech-features'),
  //     rssToJson('education'),
  //     rssToJson('fashion'),
  //     rssToJson('lifestyle'),
  //     rssToJson('health-fitness'),
  //     rssToJson('art-culture'),
  //   ]).then((value) {
  //     newsData['topnews'] = value[0];
  //     newsData['business'] = value[1];
  //     newsData['world'] = value[2];
  //     newsData['sports'] = value[3];
  //     newsData['tech-features'] = value[4];
  //     newsData['education'] = value[5];
  //     newsData['fashion'] = value[6];
  //     newsData['lifestyle'] = value[7];
  //     newsData['health-fitness'] = value[8];
  //     newsData['art-culture'] = value[9];

  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsService(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(
                height: 30.0,
              ),
              DrawerHeader(
                  child: Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/images/news_logo.png"),
              )),
              SizedBox(
                height: 20,
              ),
              Text(
                'Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 45),
              Text(
                'Settings',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 45),
              Text(
                'About',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 45),
              Text(
                'Log Out',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 45),
              Material(
                borderRadius: BorderRadius.circular(500),
                child: InkWell(
                  borderRadius: BorderRadius.circular(500),
                  splashColor: Colors.blueGrey,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.indigo[200],
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.indigo[200],
                  child: Center(
                      child: Text(
                    'v1.0.0',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )),
                ),
              ))
            ],
          ),
        ),
        body: <Widget>[
          HomePage(),
          Container(color: Colors.deepPurple[100]),
          Container(color: Colors.indigo[100]),
          Container(color: Colors.green[100]),
        ][currentIndex],
        bottomNavigationBar: BubbleBottomBar(
          opacity: .2,
          currentIndex: currentIndex,
          onTap: changePage,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          elevation: 8,
          fabLocation: BubbleBottomBarFabLocation.end, //new
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
                title: Text("Home")),
            BubbleBottomBarItem(
                backgroundColor: Colors.deepPurple,
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.search,
                  color: Colors.deepPurple,
                ),
                title: Text("Search")),
            BubbleBottomBarItem(
                backgroundColor: Colors.indigo,
                icon: Icon(
                  Icons.bookmark_outline_rounded,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.bookmark_rounded,
                  color: Colors.indigo,
                ),
                title: Text("Favorites")),
            BubbleBottomBarItem(
                backgroundColor: Colors.green,
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.account_circle_rounded,
                  color: Colors.green,
                ),
                title: Text("Profile"))
          ],
        ),
      ),
    );
  }
}
