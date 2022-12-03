import 'package:flutter/material.dart';

import '../config/config.dart';

class CustomDropDown extends StatelessWidget {
  final List listItem;

  const CustomDropDown({
    Key? key,
    required this.listItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedItem = "Assignez son secteur";

    return Container(
      height: 55.5,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Palette.primaryColor)),
      child: Center(
        child: DropdownButton(
            isExpanded: true,
            underline: const SizedBox(),
            hint: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(selectedItem.toString()),
            ),
            dropdownColor: Colors.white,
            items: listItem
                .map((e) => DropdownMenuItem<String>(
                      value: e,
                      child:
                          Text(e, style: const TextStyle(color: Colors.black)),
                    ))
                .toList(),
            onChanged: (newVille) {
              selectedItem = newVille!;
            }),
      ),
    );
  }
}
