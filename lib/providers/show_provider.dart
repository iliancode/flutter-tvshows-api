import 'package:flutter/material.dart';
import '../models/show.dart';
import '../services/api_service.dart';

class ShowProvider with ChangeNotifier {
  List<Show> _popularShows = [];
  List<Show> _searchResults = [];
  bool _isLoading = false;
  String _searchQuery = '';
  int _currentPage = 1;
  bool _hasMore = true;

  List<Show> get shows =>
      _searchQuery.isEmpty ? _popularShows : _searchResults;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  ShowProvider() {
    fetchInitialShows();
  }

  Future<void> fetchInitialShows() async {
    _currentPage = 1;
    _hasMore = true;
    _isLoading = true;
    notifyListeners();

    try {
      final results = _searchQuery.isEmpty
          ? await ApiService.fetchPopularShows(_currentPage)
          : await ApiService.searchShows(_searchQuery, _currentPage);

      if (_searchQuery.isEmpty) {
        _popularShows = results;
      } else {
        _searchResults = results;
      }

      _hasMore = results.isNotEmpty;
    } catch (e) {
      if (_searchQuery.isEmpty) _popularShows = [];
      else _searchResults = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (!_hasMore || _isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      _currentPage++;
      final results = _searchQuery.isEmpty
          ? await ApiService.fetchPopularShows(_currentPage)
          : await ApiService.searchShows(_searchQuery, _currentPage);

      if (results.isEmpty) {
        _hasMore = false;
      } else {
        if (_searchQuery.isEmpty) {
          _popularShows.addAll(results);
        } else {
          _searchResults.addAll(results);
        }
      }
    } catch (e) {
      _hasMore = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _currentPage = 1;
    _hasMore = true;
    _searchResults = [];
    fetchInitialShows();
  }
}
