import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_tracker/models/inventory_item.dart';
import 'package:inventory_tracker/providers/inventory_provider.dart';
import 'package:inventory_tracker/screens/create/create.dart';
import 'package:inventory_tracker/screens/home/item_card.dart';
import 'package:inventory_tracker/services/auth_service.dart';
import 'package:inventory_tracker/shared/styled_text.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  SetAndMapState allItems = const SetAndMapState(items: {}, docs: {});
  Set<InventoryItem> filteredItems = {};
  bool invalidSearch = false;

  @override
  void initState() {
    ref.read(inventoryNotifierProvider.notifier).getAllItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    allItems = ref.watch(inventoryNotifierProvider);
    if (filteredItems.isEmpty && !invalidSearch) {
      filteredItems = allItems.items;
    }

    return Scaffold(
      appBar: AppBar(
        title: const StyledAppBarText('Vemco It Asset Management System'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              AuthService.signOut();
            },
            icon: const Icon(Icons.exit_to_app_sharp),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: SearchBar(
              hintText: 'Search for specific item',
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
              onChanged: (str) {
                setState(() {
                  filteredItems = allItems.items.where((item) {
                    List<String> splitString = str.split(',');

                    bool name = splitString.any((individualString) {
                      return item.name.toLowerCase().contains(individualString.toLowerCase().trim()) && individualString.trim() != "";
                    });

                    if (item.tags.isNotEmpty) {
                      bool tag = item.tags.any((t) {
                        return splitString.any((individualTag) {
                          return t.toLowerCase().contains(individualTag.toLowerCase().trim()) && individualTag.trim() != "";
                        });
                      });
                      return name || tag;
                    }
                    return name;
                  }).toSet();

                  invalidSearch = filteredItems.isEmpty && str.isNotEmpty;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (_, index) {
                return ItemCard(item: filteredItems.elementAt(index));
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FilledButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (ctx) => const CreateItemScreen(),
                ));
              },
              child: const Text('Add New Item'),
            ),
          ),
        ],
      ),
    );
  }
}
