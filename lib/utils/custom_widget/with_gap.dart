import 'package:flutter/material.dart';

class WithGap extends StatelessWidget {
  final List<Widget> children;
  final bool isRow;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double height;
  final double width;

  const WithGap({
    super.key,
    required this.children,
    this.isRow = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.height = 0,
    this.width = 0,
  });

  @override
  Widget build(BuildContext context) {
    return isRow ? _buildWithGapRow() : _buildWithGapColumn();
  }

  Widget _buildWithGapRow() {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: _buildChildrenWithGap(),
    );
  }

  Widget _buildWithGapColumn() {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: _buildChildrenWithGap(),
    );
  }

  List<Widget> _buildChildrenWithGap() {
    List<Widget> widgets = [];

    for (int i = 0; i < children.length; i++) {
      widgets.add(children[i]);
      if (i != children.length - 1) {
        widgets.add(SizedBox(
          width: isRow ? width : 0,
          height: isRow ? 0 : height,
        ));
      }
    }

    return widgets;
  }
}
