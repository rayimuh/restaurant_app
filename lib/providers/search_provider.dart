import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../model/model.dart';
import 'dart:async';
import '../utils/result_state.dart';


class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String query;

  SearchRestaurantProvider({required this.apiService,required this.query}){
    _fetchSearchRestaurant(query);
  }

  late findList _findResto;
  late ResultState _state;
  String _message = '';  

  String get message => _message;
  findList get result => _findResto;  
  ResultState get state => _state;

 Future<dynamic> _fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final filterRestaurant = await apiService.findRestaurant(query);
      if (filterRestaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _findResto = filterRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Check your internet connection!';
    }
  }
}