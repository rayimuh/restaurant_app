import 'dart:async';
import '../api/api_service.dart';
import '../model/model.dart';
import 'package:flutter/material.dart';
import '../utils/result_state.dart';


class ListRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ListRestaurantProvider({required this.apiService}) {
    fetchListRestaurant();
  }

  late getList _listRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  getList get result => _listRestaurant;
  ResultState get state => _state;

  Future<dynamic> fetchListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final listRestaurant = await apiService.loadList();
      if (listRestaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listRestaurant = listRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Check your internet connection!';
    }
  }
}