import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:healthy_planner/controller/healthController.dart';
import 'package:healthy_planner/widget/health/listInCategory.dart';

class ListCategoryHealth extends StatefulWidget {
  final String category;
  const ListCategoryHealth({super.key, required this.category});

  @override
  State<ListCategoryHealth> createState() => _ListCategoryHealthState();
}

class _ListCategoryHealthState extends State<ListCategoryHealth> {
  HealthController controller = HealthController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Text(
              widget.category,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF132B52),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot<Object?>>(
            stream: controller.getData(widget.category),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  var listAlldocs = snapshot.data!.docs;
                  if (listAlldocs.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listAlldocs.length,
                        itemBuilder: (context, index) {
                          var doc = listAlldocs[index];
                          return ListInCategory(
                            url: (doc.data() as Map<String, dynamic>)['url'],
                            title:
                                (doc.data() as Map<String, dynamic>)['title'],
                            thumbnail: (doc.data()
                                as Map<String, dynamic>)['thumbnail'],
                            type: (doc.data() as Map<String, dynamic>)['type'],
                            desc: (doc.data() as Map<String, dynamic>)['desc'],
                            source:
                                (doc.data() as Map<String, dynamic>)['source'],
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "Tidak ada data",
                        style: TextStyle(fontSize: 8),
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: Text(
                      "Tidak ada data",
                      style: TextStyle(fontSize: 8),
                    ),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }
}
