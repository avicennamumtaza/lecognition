import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lecognition/common/helper/navigation/app_navigator.dart';
import 'package:lecognition/core/constant/api_urls.dart';
import 'package:lecognition/data/tree/models/delete_tree_params.dart';
import 'package:lecognition/data/tree/models/get_tree_scans_params.dart';
import 'package:lecognition/domain/history/entities/history.dart';
import 'package:lecognition/domain/tree/entities/tree.dart';
import 'package:lecognition/domain/tree/usecases/delete_tree.dart';
import 'package:lecognition/presentation/history/pages/history_detail.dart';
import 'package:lecognition/presentation/tree/bloc/tree_cubit.dart';
import 'package:lecognition/presentation/tree/bloc/tree_state.dart';
import 'package:lecognition/presentation/tree/pages/edit_tree.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lecognition/service_locator.dart';

class TreeDetailScreen extends StatefulWidget {
  const TreeDetailScreen({
    super.key,
    required this.tree,
  });

  final TreeEntityWithoutForeign tree;

  @override
  State<TreeDetailScreen> createState() => Tree_DetailScreenState();
}

class Tree_DetailScreenState extends State<TreeDetailScreen> {
  late LatLng currentLocation;

  @override
  void initState() {
    super.initState();
    currentLocation = LatLng(
      widget.tree.latitude ?? 0,
      widget.tree.longitude ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: BlocProvider(
        create: (context) => TreeCubit()
          ..getTree(
            GetTreeScansParams(
              treeId: widget.tree.id!,
            ),
          ),
        child: BlocBuilder<TreeCubit, TreeState>(
          builder: (context, state) {
            if (state is TreeFailureLoad) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            if (state is TreesLoaded) {
              print('Tree detail: ${state.trees}');
              return Column(
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
                            image: Image.network(ApiUrls.baseUrlWithoutApi +
                                    widget.tree.image!.substring(1))
                                .image,
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
                                  backgroundColor: WidgetStateProperty.all(
                                      Colors.black.withOpacity(0.5)),
                                ),
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                ),
                                color: Colors.white,
                              ),
                              IconButton(
                                onPressed: () {
                                  subMenu(context, state.trees[0].id!);
                                },
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(
                                      Colors.black.withOpacity(0.5)),
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
                      widget.tree.name
                              .toString()
                              .substring(0, 1)
                              .toUpperCase() +
                          widget.tree.name.toString().substring(1),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.grey[500]),
                  SizedBox(height: 5),
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
                  SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.3,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: widget.tree.longitude != null &&
                              widget.tree.latitude != null
                          ? Colors.greenAccent
                          : Colors.grey[350],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onScaleStart: (_) {},
                          onScaleUpdate: (_) {},
                          child: FlutterMap(
                            options: MapOptions(
                              initialCenter: currentLocation,
                              interactionOptions: InteractionOptions(
                                flags: 2,
                                pinchMoveThreshold: 1.0,
                                pinchMoveWinGestures: 1,
                                pinchZoomThreshold: 1.0,
                                pinchZoomWinGestures: 1,
                              ),
                              initialZoom: 13.0,
                              maxZoom: 13.0,
                              minZoom: 13.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                              ),
                              Center(
                                child: Icon(
                                  Icons.location_pin,
                                  size: 40,
                                  color: widget.tree.longitude != null &&
                                          widget.tree.latitude != null
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 20,
                            height: MediaQuery.of(context).size.width * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '(${widget.tree.latitude}, ${widget.tree.longitude})',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(color: Colors.grey[500]),
                  SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Riwayat Diagnosis',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  BlocProvider(
                    create: (context) => TreeCubit()
                      ..getTreeScans(
                        GetTreeScansParams(
                          treeId: widget.tree.id!,
                        ),
                      ),
                    child: BlocBuilder<TreeCubit, TreeState>(
                        builder: (context, state) {
                      if (state is TreeScansLoaded) {
                        if (state.scans.isEmpty) {
                          return const Center(
                            child: Text('Tanaman ini belum pernah didiagnosis'),
                          );
                        }
                        return ListView.builder(
                          reverse: true,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.scans.length,
                          itemBuilder: (context, index) {
                            print('index: $index');
                            print('image: ${state.scans[index].img}');
                            print(
                                'disease entity: ${state.scans[index].disease}');
                            print('tree entity: ${state.scans[index].tree}');
                            print("accuracy: ${state.scans[index].accuracy}");
                            print("scan date: ${state.scans[index].datetime}");
                            print(
                                "tree name: ${state.scans[index].tree!.name}");
                            print("user: ${state.scans[index].user}");
                            final scan = state.scans[index];
                            return _historyPlant(index, scan);
                          },
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    ));
  }

  Future<Null> subMenu(BuildContext context, int treeId) {
    return showMenu(
      menuPadding: const EdgeInsets.all(0),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).colorScheme.onPrimary,
      position:
          RelativeRect.fromLTRB(MediaQuery.of(context).size.width, 0, 50, 0),
      items: [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              Icon(Icons.edit),
              const SizedBox(width: 10),
              Text('Ubah'),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.delete),
              const SizedBox(width: 10),
              Text('Hapus'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 0) {
        print("Edit selected");
        AppNavigator.push(
          context,
          EditTreeScreen(tree: widget.tree),
        );
      } else if (value == 1) {
        print("Delete selected");
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Konfirmasi', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
              content:
                  const Text('Apakah anda yakin ingin menghapus tanaman ini?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Batal', style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                ),
                TextButton(
                  onPressed: () async {
                    await sl<DeleteTreeUseCase>()
                        .call(params: DeleteTreeParams(treeId: treeId));
                    int count = 0;
                    Navigator.popUntil(context, (route) {
                      count++;
                      return count == 3;
                    });
                  },
                  child: Text('Hapus', style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
                ),
              ],
            );
          },
        );
      }
    });
  }

  Widget _historyPlant(int index, HistoryEntity scan) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(
          context,
          HistoryDetailScreen(
            imagePath: scan.img!,
            disease: scan.disease!,
            plantName: scan.tree!.name!,
            percentage: double.parse(scan.accuracy!),
            diagnosisNumber: index,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(5),
        color: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: '_imagePaths${index}',
                    child: Image.network(
                      ApiUrls.baseUrlWithoutApi + scan.img!.substring(1),
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${scan.disease!.name}' +
                                  (scan.disease!.id! > 1
                                      ? " 🔴"
                                      : " 💚"), // Diagnosis name
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              '${scan.datetime.toString()}',
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
