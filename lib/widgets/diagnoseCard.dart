import 'package:flutter/material.dart';
import 'package:lecognition/models/diagnosis.dart';
import 'package:lecognition/models/disease.dart';

class DiagnosisCard extends StatelessWidget {
  const DiagnosisCard({required this.disease, super.key});
  final Disease disease;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 4,
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
                      image: NetworkImage(
                          "https://www.bing.com/ck/a?!&&p=3e42c74407c1fe0dJmltdHM9MTcyODYwNDgwMCZpZ3VpZD0yZDJjZGMyMy04ZjVmLTZlZDYtMTA4Zi1jODIzOGUwOTZmMDAmaW5zaWQ9NTQ4NQ&ptn=3&ver=2&hsh=3&fclid=2d2cdc23-8f5f-6ed6-108f-c8238e096f00&u=a1L2ltYWdlcy9zZWFyY2g_cT1kYXVuK21hbmdnYSZpZD0xOEFCNzY0N0E0NUI1N0VDMURFMzJBQUM3NTY0MzMwNDAyQkE5OTFCJkZPUk09SVFGUkJB&ntb=1"),
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
                Positioned(
                  bottom: -15.0,
                  left: 10.0,
                  child: Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: disease.diseaseId != 0
                          ? Colors.green.shade800
                          : Colors.orange.shade800,
                    ),
                    child: Center(
                      child: Text(
                        disease.diseaseId != 0 ? "Healty" : "Diseased",
                        style: const TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            // decoration: const BoxDecoration(
            //   border: Border(
            //     bottom: BorderSide(
            //       color: Colors.black, // Warna garis bawah
            //       width: 10.0, // Ketebalan garis bawah
            //     ),
            //   ),
            // ),
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
          ),
        ],
      ),
    );
  }
}
