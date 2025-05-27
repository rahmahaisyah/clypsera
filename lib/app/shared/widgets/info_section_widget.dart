import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:flutter/material.dart';

class InfoSectionWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        dividerColor: Style.greyColor2,
        animationDuration: const Duration(milliseconds: 300),
        expansionCallback: (int panelIndex, bool newIsExpanded) {
          onExpansionChanged(newIsExpanded);
        },
        children: [
          ExpansionPanel(
            backgroundColor: Style.whiteColor,
            canTapOnHeader: true,
            isExpanded: isExpanded,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                title: Text(
                  title,
                  style: Style.headLineStyle2
                ),
              );
            },
            body: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 8.0),
              decoration:
                  const BoxDecoration(border: Border(top: BorderSide.none)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
