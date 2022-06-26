part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String searchTerm;
  final bool isSearching;

  const SearchState({required this.searchTerm, required this.isSearching});

  factory SearchState.initial() {
    return const SearchState(searchTerm: '', isSearching: false);
  }

  @override
  List<Object> get props => [searchTerm, isSearching];

  SearchState copyWith({required String searchTerm, required bool isSearching}) {
    return SearchState(
        searchTerm: searchTerm, //searchTerm ?? this.searchTerm,
        isSearching: isSearching); //isSearching ?? this.isSearching
  }
}
