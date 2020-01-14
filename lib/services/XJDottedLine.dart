import 'package:flutter/material.dart';

import 'XJExtension.dart';

class DottedLine extends StatelessWidget {
  const DottedLine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = 2.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor()+5;
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: XJColors.hexColor(0xa1a1a1)),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}