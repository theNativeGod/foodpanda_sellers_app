import 'package:flutter/material.dart';

import '../global/global.dart';
import '../screens/authentication/auth_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
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
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                //header drawer
                Material(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(80),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 20, fontFamily: "Train"),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          //body drawer
          Container(
            padding: const EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.red,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.white),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 10,
                  color: Colors.red,
                  thickness: 2,
                ),

                ListTile(
                  leading:
                      const Icon(Icons.monetization_on, color: Colors.white),
                  title: const Text(
                    "My Earnings",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 10,
                  color: Colors.red,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.reorder, color: Colors.white),
                  title: const Text(
                    "New Orders",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 10,
                  color: Colors.red,
                  thickness: 2,
                ),
                ListTile(
                  leading:
                      const Icon(Icons.local_shipping, color: Colors.white),
                  title: const Text(
                    "Order History",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 10,
                  color: Colors.red,
                  thickness: 2,
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.white),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    firebaseAuth.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => const AuthScreen(),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 10,
                  color: Colors.red,
                  thickness: 2,
                ),
                //const SizedBox(height: 12),
              ],
            ),
          ),
          Container(
            height: 145,
            //decoration: const BoxDecoration(
            //  gradient: LinearGradient(
            //    colors: [
            //      Colors.red,
            //      Colors.amber,
            //    ],
            //    begin: FractionalOffset(0.0, 0.0),
            //    end: FractionalOffset(1.0, 0.0),
            //    stops: [0.0, 1.0],
            //    tileMode: TileMode.clamp,
            //  ),
            //),
            child: const Center(
              child: Text(
                "iFood",
                style: TextStyle(
                  fontSize: 60,
                  fontFamily: "Lobster-Regular",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
