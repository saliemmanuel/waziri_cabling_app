import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/config.dart';
import '../../../../models/users.dart';
import '../provider/home_provider.dart';
import '../widget/app_header.dart';
import '../widget/shimmer_table.dart';
import '../widget/table_message.dart';

class Message extends StatefulWidget {
  final Users users;

  const Message({super.key, required this.users});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false).provideMessageMoi();
    return Scaffold(
      backgroundColor: Palette.scaffold,
      body: Container(
        height: double.infinity,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Palette.backgroundColor,
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appHeader("Message"),
            Expanded(
                child: Container(
                    margin: const EdgeInsets.only(
                        left: 45.0, right: 45.0, bottom: 40.0, top: 40.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Consumer<HomeProvider>(
                      builder: (context, value, child) {
                        return SizedBox(
                          child: value.listPannes == null
                              ? const ShimmerTable()
                              : TableMessage(
                                  users: widget.users,
                                  listMessage: value.listMessageMois),
                        );
                      },
                    )))
          ],
        ),
      ),
    );
  }
}
