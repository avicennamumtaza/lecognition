import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/core/constant/api_urls.dart';
import 'package:lecognition/domain/tree/entities/tree.dart';
import 'package:lecognition/presentation/tree/bloc/tree_cubit.dart';
import 'package:lecognition/presentation/tree/pages/tree.dart';

class TreeCard extends StatelessWidget {
  final TreeEntityWithoutForeign tree;
  // final String treeImage;

  const TreeCard({super.key, required this.tree});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TreeDetailScreen(
            tree: tree,
            // treeImage: treeImage,
          );
        })).then((_) {
          BlocProvider.of<TreeCubit>(context).getAllTrees();
          
        });
      },
      child: Card(
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
                  ApiUrls.baseUrlWithoutApi + tree.image!.substring(1),
                  fit: BoxFit.cover,
                  height: 100,
                  width: double.infinity,
                ),
                // File(treeImage).existsSync()
                //     ? Image.file(
                //         File(treeImage),
                //         fit: BoxFit.cover,
                //         height: 100,
                //         width: double.infinity,
                //       )
                //     : const Icon(
                //         Icons.image_not_supported,
                //         size: 100,
                //         color: Colors.grey,
                //       ),
              ),
              const SizedBox(height: 10),
              // Title
              Text(
                tree.name!,
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
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
