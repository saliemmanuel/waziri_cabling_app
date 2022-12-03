import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../global_widget/custom_text.dart';

class ShimmerTable extends StatelessWidget {
  const ShimmerTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 20.0,
      child: Shimmer(
        period: const Duration(seconds: 3),
        gradient: const LinearGradient(colors: [Colors.grey, Colors.white]),
        child: Column(
          children: [
            const SizedBox(height: 50.0),
            Row(
              children: [
                const SizedBox(width: 15.0),
                Container(
                  alignment: Alignment.center,
                  height: 40.0,
                  width: 130.0,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: const Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        hintText: "Search", border: InputBorder.none),
                  )),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 40.0,
                  width: 230.0,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: const Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        hintText: "Search", border: InputBorder.none),
                  )),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 40.0,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: Colors.teal),
                      CustomText(
                          data: "Ajoutez un utilisateur",
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              ],
            ),
            for (var i = 0; i < 3; i++)
              Container(
                margin:
                    const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5.0)),
              ),
          ],
        ),
      ),
    );
  }
}
