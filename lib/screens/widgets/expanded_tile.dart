import 'package:db/screens/widgets/titles.dart';
import 'package:flutter/material.dart';

class ExpansionTileEditied extends StatelessWidget {
  const ExpansionTileEditied(
      {super.key,
      required this.firstText,
      required this.secondText,
      this.onExpansionChanged,
      this.trailing,
      required this.children});

  final String firstText;
  final String secondText;
  final void Function(bool)? onExpansionChanged;
  final Widget? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Titles(
            text: firstText,
            text2: secondText,
            color: Colors.white.withOpacity(.7),
          ),
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          onExpansionChanged: onExpansionChanged,
          controlAffinity: ListTileControlAffinity.trailing,
          trailing: trailing,
          children: children,
        ),
      ),
    );
  }
}
