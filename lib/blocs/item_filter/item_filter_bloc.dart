import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'item_filter_event.dart';
part 'item_filter_state.dart';

class ItemFilterBloc extends Bloc<ItemFilterEvent, ItemFilterState> {
  ItemFilterBloc() : super(const ItemFilterState()){
    on<ItemFilterChanged>(_onItemFilterChanged);
  }

  FutureOr<void> _onItemFilterChanged(ItemFilterChanged event, Emitter<ItemFilterState> emit) {
    emit(event.cuisineFilter == '' && event.allergenFilter == ''
        ? const ItemFilterState()
        : ItemFilterState(
            cuisineFilter: event.cuisineFilter,
            allergenFilter: event.allergenFilter,
          ));
  }
}