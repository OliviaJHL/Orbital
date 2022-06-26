part of 'item_filter_bloc.dart';

abstract class ItemFilterEvent extends Equatable {
  const ItemFilterEvent();

  @override
  List<Object> get props => [];
}

class ItemFilterChanged extends ItemFilterEvent {
  const ItemFilterChanged(this.cuisineFilter, this.allergenFilter);
  final String cuisineFilter;
  final String allergenFilter;
  @override
  List<Object> get props => [allergenFilter, cuisineFilter];
}
