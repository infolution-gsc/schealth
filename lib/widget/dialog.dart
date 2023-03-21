import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DialogWidget extends StatefulWidget {
  final bool isCancel;
  final String textCancel;
  final String textOK;
  final String textContent;
  final String textTitle;

  const DialogWidget({
    super.key,
    required this.isCancel,
    required this.textCancel,
    required this.textContent,
    required this.textOK,
    required this.textTitle,
  });

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsOverflowAlignment: widget.isCancel
          ? OverflowBarAlignment.center
          : OverflowBarAlignment.end,
      shadowColor: const Color.fromARGB(0, 0, 0, 100),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        widget.textTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Color(0xFF2756A5), fontWeight: FontWeight.w600),
      ),
      content: Text(
        widget.textContent,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Color(0xFF262626), fontWeight: FontWeight.w500),
      ),
      actions: [
        widget.isCancel
            ? TextButton(
                onPressed: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xFF9CC0FB)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 26),
                    child: Text(
                      widget.textOK,
                      style: const TextStyle(
                        color: Color(0xFF2756A5),
                      ),
                    ),
                  ),
                ))
            : Container(),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFF306BCE)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26),
                child: Text(
                  widget.textOK,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
