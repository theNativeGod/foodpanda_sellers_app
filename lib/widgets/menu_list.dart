import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodpanda_sellers_app/widgets/info_design.dart';

import '../global/global.dart';
import '../model/menus.dart';

class MenuList extends StatelessWidget {
  const MenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("sellers")
            .doc(sharedPreferences!.getString("uid"))
            .collection("menus")
            .snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                  ),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, i) {
                    Menus mModel = Menus.fromJson(
                        snapshot.data!.docs[i].data() as Map<String, dynamic>);
                    return InfoDesignWidget(
                      model: mModel,
                      context: ctx,
                    );
                  },
                );
        },
      ),
    );
  }
}
