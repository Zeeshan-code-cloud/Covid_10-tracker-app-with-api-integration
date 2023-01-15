import 'dart:convert';
import 'package:covid_19_tracker/utils/AppUrls/AppUrls.dart';
import 'package:http/http.dart' as http;
import '../Models/API_Models.dart';

class FetchWorldRecord{

  Future<ApiModels> getRecord () async {
    final response = await http.get(Uri.parse(AppUrls.ApiUrl));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {

      return ApiModels.fromJson(data);
    }else{
      throw Exception("Error Occured");
    }
  }
}