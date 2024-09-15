import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_tracker/models/inventory_item.dart';
import 'package:inventory_tracker/models/inventory_movement.dart';
import 'package:inventory_tracker/services/firestore_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movement_provider.g.dart';

@riverpod
class MovementNotifier extends _$MovementNotifier {
  @override
  List<InventoryMovement> build() {
    return const [];
  }

  Future<void> getAllMovements(DocumentReference<InventoryItem> item) async {
    try {
      final snapshot = await FirestoreMovementService.getMovementsByItem(item);
      List<InventoryMovement> movements = [];
      for (var doc in snapshot.docs) {
        movements.add(doc.data());
      }
      state = movements;
    } catch (e) {
      print('Error fetching from Firebase: $e');
    }
  }

  Future<void> addMovement(InventoryMovement movement) async {
    try {
      await FirestoreMovementService.addMovement(movement);
      state = [...state, movement];
    } catch (e) {
      print('Error adding to Firebase: $e');
    }
  }
}
