import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_tracker/models/inventory_item.dart';
import 'package:inventory_tracker/models/inventory_movement.dart';


class FirestoreItemService {
  static final ref = FirebaseFirestore.instance
      .collection('items')
      .withConverter(
      fromFirestore: InventoryItem.fromFirestore,
      toFirestore: (InventoryItem item, _) => item.toFirestore()
  );

  // add Item
  static Future<void> addItem(InventoryItem item) async {
    await ref.doc(item.id).set(item);
  }

  // update Item
  static Future<void> updateItem(InventoryItem item) async {
    await ref.doc(item.id).update({
      'quantity' : item.quantity,
    });
  }

  // delete Item
  static Future<void> deleteItem(InventoryItem item) async {
    await ref.doc(item.id).delete();
  }

  // get all items
  static Future<QuerySnapshot<InventoryItem>> getItemsOnce() {
    return ref.get();
  }
}

class FirestoreMovementService {
  static final ref = FirebaseFirestore.instance
      .collection('movements')
      .withConverter(
      fromFirestore: InventoryMovement.fromFirestore,
      toFirestore: (InventoryMovement movement, _) => movement.toFirestore()
  );

  // add Movement
  static Future<void> addMovement(InventoryMovement movement) async {
    await ref.doc(movement.id).set(movement);
  }

  // get all movements
  static Future<QuerySnapshot<InventoryMovement>> getMovementsOnce() {
    return ref.get();
  }
}

