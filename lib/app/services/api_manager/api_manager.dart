import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/endpoints.dart';
import 'package:http/http.dart' as http;

class APIManager{
  static Future<http.Response> getInternshipData() async {
    try{
      final http.Response response = await http.get(Uri.parse(EndPoints.url));
      return response;
    } catch(e){
      Get.showSnackbar(const GetSnackBar(title: "Error", message: "Something went wrong!",));
      rethrow;
    }
  }
}