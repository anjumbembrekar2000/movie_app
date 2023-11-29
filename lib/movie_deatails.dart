// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../helper/style.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'helper/const.dart';


class movie_details_screen extends StatefulWidget {
  var movie_Data;
  movie_details_screen({Key? key, this.movie_Data}) : super(key: key);
  @override
  State<movie_details_screen> createState() => _movie_details_screenState();
}
class _movie_details_screenState extends State<movie_details_screen> {
  double containerOffset = 0.60;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text("Back"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 25.0,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [

          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: CachedNetworkImage(
              imageUrl: "$imageUrl${widget.movie_Data['poster_path']}",
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorWidget: (context, url, error) {
                return Image.asset(
                  'assets/film.png',
                );
              },
            ),
          ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: 20,
            bottom: containerOffset,
            right: 20,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  containerOffset += details.primaryDelta!;
                });
              },
              onVerticalDragEnd: (details) {

                setState(() {
                  containerOffset = 0.0;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Colors.black.withOpacity(0.5),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie_Data['original_title'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Release Date: ${widget.movie_Data['release_date']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star_border,color: Colors.white,),
                            SizedBox(width: 5,),
                            Text(widget.movie_Data['vote_average'].toString()+'%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.watch_later_outlined,color: Colors.white,),
                            SizedBox(width: 5,),
                            Text(widget.movie_Data['popularity'].toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      widget.movie_Data['overview'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}