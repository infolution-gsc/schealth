import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthy_planner/utils/theme.dart';
import 'package:healthy_planner/widget/dropdown/list_item.dart';
import 'package:collection/collection.dart';

class DropDownList<T> extends StatefulWidget {
  final List<ListItem<T>> listItems;
  final T? value;
  final ValueChanged<T?>? onChange;

  const DropDownList({
    Key? key,
    required this.listItems,
    this.value,
    this.onChange,
  }) : super(key: key);

  @override
  _DropDownListState<T> createState() => _DropDownListState<T>();
}

class _DropDownListState<T> extends State<DropDownList<T>> {
  final GlobalKey _key = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  ListItem? _selected;
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isOverlayShown = false;
  OverlayEntry? _overlay;
  FocusScopeNode? _focusScopeNode;

  @override
  void initState() {
    super.initState();
    if (widget.listItems.isNotEmpty) {
      _selected = widget.value == null
          ? widget.listItems.first
          : widget.listItems
              .firstWhereOrNull((listItem) => listItem.value == widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _onTap,
        child: FocusableActionDetector(
          focusNode: _focusNode,
          mouseCursor: SystemMouseCursors.click,
          actions: {
            ActivateIntent: CallbackAction<Intent>(onInvoke: (_) => _onTap()),
          },
          onShowFocusHighlight: (isFocused) =>
              setState(() => _isFocused = isFocused),
          onShowHoverHighlight: (isHovered) =>
              setState(() => _isHovered = isHovered),
          child: Container(
            key: _key,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: blueBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selected == null ? '' : _selected!.title,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 16 / 2.0),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _focusScopeNode?.dispose();
  }

  OverlayEntry _createOverlay() {
    _focusScopeNode = FocusScopeNode();
    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _removeOverlay,
        child: Stack(
          children: [
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomRight,
              followerAnchor: Alignment.topRight,
              child: Material(
                color: Colors.transparent,
                child: FocusScope(
                  node: _focusScopeNode,
                  child: _createListItems(),
                  onKey: (node, event) {
                    if (event.logicalKey == LogicalKeyboardKey.escape) {
                      _removeOverlay();
                    }

                    return KeyEventResult.ignored;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeOverlay() {
    _overlay!.remove();
    _isOverlayShown = false;
    _focusScopeNode!.dispose();
    FocusScope.of(context).nextFocus();
  }

  Widget _createListItems() {
    RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16 / 2.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            spreadRadius: 9,
            blurRadius: 13,
            color: Color.fromRGBO(0, 0, 0, 0.05),
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      width: renderBox?.size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.listItems
            .map((listItem) => ListItem(
                  listItem.title,
                  onTap: () => _onListItemTap(listItem),
                ))
            .toList(),
      ),
    );
  }

  void _onTap() {
    if (_isOverlayShown) {
      _removeOverlay();
    } else {
      _overlay = _createOverlay();
      Overlay.of(context).insert(_overlay!);
      _isOverlayShown = true;
      FocusScope.of(context).setFirstFocus(_focusScopeNode!);
    }
  }

  void _onListItemTap(ListItem listItem) {
    _removeOverlay();
    print(listItem.value);
    setState(() {
      _selected = listItem;
    });

    widget.onChange?.call(listItem.value);
  }
}
