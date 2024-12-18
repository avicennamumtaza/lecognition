import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lecognition/common/helper/message/display_message.dart';
import 'package:lecognition/widgets/appbar.dart';
import 'package:lecognition/presentation/tree/bloc/tree_cubit.dart';
import 'package:lecognition/presentation/tree/bloc/tree_state.dart';
import 'package:lecognition/presentation/tree/pages/add_tree.dart';
import 'package:lecognition/widgets/tree_card.dart';

class TreesScreen extends StatefulWidget {
  TreesScreen({super.key});

  @override
  State<TreesScreen> createState() => _TreesScreenState();
}

class _TreesScreenState extends State<TreesScreen> {
  List<String> treeImages = [];
  int mapZoom = 7;

  LatLng getCenterPoint(List<LatLng> locationList) {
    double totalLatitude = 0;
    double totalLongitude = 0;
    for (int i = 0; i < locationList.length; i++) {
      totalLatitude += locationList[i].latitude;
      totalLongitude += locationList[i].longitude;
    }
    return LatLng(totalLatitude / locationList.length,
        totalLongitude / locationList.length);
  }

  void zoomIn() {
    if (mapZoom == 17) {
      DisplayMessage.errorMessage(
          context, 'Zoom level is already at maximum');
      return;
    }
    setState(() {
      mapZoom += 1;
    });
  }

  void zoomOut() {
    if (mapZoom == 5) {
      DisplayMessage.errorMessage(
          context, 'Zoom level is already at minimum');
      return;
    }
    setState(() {
      mapZoom -= 1;
    });
  }

  List<LatLng> getLocationTrees(
      List<double> latitudes, List<double> longitudes) {
    List<LatLng> locationPoints = [];
    for (int i = 0; i < latitudes.length; i++) {
      locationPoints.add(LatLng(latitudes[i], longitudes[i]));
    }
    return locationPoints;
  }

  @override
  Widget build(BuildContext context) {
    // getImagesPath();
    print("=============================================");
    print("treeImages: $treeImages");
    print("=============================================");
    return BlocProvider(
      create: (context) => TreeCubit()..getAllTrees(),
      child: BlocBuilder<TreeCubit, TreeState>(
        builder: (context, state) {
          if (state is TreeLoading) {
            return Scaffold(
              appBar: AppBarWidget(title: 'Daftar Tanaman'),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is TreeFailureLoad) {
            return Scaffold(
              appBar: AppBarWidget(title: 'Daftar Tanaman'),
              body: Center(
                child: Text(state.errorMessage),
              ),
            );
          }
          if (state is TreesLoaded) {
            final trees = state.trees;
            if (trees.isEmpty) {
              return Scaffold(
                appBar: AppBarWidget(title: 'Daftar Tanaman'),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Kamu belum menambahkan tanaman apapun :(',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // ElevatedButton(onPressed: () {}, child: child),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTreeScreen(image: ''),
                            ),
                          ).then((_) {
                            // if (value != null) {
                            BlocProvider.of<TreeCubit>(context).getAllTrees();
                            // getImagesPath();
                            // }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary
                                    .withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            'Tambah Tanaman',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Scaffold(
              appBar: AppBarWidget(title: 'Daftar Tanaman'),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTreeScreen(image: ''),
                    ),
                  ).then((_) {
                    BlocProvider.of<TreeCubit>(context).getAllTrees();
                  });
                },
                child: const Icon(Icons.add, color: Colors.white),
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Peta Lokasi Tanaman',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * 0.5,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: FlutterMap(
                            key: ValueKey(mapZoom),
                            options: MapOptions(
                              initialCenter: getCenterPoint(getLocationTrees(
                                  trees.map((tree) => tree.latitude!).toList(),
                                  trees
                                      .map((tree) => tree.longitude!)
                                      .toList())),
                              initialZoom: mapZoom.toDouble(),
                              maxZoom: 17.0,
                              minZoom: 5.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                              ),
                              MarkerLayer(
                                markers: getLocationTrees(
                                        trees
                                            .map((tree) => tree.latitude!)
                                            .toList(),
                                        trees
                                            .map((tree) => tree.longitude!)
                                            .toList())
                                    .map((point) => Marker(
                                          point: point,
                                          child: const Icon(
                                            Icons.location_pin,
                                            size: 30,
                                            color: Colors.red,
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 3,
                          right: 10,
                          child: Column(
                            children: [
                              FloatingActionButton(
                                onPressed: zoomIn,
                                child: const Icon(Icons.add),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                mini: true,
                              ),
                              // const SizedBox(height: 3),
                              FloatingActionButton(
                                onPressed: zoomOut,
                                child: const Icon(Icons.remove),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                mini: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      color: Colors.grey[500],
                      indent: 20,
                      endIndent: 20,
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 15),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.90,
                        ),
                        itemCount: trees.length,
                        itemBuilder: (BuildContext context, int index) {
                          final eachTree = trees[index];
                          return TreeCard(
                            tree: eachTree,
                            // treeImage: treeImages[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
