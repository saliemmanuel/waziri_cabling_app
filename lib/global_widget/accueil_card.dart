import 'package:flutter/material.dart';

import 'custom_text.dart';

class AccueilCard extends StatelessWidget {
  final Color? containerColor;
  final String label;
  final void Function()? onPressed;

  const AccueilCard({
    Key? key,
    required this.containerColor,
    this.onPressed,
    required this.label,
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
                title: CustomText(data: label),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(8.0),
                        color: containerColor!.withOpacity(0.2)),
                    margin: const EdgeInsets.all(8.0),
                    child: const CustomText(
                        data: "100000000000000000000000000000",
                        fontSize: 26.0)),
              ),
            ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
