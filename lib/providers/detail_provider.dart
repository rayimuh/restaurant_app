import 'dart:async';
import '../api/api_service.dart';
import '../model/model.dart';
import 'package:flutter/material.dart';
import '../utils/result_state.dart';


class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant(id);
  }
  
  late getDetail _detailRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  getDetail get result => _detailRestaurant;
  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.loadDetail(id);
      if (detailRestaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = detailRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Check your internet connection!';
    }
  }
}