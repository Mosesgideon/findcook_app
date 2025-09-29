import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_cook/core/theme/pallets.dart';

class ShimerView extends StatelessWidget {
  const ShimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ShimmerLoading(height: 200, width: 1.sw),
            10.verticalSpace,
            ShimmerLoading(height: 80, width: 1.sw),
            10.verticalSpace,
            ShimmerLoading(height: 50, width: 100),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerLoading(height: 100, width: 150),
                ShimmerLoading(height: 100, width: 150),
              ],
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerLoading(height: 100, width: 150),
                ShimmerLoading(height: 100, width: 150),
              ],
            ),
            10.verticalSpace,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerLoading(height: 100, width: 150),
                ShimmerLoading(height: 100, width: 150),
              ],
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerLoading(height: 100, width: 150),
                ShimmerLoading(height: 100, width: 150),
              ],
            ),

            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerLoading(height: 100, width: 150),
                ShimmerLoading(height: 100, width: 150),
              ],
            ),
            10.verticalSpace,
            ShimmerLoading(height: 50, width: 100),
          ],
        ),
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  final double height;
  final double width;
  const ShimmerLoading({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Pallets.grey95.withOpacity(0.6),
      ),
    );
  }
}
