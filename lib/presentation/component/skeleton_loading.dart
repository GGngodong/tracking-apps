import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonLoading extends StatelessWidget {
  final double height;
  final double width;
  final double cornerRadius;
  final BoxShape shape;

  const SkeletonLoading(
      {super.key,
      required this.height,
      required this.width,
      this.cornerRadius = 0,
      this.shape = BoxShape.rectangle});

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
        borderRadius: BorderRadius.circular(cornerRadius),
        shimmerColor: Colors.grey,
        shimmerDuration: 1500,
        curve: Curves.linear,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              shape: shape,
              borderRadius: shape == BoxShape.circle
                  ? null
                  : BorderRadius.circular(cornerRadius),
              color: Colors.grey[300]),
        ));
  }
}
