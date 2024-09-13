import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_tracker/models/inventory_item.dart';
import 'package:inventory_tracker/services/firestore_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'inventory_provider.g.dart';
part 'inventory_provider.freezed.dart';

@riverpod
class InventoryNotifier extends _$InventoryNotifier {
  @override
  Future<SetAndMapState> build() async {
    final snapshot = await FirestoreItemService.getItemsOnce();
    Set<InventoryItem> items = {};
    Map<String, DocumentReference<InventoryItem>> docs = {};
    for(var doc in snapshot.docs) {
      items.add(doc.data());
      docs[doc.data().id] = doc.reference;
    }
    return SetAndMapState(items: items, docs: docs);
  }

  Future<void> addItem(InventoryItem item) async {
    try {
      if(state.value!.items.contains(item)) {
        return;
      }
      final docRef = await FirestoreItemService.addItem(item);
      state = AsyncValue.data(state.value!.copyWith(
        items: {...state.value!.items, item},
        docs: {...state.value!.docs, item.id: docRef},
      ));
    } catch (e) {
      print('Error adding to Firebase: $e');
    }
  }

  Future<void> updateItem(InventoryItem item) async {
    try {
      if(!state.value!.items.contains(item)) {
        return;
      }
      await FirestoreItemService.updateItem(item);

      final updatedItems = state.value!.items.map((i) => i.id == item.id ? item : i).toSet();
      state = AsyncValue.data(state.value!.copyWith(items: updatedItems, docs: state.value!.docs));
    } catch(e) {
      print('Error updating in Firebase: $e');
    }
  }
}

@freezed
class SetAndMapState with _$SetAndMapState {
  const factory SetAndMapState({
    required Set<InventoryItem> items,
    required Map<String, DocumentReference<InventoryItem>> docs,
}) = _SetAndMapState;
}
