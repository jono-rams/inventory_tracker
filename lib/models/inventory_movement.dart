import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_tracker/models/inventory_item.dart';

class InventoryMovement {

  InventoryMovement({
    required this.id,
    required this.item,
    required this.itemDocRef,
    required this.quantity,
    required this.movementDate,
    required this.isReceived,
    this.toWho,
    required this.comments,
  });

  final String id;
  late final InventoryItem item;
  final int quantity;
  final DateTime movementDate;
  final bool isReceived;
  final String? toWho;
  final String comments;
  final DocumentReference itemDocRef;

  Map<String, dynamic> toFirestore() {
    return {
      'id' : id,
      'item' : itemDocRef,
      'quantity': quantity,
      'movementDate': movementDate.toIso8601String(),
      'isReceived': isReceived,
      if(toWho != null) 'toWho': toWho,
      'comments': comments,
    };
  }

  factory InventoryMovement.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    return InventoryMovement(
      id: snapshot.id,
      itemDocRef: snapshot['item'],
      item: InventoryItem.fromDocumentSnapshot(snapshot['item']),
      quantity: int.parse(snapshot['quantity']),
      movementDate: DateTime.parse(snapshot['movementDate']),
      isReceived: bool.parse(snapshot['isReceived']),
      toWho: snapshot['toWho'],
      comments: snapshot['comments'],
    );
  }
}