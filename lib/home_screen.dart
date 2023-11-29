import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_flix_app/searchList.dart';
import '../helper/style.dart';
import 'controller/home_controller.dart';
import 'helper/const.dart';
import 'movie_deatails.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  final homeController = Get.find<home_controller>();
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    homeController.now_playing();
    homeController.top_rated_api();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.index = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.yellow.shade50,
      appBar:AppBar(
        backgroundColor: Colors.yellow.shade50,
        elevation: 1,
        toolbarHeight: 50,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchList()),
                    );
                  },
                  cursorColor: Colors.black,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                    fillColor: Colors.white,
                    hintText: "search...",
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),],
      ),




      body: TabBarView(
        controller: _tabController,
        children: [
         ///Now Playing
          Container(
            height: double.infinity,
            child: RefreshIndicator(
              onRefresh: () async {
                await homeController.now_playing();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Obx(() {
                      return homeController.Now_playing.isEmpty
                          ? Container(child: Center(child: Text('No Data'),))
                          : ListView.builder(
                        itemCount: homeController.Now_playing.length,
                        itemBuilder: (context, index) {
                          final movieData = homeController.Now_playing[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => movie_details_screen(movie_Data: movieData),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey)),
                              ),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: "$imageUrl2${movieData['backdrop_path']}",
                                    width: 120,
                                    height: 130,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return Image.asset(
                                        'assets/film.png',
                                        width: 120,
                                        height: 80,
                                      );
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movieData['original_title'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          movieData['overview'],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
          ///Top Rated
          Container(
            height: double.infinity,
            child: RefreshIndicator(
              onRefresh: () async {
                await homeController.top_rated_api();
              },

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Expanded(
                    child: Obx(() {
                      return homeController.Top_Rated.isEmpty
                          ? Container(child: Center(child: Text('No Data'),))
                          : ListView.builder(
                        itemCount: homeController.Top_Rated.length,
                        itemBuilder: (context, index) {
                          final TopRated = homeController.Top_Rated[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => movie_details_screen(movie_Data:TopRated),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey)),
                              ),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: "$imageUrl2${TopRated['backdrop_path']}",
                                    width: 120,
                                    height: 130,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return Image.asset(
                                        'assets/film.png',
                                        width: 120,
                                        height: 80,
                                      );
                                    },
                                  ),

                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          TopRated['original_title'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          TopRated['overview'],
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                            ),
                          );
                        },
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.yellow.shade50,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            label: 'Now Playing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Top Rated',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );

  }
}
