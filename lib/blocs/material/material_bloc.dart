import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gold_workshop_manager/models/material.dart';
import 'package:gold_workshop_manager/repositories/material_repository.dart';

// Events
abstract class MaterialEvent {}

class LoadMaterials extends MaterialEvent {}

class AddMaterial extends MaterialEvent {
  final Material material;

  AddMaterial(this.material);
}

class UpdateMaterial extends MaterialEvent {
  final Material material;

  UpdateMaterial(this.material);
}

class DeleteMaterial extends MaterialEvent {
  final String id;

  DeleteMaterial(this.id);
}

// States
abstract class MaterialState {}

class MaterialLoading extends MaterialState {}

class MaterialLoaded extends MaterialState {
  final List<Material> materials;

  MaterialLoaded(this.materials);
}

class MaterialError extends MaterialState {
  final String message;

  MaterialError(this.message);
}

// BLoC
class MaterialBloc extends Bloc<MaterialEvent, MaterialState> {
  final MaterialRepository _materialRepository = MaterialRepository();

  MaterialBloc() : super(MaterialLoading()) {
    on<LoadMaterials>((event, emit) async {
      await emit.forEach(_materialRepository.getMaterials(), onData: (materials) {
        return MaterialLoaded(materials);
      }, onError: (error, stackTrace) {
        return MaterialError(error.toString());
      });
    });

    on<AddMaterial>((event, emit) async {
      try {
        await _materialRepository.addMaterial(event.material);
      } catch (e) {
        emit(MaterialError(e.toString()));
      }
    });

    on<UpdateMaterial>((event, emit) async {
      try {
        await _materialRepository.updateMaterial(event.material);
      } catch (e) {
        emit(MaterialError(e.toString()));
      }
    });

    on<DeleteMaterial>((event, emit) async {
      try {
        await _materialRepository.deleteMaterial(event.id);
      } catch (e) {
        emit(MaterialError(e.toString()));
      }
    });
  }
}

