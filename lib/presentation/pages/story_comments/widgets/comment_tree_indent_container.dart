import 'package:flutter/material.dart';

class CommentTreeIndentContainer extends StatelessWidget {
  const CommentTreeIndentContainer({
    required this.indent,
    required this.child,
    super.key,
  });

  final int indent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (indent == 0) {
      return child;
    }

    final guidelineColor = Theme.of(context).colorScheme.secondary;

    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: indent * 24,
          ),
          Container(
            height: double.infinity,
            width: 2,
            color: guidelineColor,
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
