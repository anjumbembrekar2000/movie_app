
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/style.dart';

void showLoadingDialog({bool? loadingText=false}) {
  Future.delayed(
    Duration.zero,
        () {
      Get.dialog(
          WillPopScope(
            onWillPop: () async{
              return false;
            },
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)),
                    child : const Center(
                      child:  CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                      ),
                    )
                ),
              ),
            ),
          ),
          barrierDismissible: false);
    },
  );
}

void hideLoadingDialog({bool isTrue = false}) {
  Get.back(
    closeOverlays: isTrue,
  );
}

