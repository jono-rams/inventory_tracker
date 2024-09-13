import 'package:inventory_tracker/models/inventory_movement.dart';
import 'package:inventory_tracker/services/firestore_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movement_provider.g.dart';

@riverpod
class MovementNotifier extends _$MovementNotifier {
  @override
  Future<List<InventoryMovement>> build() async {
    List<InventoryMovement> movements = [];
    final snapshot = await FirestoreMovementService.getMovementsOnce();
    for (var doc in snapshot.docs) {
      movements.add(doc.data());
    }
    return movements;
  }

  Future<void> addMovement(InventoryMovement movement) async {
    try {
      await FirestoreMovementService.addMovement(movement);
      state = AsyncValue.data([...state.value!, movement]);
    } catch (e) {
      print('Error adding to Firebase: $e');
    }
  }
}
