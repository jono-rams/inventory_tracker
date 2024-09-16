import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_tracker/models/app_user.dart';
import 'package:inventory_tracker/models/inventory_item.dart';
import 'package:inventory_tracker/models/inventory_movement.dart';
import 'package:inventory_tracker/providers/auth_provider.dart';
import 'package:inventory_tracker/providers/inventory_provider.dart';
import 'package:inventory_tracker/providers/movement_provider.dart';
import 'package:inventory_tracker/shared/styled_text.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateItemScreen extends ConsumerStatefulWidget {
  const CreateItemScreen({super.key});

  @override
  ConsumerState<CreateItemScreen> createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends ConsumerState<CreateItemScreen> {
  final _formGlobalKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String _name = '';
  String _description = '';
  String _serialNumber = '';
  int _quantity = 0;
  List<String> _tags = [];

  String _comment = '';

  final _quantityController = TextEditingController();

  @override
  void initState() {
    _quantityController.text = _quantity.toString();
    super.initState();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  // submit handler
  void _handleSubmit(AsyncValue<AppUser?> user) async {
    setState(() {
      _isLoading = true;
    });

    InventoryItem item = InventoryItem(
      id: uuid.v4(),
      name: _name,
      tags: _tags,
      quantity: _quantity,
      description: _description,
      serialTag: _serialNumber,
    );

    final doc = await ref.read(inventoryNotifierProvider.notifier).addItem(item);

    InventoryMovement movement = InventoryMovement(
      id: uuid.v4(),
      user: user.value!.uid,
      itemDocRef: doc!,
      quantity: _quantity,
      movementDate: DateTime.now(),
      comments: _comment,
    );

    ref.read(movementNotifierProvider.notifier).addMovement(movement);

    setState(() {
      _isLoading = false;
      Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<AppUser?> user = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const StyledAppBarText('Add New Item'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
      ),
      body: MouseRegion(
        cursor: _isLoading ? SystemMouseCursors.wait : SystemMouseCursors.click, // Change cursor based on _isLoading
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  maxLength: 64,
                  decoration: const InputDecoration(
                    labelText: 'Item Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Item name is required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  maxLength: 512,
                  decoration: const InputDecoration(
                    labelText: 'Item Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Item description is required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  maxLength: 32,
                  decoration: const InputDecoration(
                    labelText: 'Serial Tag',
                  ),
                  onSaved: (value) {
                    if (value != null) {
                      _serialNumber = value;
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _quantityController,
                        maxLength: 3,
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Quantity is required';
                          }
        
                          if (int.tryParse(value) == null) {
                            return 'Invalid number';
                          }
        
                          if (int.parse(value) < 0) {
                            return 'Quantity cannot be negative';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _quantity = int.tryParse(value) ?? 0;
                          });
                        },
                        onSaved: (value) {
                          _quantity = int.tryParse(value!) ?? 0;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _quantity++;
                          _quantityController.text = _quantity.toString();
                        });
                      },
                      icon: const Icon(Icons.exposure_plus_1),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _quantity--;
                          _quantityController.text = _quantity.toString();
                        });
                      },
                      icon: const Icon(Icons.exposure_minus_1),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Tags (comma-separated)',
                  ),
                  onSaved: (value) {
                    if (value != null) {
                      _tags = value.split(',').map((tag) => tag.trim()).toList();
                    }
                  },
                ),
                const SizedBox(height: 32),
                TextFormField(
                  maxLength: 512,
                  decoration: const InputDecoration(
                    labelText: 'Reason why added (Comment for added movement)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Comment required (e.g new item ordered from Amazon)';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _comment = value!;
                  },
                ),
        
                // submit button
                const SizedBox(
                  height: 20,
                ),
                FilledButton(
                  onPressed: () {
                    if (_formGlobalKey.currentState!.validate()) {
                      _formGlobalKey.currentState!.save();
                      _handleSubmit(user);
                      _formGlobalKey.currentState!.reset();
                    }
                  },
                  style: FilledButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )),
                  child: const Text('Add'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
