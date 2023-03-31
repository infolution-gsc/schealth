import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_planner/controller/healthController.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:healthy_planner/widget/health/listHealth.dart';
import 'package:healthy_planner/widget/health/listHealthCategory.dart';

class Health extends StatefulWidget {
  const Health({super.key});

  @override
  State<Health> createState() => _HealthState();
}

class _HealthState extends State<Health> {
  List<String> listDataLabel = <String>["All"];
  String selectedCategory = "All";

  HealthController controller = HealthController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 20),
            child: Container(
              height: 30,
              child: StreamBuilder<QuerySnapshot<Object?>>(
                  stream: controller.getDataLabel(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        var listAlldocs = snapshot.data!.docs;

                        if (listAlldocs.isNotEmpty) {
                          for (var element = 0;
                              element < listAlldocs.length;
                              element++) {
                            var data = (listAlldocs[element].data()
                                as Map<String, dynamic>)['category'];
                            listDataLabel.add(data);
                          }
                        }
                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: listDataLabel.length,
                          itemBuilder: (context, index) {
                            var doc = listDataLabel[index];
                            return Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: ChoiceChip(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                backgroundColor: const Color(0xFFD8E6FD),
                                selectedColor: blueBackground,
                                label: Text(
                                  doc,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: selectedCategory != doc
                                        ? blueBackground
                                        : const Color(0xFFD8E6FD),
                                  ),
                                ),
                                selected: selectedCategory == doc,
                                onSelected: (value) {
                                  setState(() {
                                    selectedCategory = doc;
                                  });
                                },
                              ),
                            );
                          },
                        );
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
                  }),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: selectedCategory == "All"
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Better Sleep",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF132B52),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    selectedCategory = "Better Sleep";
                                  });
                                },
                                child: const Text(
                                  "View All",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF9E9E9E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 160,
                          child: Expanded(
                            child: StreamBuilder<QuerySnapshot<Object?>>(
                              stream: controller.getData("Better Sleep"),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (snapshot.hasData) {
                                    var listAlldocs = snapshot.data!.docs;
                                    if (listAlldocs.isNotEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: ListView.builder(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: listAlldocs.length,
                                          itemBuilder: (context, index) {
                                            var doc = listAlldocs[index];
                                            return ListHealth(
                                              url: (doc.data() as Map<String,
                                                  dynamic>)['url'],
                                              title: (doc.data() as Map<String,
                                                  dynamic>)['title'],
                                              thumbnail: (doc.data() as Map<
                                                  String,
                                                  dynamic>)['thumbnail'],
                                              type: (doc.data() as Map<String,
                                                  dynamic>)['type'],
                                              desc: (doc.data() as Map<String,
                                                  dynamic>)['desc'],
                                              source: (doc.data() as Map<String,
                                                  dynamic>)['source'],
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Everyday Simple Yoga",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF132B52),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    selectedCategory = "Everyday Simple Yoga";
                                  });
                                },
                                child: const Text(
                                  "View All",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF9E9E9E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 160,
                          child: Expanded(
                            child: StreamBuilder<QuerySnapshot<Object?>>(
                              stream:
                                  controller.getData("Everyday Simple Yoga"),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (snapshot.hasData) {
                                    var listAlldocs = snapshot.data!.docs;
                                    if (listAlldocs.isNotEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: ListView.builder(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: listAlldocs.length,
                                          itemBuilder: (context, index) {
                                            var doc = listAlldocs[index];
                                            return ListHealth(
                                              url: (doc.data() as Map<String,
                                                  dynamic>)['url'],
                                              title: (doc.data() as Map<String,
                                                  dynamic>)['title'],
                                              thumbnail: (doc.data() as Map<
                                                  String,
                                                  dynamic>)['thumbnail'],
                                              type: (doc.data() as Map<String,
                                                  dynamic>)['type'],
                                              desc: (doc.data() as Map<String,
                                                  dynamic>)['desc'],
                                              source: (doc.data() as Map<String,
                                                  dynamic>)['source'],
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Eat Healthy",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF132B52),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    selectedCategory = "Eat Healthy";
                                  });
                                },
                                child: const Text(
                                  "View All",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF9E9E9E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 160,
                          child: Expanded(
                            child: StreamBuilder<QuerySnapshot<Object?>>(
                              stream: controller.getData("Eat Healthy"),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (snapshot.hasData) {
                                    var listAlldocs = snapshot.data!.docs;
                                    if (listAlldocs.isNotEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: ListView.builder(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: listAlldocs.length,
                                          itemBuilder: (context, index) {
                                            var doc = listAlldocs[index];
                                            return ListHealth(
                                              url: (doc.data() as Map<String,
                                                  dynamic>)['url'],
                                              title: (doc.data() as Map<String,
                                                  dynamic>)['title'],
                                              thumbnail: (doc.data() as Map<
                                                  String,
                                                  dynamic>)['thumbnail'],
                                              type: (doc.data() as Map<String,
                                                  dynamic>)['type'],
                                              desc: (doc.data() as Map<String,
                                                  dynamic>)['desc'],
                                              source: (doc.data() as Map<String,
                                                  dynamic>)['source'],
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Healthy From Mind",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF132B52),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    selectedCategory = "Healthy From Mind";
                                  });
                                },
                                child: const Text(
                                  "View All",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF9E9E9E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 160,
                          child: Expanded(
                            child: StreamBuilder<QuerySnapshot<Object?>>(
                              stream: controller.getData("Healthy From Mind"),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (snapshot.hasData) {
                                    var listAlldocs = snapshot.data!.docs;
                                    if (listAlldocs.isNotEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: ListView.builder(
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: listAlldocs.length,
                                          itemBuilder: (context, index) {
                                            var doc = listAlldocs[index];
                                            return ListHealth(
                                              url: (doc.data() as Map<String,
                                                  dynamic>)['url'],
                                              title: (doc.data() as Map<String,
                                                  dynamic>)['title'],
                                              thumbnail: (doc.data() as Map<
                                                  String,
                                                  dynamic>)['thumbnail'],
                                              type: (doc.data() as Map<String,
                                                  dynamic>)['type'],
                                              desc: (doc.data() as Map<String,
                                                  dynamic>)['desc'],
                                              source: (doc.data() as Map<String,
                                                  dynamic>)['source'],
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
                          ),
                        ),
                      ],
                    )
                  : ListCategoryHealth(category: selectedCategory)),
        ],
      ),
    );
  }
}
