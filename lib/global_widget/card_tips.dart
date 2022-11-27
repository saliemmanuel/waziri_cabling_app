import 'package:flutter/material.dart';

class CardTips extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Color? iconColors;
  final Color? titleColors;
  final Color? cardColors;
  final Function()? onTap;
  const CardTips(
      {Key? key,
      required this.title,
      required this.icon,
      required this.iconColors,
      required this.titleColors,
      required this.cardColors,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (value) {},
      child: Container(
        margin: const EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: cardColors),
                    child: Icon(icon, color: iconColors)),
                const SizedBox(width: 10.0),
                Text(title ?? " ",
                    style: TextStyle(
                      color: titleColors,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
