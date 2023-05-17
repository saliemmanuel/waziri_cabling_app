import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'custom_text.dart';

class AccueilCard extends StatelessWidget {
  final Color? containerColor;
  final void Function()? onPressed;

  const AccueilCard({
    Key? key,
    required this.containerColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 250.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.2, 3.0),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 5.0,
              width: 250.0,
              decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                onTap: onPressed,
                title: const CustomText(data: "Installations"),
                subtitle: const CustomText(
                    data:
                        '\nEx sit reprehenderit reprehenderit non ea nostrud esse dolore magna aute minim.'),
              ),
            ),
            InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(8.0),
                      color: containerColor!.withOpacity(0.2)),
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: onPressed,
                    leading: Container(
                      width: 3.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: Colors.purple),
                    ),
                    title: const CustomText(data: "TOTAL"),
                    subtitle: const CustomText(data: "100", fontSize: 20.0),
                  ),
                ),
              ),
            ),
            const Divider(endIndent: 8.0, indent: 8.0),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                  onTap: onPressed,
                  title: const CustomText(data: "Détail", color: Colors.grey),
                  trailing: const Icon(IconlyLight.arrow_right_2)),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
