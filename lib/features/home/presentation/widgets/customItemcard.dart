import 'package:flutter/material.dart';

class CustomItemCard extends StatelessWidget {
  final List scanResult;
  final int index;
  CustomItemCard(this.scanResult, this.index, {super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange, width: 2.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(
                Icons.description,
                color: Colors.orange,
                size: 24.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Container(
              width: 220,
              child: Text(
                scanResult[index],
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
