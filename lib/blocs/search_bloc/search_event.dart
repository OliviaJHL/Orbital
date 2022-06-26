part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchTextChanged extends SearchEvent {
  final String searchText;
  SearchTextChanged({required this.searchText});
}

class SearchStateChanged extends SearchEvent {
  final bool isSearching;
  SearchStateChanged({this.isSearching = false});
}

class SearchTextAdded extends SearchEvent {
  final String searchText;
  SearchTextAdded({required this.searchText});
}