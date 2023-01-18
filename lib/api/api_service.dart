import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../model/model.dart';

 
class ApiService {
  
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';   
  Client? client;
  ApiService({this.client}){
    client??=Client();
  }
 
  Future<getList> loadList() async {
    final response = await client?.get(Uri.parse("$baseUrl/list"));
    if (response!.statusCode == 200) {
      return getList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list');
    }
  }

   Future<getDetail> loadDetail(String id) async {
    final response = await client?.get(Uri.parse("$baseUrl/detail/$id"));
    if (response!.statusCode == 200) {
      return getDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get detail');
    }
  }

   Future<findList> findRestaurant(String query) async {
    final response = await client?.get(Uri.parse("$baseUrl/search?q=$query"));
    if (response!.statusCode == 200) {
      return findList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to find');
    }
  }
}