import 'dart:convert';
import 'package:covid_19_tracker/utils/AppUrls/AppUrls.dart';
import 'package:http/http.dart' as http;
class Countries_based_record{
  AppUrls appUrls  = AppUrls();

  Future<List<dynamic>> GetCountriesList () async{
    final response = await http.get(Uri.parse(AppUrls.coutriesList));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return data;
    }else{
      throw Exception("error occured");
    }
  }
}