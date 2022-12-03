import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:waziri_cabling_app/config/config.dart';
import 'package:waziri_cabling_app/desktop/screen/home/home_desk_screen.dart';

class CustomPaneItem extends StatelessWidget {
  final Widget? title;
  final Widget icon;
  final Widget selectedIcon;
  final Widget? infoBadge;
  final Widget? trailing;
  final Widget body;
  final FocusNode? focusNode;
  final MouseCursor? mouseCursor;
  final Color? tileColor;
  final Color? selectedTileColor;
  final Function()? onPressed;
  final bool isSelected;
  final int index;
  const CustomPaneItem({
    Key? key,
    this.title,
    required this.icon,
    required this.selectedIcon,
    this.infoBadge,
    this.trailing,
    required this.body,
    this.focusNode,
    this.mouseCursor,
    this.tileColor,
    this.selectedTileColor,
    this.onPressed,
    required this.isSelected,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      child: Row(
        children: [
          Visibility(
            visible: isSelected,
            child: JelloIn(
              child: Container(
                  height: 25.0,
                  width: 5.0,
                  decoration: BoxDecoration(
                      color: Palette.primaryColor,
                      borderRadius: BorderRadius.circular(15.0))),
            ),
          ),
          Expanded(
            child: ListTile(
              title: body,
              leading: isSelected ? selectedIcon : icon,
              trailing: trailing,
              onTap: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
