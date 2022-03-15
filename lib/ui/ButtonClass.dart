import 'package:flutter/material.dart';
import 'package:todo/helpers/theme.dart';

class CircleIconButton extends StatelessWidget {
  final double size;
  final void Function()? onPressed;
  final IconData icon;

  CircleIconButton({this.size = 20.0, this.icon = Icons.clear, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: this.onPressed,
        child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment(0.0, 0.0), // all centered
              children: <Widget>[
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: primary),
                ),
                Icon(
                  icon,
                  size: size * 0.6,
                  color: white,// 60% width for icon
                )
              ],
            )));
  }
}