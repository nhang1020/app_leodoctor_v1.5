import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCard extends StatefulWidget {
  const LoadingCard({super.key});

  @override
  State<LoadingCard> createState() => _LoadingCardState();
}

class _LoadingCardState extends State<LoadingCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: .7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            GreyContainer(
              width: 12,
              height: 12,
            ),
            SizedBox(width: 5),
            GreyContainer(
              height: 16,
            ),
            Expanded(child: SizedBox()),
            GreyContainer(
              width: 12,
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}

class GreyContainer extends StatelessWidget {
  const GreyContainer({
    super.key,
    this.width,
    this.height,
    this.radius,
    this.color,
  });
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color ?? Colors.grey.withOpacity(.4),
      highlightColor: Colors.grey,
      child: Container(
        height: height ?? 13,
        width: width ?? 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 5),
          color: color ?? Colors.grey.withOpacity(.4),
        ),
      ),
    );
  }
}
