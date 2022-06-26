import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState.initial()) {
    on<SearchStateChanged>(searchStateChangedEvent);
    on<SearchTextChanged>(searchTextChangedEvent);
    on<SearchTextAdded>(searchTextAddedEvent);
  }

  void searchTextChangedEvent(
      SearchTextChanged event, Emitter<SearchState> emit)  {
    emit(state.copyWith(
        searchTerm: event.searchText,
        isSearching: event.searchText.isNotEmpty ? true : false));
  }

  void searchStateChangedEvent(
      SearchStateChanged event, Emitter<SearchState> emit)  {
    emit(state.copyWith(
        isSearching: event.isSearching, searchTerm: state.searchTerm));
  }

  void searchTextAddedEvent(
      SearchTextAdded event, Emitter<SearchState> emit) {
    emit(state.copyWith(searchTerm: event.searchText, isSearching: false));
  }
}
