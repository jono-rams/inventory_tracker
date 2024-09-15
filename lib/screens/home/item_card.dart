import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_tracker/models/inventory_item.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({
    super.key,
    required this.item,
    required this.itemRef,
  });

  final InventoryItem item;
  final DocumentReference<InventoryItem> itemRef;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(widget.item.name, style: const TextStyle(letterSpacing: 2),)),
          FilledButton(
            onPressed: () {},
            child: const Text('View Details'),
          ),
        ],
      ),
    );
  }
}
