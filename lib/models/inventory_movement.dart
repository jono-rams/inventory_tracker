import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:inventory_tracker/models/inventory_item.dart';

class InventoryMovement {

  InventoryMovement({
    required this.id,
    required this.user,
    required this.item,
    required this.itemDocRef,
    required this.quantity,
    required this.movementDate,
    this.toWho,
    required this.comments,
  }) : dateString = DateFormat('yyyy-MM-dd').format(movementDate), isReceived = quantity > 0 ? true : false;

  final String id;
  final String user;
  late final InventoryItem item;
  final int quantity;
  final DateTime movementDate;
  final String dateString;
  final bool isReceived;
  final String? toWho;
  final String comments;
  final DocumentReference<InventoryItem> itemDocRef;

  Map<String, dynamic> toFirestore() {
    return {
      'id' : id,
      'user' : user,
      'item' : itemDocRef,
      'quantity': quantity,
      'movementDate': dateString,
      'toWho': toWho ?? '',
      'comments': comments,
    };
  }

  factory InventoryMovement.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    return InventoryMovement(
      id: snapshot.id,
      user: snapshot['user'],
      itemDocRef: snapshot['item'],
      item: InventoryItem.fromDocumentSnapshot(snapshot['item']),
      quantity: int.parse(snapshot['quantity']),
      movementDate: DateFormat('yyyy-MM-dd').parse(snapshot['movementDate']),
      toWho: snapshot['toWho'],
      comments: snapshot['comments'],
    );
  }
}