import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import '../helper/const.dart';
import '../helper/loader.dart';
class home_controller extends GetxController {
  RxBool isApiCallProcessing = false.obs;
  RxList Now_playing = [].obs;
  RxList originalNowPlaying = [].obs;
  RxList Top_Rated = [].obs;
  TextEditingController search = TextEditingController();

  Future<void> top_rated_api() async {
    Top_Rated.clear();
    isApiCallProcessing.value = true;
    showLoadingDialog();
    var url = top_rated;
    //print(url);
    var uri = Uri.parse(url);
    final response = await http.get(uri,);
    if (response.statusCode == 200) {
      isApiCallProcessing.value = false;
      hideLoadingDialog();
      final resp = jsonDecode(response.body);
      int page = resp['page'];
      if (page == 1) {
        Top_Rated.clear();
        Top_Rated.addAll(resp['results']);
      //  print("movieList ==> ${Top_Rated.length}");
        Top_Rated.refresh();
      } else if(page == "0"){
        Top_Rated.clear();
        //print("movieList ==> ${Top_Rated.length}");
      }
    } else {
      hideLoadingDialog();
      isApiCallProcessing.value = false;
      Top_Rated.refresh();
    }
  }

  Future<void> now_playing() async {
    Now_playing.clear();
    isApiCallProcessing.value = true;
    showLoadingDialog();
    var url = nowplaying;
 //   print(url);
    var uri = Uri.parse(url);
    try {
      final response = await http.get(uri,);
      if (response.statusCode == 200) {
        isApiCallProcessing.value = false;
        hideLoadingDialog();
        final resp = jsonDecode(response.body);
        int page = resp['page'];
        if (page == 1) {
          Now_playing.clear();
          Now_playing.addAll(resp['results']);
          originalNowPlaying.addAll(resp['results']);
         // print("Now_playing ==> ${Now_playing.length}");
          Now_playing.refresh();
        } else if (page == 0) {
          Now_playing.clear();
          //print("Now_playing ==> ${Now_playing.length}");
        }
      } else {
        hideLoadingDialog();
        isApiCallProcessing.value = false;
        Now_playing.refresh();
      }
    } catch (error) {
      hideLoadingDialog();
      isApiCallProcessing.value = false;
      Now_playing.refresh();
    }
  }
}