import 'package:flutter/material.dart';
import 'package:netflix_clone/app/config/theme/colors_config.dart';
import 'package:netflix_clone/app/config/theme/text_style.dart';

class CustomButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;

  CustomButtonWidget({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.padding,
    this.isLoading = false,
  });

  final BorderRadius _borderRadius = BorderRadius.circular(8.0);

  @override
  Widget build(BuildContext context) {
    // Quando o botão está carregando, a cor fica um pouco mais escura para dar feedback.
    final buttonColor = isLoading ? AppColors.blueDark1 : AppColors.blue;
    // O onPressed é desativado se o botão estiver carregando.
    final effectiveOnPressed = isLoading ? null : onPressed;

    return SizedBox(
      width: width ?? double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: effectiveOnPressed,
          borderRadius: _borderRadius,
          child: Ink(
            padding: padding ?? const EdgeInsets.symmetric(vertical: 14.0),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: _borderRadius,
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(label, style: AppTextStyles.mediumHeadline18),
            ),
          ),
        ),
      ),
    );
  }
}
