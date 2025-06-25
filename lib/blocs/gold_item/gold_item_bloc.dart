import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_workshop_manager/models/gold_item.dart';
import 'package:gold_workshop_manager/repositories/gold_item_repository.dart';

// Events
abstract class GoldItemEvent {}

class LoadGoldItems extends GoldItemEvent {
  final String? karat;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;

  LoadGoldItems({
    this.karat,
    this.startDate,
    this.endDate,
    this.status,
  });
}

class AddGoldItem extends GoldItemEvent {
  final GoldItem goldItem;

  AddGoldItem(this.goldItem);
}

class UpdateGoldItem extends GoldItemEvent {
  final GoldItem goldItem;

  UpdateGoldItem(this.goldItem);
}

class DeleteGoldItem extends GoldItemEvent {
  final String id;

  DeleteGoldItem(this.id);
}

// States
abstract class GoldItemState {}

class GoldItemLoading extends GoldItemState {}

class GoldItemLoaded extends GoldItemState {
  final List<GoldItem> goldItems;

  GoldItemLoaded(this.goldItems);
}

class GoldItemError extends GoldItemState {
  final String message;

  GoldItemError(this.message);
}

// BLoC
class GoldItemBloc extends Bloc<GoldItemEvent, GoldItemState> {
  final GoldItemRepository _goldItemRepository = GoldItemRepository();

  GoldItemBloc() : super(GoldItemLoading()) {
    on<LoadGoldItems>((event, emit) async {
      await emit.forEach(
        _goldItemRepository.getGoldItems(
          karat: event.karat,
          startDate: event.startDate,
          endDate: event.endDate,
          status: event.status,
        ),
        onData: (goldItems) {
          return GoldItemLoaded(goldItems);
        },
        onError: (error, stackTrace) {
          return GoldItemError(error.toString());
        },
      );
    });

    on<AddGoldItem>((event, emit) async {
      try {
        await _goldItemRepository.addGoldItem(event.goldItem);
      } catch (e) {
        emit(GoldItemError(e.toString()));
      }
    });

    on<UpdateGoldItem>((event, emit) async {
      try {
        await _goldItemRepository.updateGoldItem(event.goldItem);
      } catch (e) {
        emit(GoldItemError(e.toString()));
      }
    });

    on<DeleteGoldItem>((event, emit) async {
      try {
        await _goldItemRepository.deleteGoldItem(event.id);
      } catch (e) {
        emit(GoldItemError(e.toString()));
      }
    });
  }
}

