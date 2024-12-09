import 'package:flutter/material.dart';
import 'package:lecognition/domain/tree/entities/tree.dart';

class TreeCard extends StatelessWidget {
  final TreeEntityWithoutForeign tree;

  const TreeCard({super.key, required this.tree});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Rounded corners
      ),
      elevation: 5, // Shadow effect
      margin: const EdgeInsets.all(10), // Space around the card
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.green[50], // Light green background
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image or placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                tree.image ?? 'https://via.placeholder.com/150', // Default image
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            // Title
            Text(
              tree.desc ?? 'Deskripsi tidak tersedia',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            // Location (latitude & longitude)
            Row(
              children: [
                const Icon(Icons.location_pin, color: Colors.red),
                Expanded(
                  child: Text(
                    '(${tree.latitude?.toStringAsFixed(2)}, ${tree.longitude?.toStringAsFixed(2)})',
                    style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
