import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:healthy_planner/screens/article.dart';
import 'package:healthy_planner/screens/video.dart';
import 'package:healthy_planner/widget/transitions/slide_transitions.dart';

class ListInCategory extends StatefulWidget {
  final String url;
  final String title;
  final String thumbnail;
  final String type;
  final String desc;
  final String source;
  const ListInCategory(
      {super.key,
      required this.url,
      required this.title,
      required this.thumbnail,
      required this.type,
      required this.desc,
      required this.source});

  @override
  State<ListInCategory> createState() => _ListInCategoryState();
}

class _ListInCategoryState extends State<ListInCategory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.type == "Video"
          ? () => Navigator.push(
              context,
              SlideTopRoute(
                  page: Video(
                      title: widget.title,
                      url: widget.url,
                      desc: widget.desc,
                      thumbnail: widget.thumbnail,
                      source: widget.source)))
          : () => Navigator.push(
              context, SlideTopRoute(page: Article(url: widget.url))),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(14)),
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            image: DecorationImage(
                                image: NetworkImage(widget.thumbnail),
                                fit: BoxFit.cover)),
                      ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xFfBDD5FC),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  bottomRight: Radius.circular(14))),
                          height: 20,
                          width: 70,
                          child: Text(
                            widget.type,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF306BCE)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0C1A31),
                        ),
                      ),
                      Text(
                        widget.source,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF9E9E9E),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
