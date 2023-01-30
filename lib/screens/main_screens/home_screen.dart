import 'package:flutter/material.dart';
import '../../widgets/menu_list.dart';

import '../upload_screens/menus_upload_screen.dart';
import '../../global/global.dart';
import '../../widgets/my_drawer.dart';
import '../../widgets/text_header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  builder: (c) => const MenusUploadScreen(),
                ),
              );
            },
            icon: const Icon(Icons.post_add, color: Colors.white),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextWidgetHeader('My Menus'),
            const MenuList(),
          ],
        ),
      ),
    );
  }
}
