import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryItem {
  InventoryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.description,
    this.serialTag,
  });

  final String id;
  final String name;
  final int quantity;
  final String description;
  final String? serialTag;

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'description': description,
      if(serialTag != null) 'serialTag': serialTag,
    };
  }

  factory InventoryItem.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ){
        return InventoryItem(
          id: snapshot.id,
          name: snapshot['name'] as String,
          quantity: snapshot['quantity'] as int,
          description: snapshot['description'] as String,
          serialTag: snapshot['serialTag'] as String?,
        );
    }

  factory InventoryItem.fromDocumentSnapshot(DocumentSnapshot doc) {
    return InventoryItem(
      id: doc.id,
      name: doc['name'] as String,
      quantity: doc['quantity'] as int,
      description: doc['description'] as String,
      serialTag: doc['serialTag'] as String?,
    );
  }
}