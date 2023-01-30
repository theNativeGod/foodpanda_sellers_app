import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/widgets/item_list.dart';

import '../../global/global.dart';
import '../../model/menus.dart';
import '../upload_screens/items_upload_screen.dart';

import '../../widgets/text_header_widget.dart';

class ItemsScreen extends StatefulWidget {
  final Menus model;

  const ItemsScreen(this.model, {super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          sharedPreferences!.getString("name")!,
          style: const TextStyle(
            fontFamily: 'Lobster-Regular',
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.amber,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => ItemsUploadScreen(widget.model),
                ),
              );
            },
            icon: const Icon(Icons.library_add, color: Colors.red),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextWidgetHeader('${widget.model.menuTitle!}\'s Items'),
            ItemsList(widget.model),
          ],
        ),
      ),
    );
  }
}
