import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/home_controller.dart';
import 'helper/const.dart';
import 'movie_deatails.dart';

class SearchList extends StatefulWidget {
  @override
  SearchListState createState() => SearchListState();
}

class SearchListState extends State<SearchList> {
  TextEditingController controller = TextEditingController();
  final homeController = Get.find<home_controller>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Card(
              child: Row(
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  Expanded(
                    child: ListTile(
                      focusColor: Colors.black,
                      title: TextField(
                        controller: controller,
                        onChanged: onSearchTextChanged,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              controller.clear();
                              onSearchTextChanged('');
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                final searchResults = homeController.Now_playing
                    .where((movie) =>
                    (movie['original_title'] as String)
                        .toLowerCase()
                        .contains(controller.text.toLowerCase()));

                return searchResults.isNotEmpty
                    ? ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, i) {
                    final movie = searchResults.elementAt(i);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => movie_details_screen(
                              movie_Data: movie,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                              "$imageUrl2${movie['backdrop_path']}",
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
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie['original_title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    movie['overview'],
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
                )
                    : Center(
                  child: Text('No Search Results Found'),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void onSearchTextChanged(String text) {
    homeController.originalNowPlaying.clear();
    if (text.isEmpty) {
      homeController.Now_playing.addAll(homeController.originalNowPlaying);
    } else {
      homeController.Now_playing.addAll(homeController.originalNowPlaying
          .where((movie) =>
          movie['original_title'].toLowerCase()
              .contains(text.toLowerCase())));
    }
  }
}
