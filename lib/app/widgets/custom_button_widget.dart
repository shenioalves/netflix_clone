import 'package:flutter/material.dart';
import 'package:netflix_clone/app/config/theme/colors_config.dart';
import 'package:netflix_clone/app/config/theme/text_style.dart';

class CustomButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final EdgeInsetsGeometry? padding;

  CustomButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.padding,
  });
  final BorderRadius _borderRadius = BorderRadius.circular(8.0);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:
              onPressed ??
              () {
                debugPrint('Custom Button Pressed');
              },
          borderRadius: _borderRadius,
          child: Ink(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 14.0),
            decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: _borderRadius,
            ),
            child: Center(
              child: Text(
                label,
                style: AppTextStyles.medium22.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
