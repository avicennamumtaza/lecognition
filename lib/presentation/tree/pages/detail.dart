import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/domain/tree/entities/tree.dart';

import '../../../common/helper/message/display_message.dart';
import '../../../common/widgets/appbar.dart';
import '../../bookmark/bloc/bookmark_cubit.dart';
import '../../bookmark/bloc/bookmark_state.dart';

class DetailPlantScreen extends StatefulWidget {
  const DetailPlantScreen({
    super.key,
    required this.tree,
  });

  final TreeEntityWithoutForeign tree;

  @override
  State<DetailPlantScreen> createState() => _DetailPlantScreenState();
}

class _DetailPlantScreenState extends State<DetailPlantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      image: AssetImage('assets/images/mg.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)),
                          ),
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {
                            subMenu(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Colors.black.withOpacity(0.5)),
                          ),
                          icon: Icon(
                            Icons.more_vert_outlined,
                            size: 30,
                          ),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.tree.desc ?? 'Deskripsi tidak tersedia',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Lokasi',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.3,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: widget.tree.longitude != null && widget.tree.latitude != null ? Colors.greenAccent : Colors.grey[350],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.location_pin,
                      size: 50,
                      color: widget.tree.longitude != null && widget.tree.latitude != null ? Colors.red : Colors.grey
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: MediaQuery.of(context).size.width * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(15),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '(${widget.tree.latitude?.toStringAsFixed(2)}, ${widget.tree.longitude?.toStringAsFixed(2)})',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        )
                      ),
                    )
                  )
                ]
              ),
            ),
            SizedBox(height: 5),
            Divider(color: Colors.grey[300]),
            SizedBox(height: 7),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Riwayat Tanaman',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            for (int i = 0; i < 5; i++)
              _historyPlant(i),
          ],
        ),
      )
    );
  }

  Future<Null> subMenu (BuildContext context) {
    return showMenu(
      menuPadding: const EdgeInsets.all(0),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).colorScheme.onPrimary,
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width,
        0,
        50,
        0,
      ),
      items: [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              Icon(Icons.edit, color: Colors.black),
              const SizedBox(width: 10),
              Text('Ubah'),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.black),
              const SizedBox(width: 10),
              Text('Hapus'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 0) {
        print("Edit selected");
      } else if (value == 1) {
        print("Delete selected");
      }
    });
  }

  Widget _historyPlant(int index) {
    return GestureDetector(
      onTap: () {
        // Navigate to detail screen when tapped
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ResultHistoryScreen(
        //       imagePath: _imagePaths[index],
        //       disease: ds,
        //       plantName: _plantNames[index],
        //       percentage: double.parse(_percentages[index]),
        //       diagnosisNumber: index,
        //     ),
        //   ),
        // );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(
              16.0), // 16px padding from all sides
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Align items to the top
                children: [
                  // Image placed on the top-left of the card
                  Hero(
                    tag: '_imagePaths${index}', // Unique tag for each image
                    // child: Image.file(
                    //   File(_imagePaths[index]),
                    //   width: 70,
                    //   height: 70,
                    //   fit: BoxFit.cover,
                    // ),
                    child: Image.asset(
                      'assets/images/mg.jpeg',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                      width: 10), // Space between image and text
                  // Column for text
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Diagnosis #Powder', // Diagnosis name
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '21-10-2024', // Static date, replace with actual if needed
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
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