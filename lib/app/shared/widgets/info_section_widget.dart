import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:flutter/material.dart';

class InfoSectionWidget extends StatefulWidget {
  final String title;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;

  const InfoSectionWidget({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.onExpansionChanged,
    required this.children,
  });

  @override
  State<InfoSectionWidget> createState() => _InfoSectionWidgetState();
}

class _InfoSectionWidgetState extends State<InfoSectionWidget> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            setState(() => isTapped = true);
            await Future.delayed(const Duration(milliseconds: 100));
            setState(() => isTapped = false);
            widget.onExpansionChanged(!widget.isExpanded);
          },
          splashColor: Style.primaryColorOp4,
          highlightColor: Style.primaryColorOp4,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: isTapped ? Colors.grey[200] : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title, style: Style.headLineStyle2),
                Icon(
                  widget.isExpanded ? Icons.expand_less : Icons.expand_more,
                  size: 24.0,
                  color: Style.primaryColor,
                )
              ],
            ),
          ),
        ),
        if (widget.isExpanded)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.children,
            ),
          ),
      ],
    );
  }
}
