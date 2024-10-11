import 'package:flutter/material.dart';
import 'package:lecognition/models/disease.dart';

class DiseaseCard extends StatelessWidget {
  const DiseaseCard({required this.disease, super.key});
  final Disease disease;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      // width: MediaQuery.of(context).size.width / - 20,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://halosehat.com/wp-content/uploads/2019/05/manfaat-daun-mangga-696x395.jpg"),
                    ),
                  ),
                ),
                Positioned(
                  top: 10.0,
                  right: 10.0,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.star_border,
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: -15.0,
                //   left: 10.0,
                //   child: Container(
                //     width: 45.0,
                //     height: 45.0,
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: this.disease.diseaseId != 0
                //           ? Colors.green.shade800
                //           : Colors.orange.shade800,
                //     ),
                //     child: Center(
                //       child: Text(
                //         this.disease.diseaseId != 0
                //             ? "Healty"
                //             : "Diseased",
                //         style: const TextStyle(
                //           fontSize: 8.0,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        disease.diseaseName,
                        style: const TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    Text(
                      disease.diseaseName,
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.green.shade300,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  disease.description,
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Color(0xFF343434),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.align_horizontal_left_sharp,
                      size: 15.0,
                      color: Color.fromRGBO(255, 136, 0, 1),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      disease.diseaseName,
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFF343434),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}