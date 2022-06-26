part of 'item_filter_bloc.dart';

class ItemFilterState extends Equatable {
  const ItemFilterState({this.allergenFilter = '', this.cuisineFilter = ''})
      : super();
  final String cuisineFilter;
  final String allergenFilter;

  ItemFilterState copyWith(
      {String cuisineFilter = '', String allergenFilter = ''}) {
    return ItemFilterState(
      cuisineFilter: cuisineFilter,
      allergenFilter: allergenFilter,
    );
  }

  @override
  List<Object> get props => [allergenFilter, cuisineFilter];
}
