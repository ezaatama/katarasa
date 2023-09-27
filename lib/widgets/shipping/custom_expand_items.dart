import 'package:flutter/material.dart';

class CustomExpandableItem extends StatelessWidget {
  final Widget header;
  final Widget expandedChild;
  final bool isExpanded;
  final VoidCallback onTap;

  const CustomExpandableItem({
    required this.header,
    required this.expandedChild,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: header,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isExpanded ? null : 0,
          child: isExpanded
              ? SingleChildScrollView(
                  child: expandedChild,
                )
              : null,
        ),
      ],
    );
  }
}
