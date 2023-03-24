import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ListHealth extends StatefulWidget {
  final String url;
  final String title;
  final String thumbnail;
  final String type;
  final String desc;

  const ListHealth(
      {super.key,
      required this.url,
      required this.title,
      required this.thumbnail,
      required this.type,
      required this.desc});

  @override
  State<ListHealth> createState() => _ListHealthState();
}

class _ListHealthState extends State<ListHealth> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
          width: 140,
          height: 90,
          child: Stack(
            children: [
              Image.network(widget.thumbnail, fit: BoxFit.cover),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Container(
                  height: 15,
                  child: Text(widget.type),
                ),
              )
            ],
          ),
        ),
        Container(
          child: Text(widget.title),
        ),
      ]),
    );
  }
}
