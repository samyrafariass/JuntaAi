import 'package:flutter/material.dart';
import '../../core/typography.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.width,
    this.height = 50,
    this.backgroundColor,
    this.foregroundColor = Colors.white,
    this.borderRadius = 5,
    this.elevation = 0,
    this.isLoading = false,
    this.fullWidth = false,
    this.leading,
    this.trailing,
    this.semanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color foregroundColor;
  final double borderRadius;
  final double elevation;
  final bool isLoading;
  final bool fullWidth;
  final Widget? leading;
  final Widget? trailing;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null || isLoading;
    final scheme = Theme.of(context).colorScheme;

    final btn = FilledButton(
      onPressed: disabled ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor ?? scheme.primary,
        disabledBackgroundColor: (backgroundColor ?? scheme.primary).withOpacity(0.5),
        foregroundColor: foregroundColor,
        elevation: elevation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        padding: EdgeInsets.zero,
        minimumSize: Size(width ?? 0, height),
        fixedSize: fullWidth ? Size.fromHeight(height) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 8)],
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: isLoading
                ? SizedBox(
                    key: const ValueKey('loader'),
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(foregroundColor)),
                  )
                : Text(
                    key: const ValueKey('label'),
                    label,
                    style: AppTypography.buttonPrimary.copyWith(color: foregroundColor),
                  ),
          ),
          if (trailing != null) ...[const SizedBox(width: 8), trailing!],
        ],
      ),
    );

    final semantics = Semantics(
      button: true,
      enabled: !disabled,
      label: semanticLabel ?? label,
      child: ExcludeSemantics(child: btn),
    );

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: semantics);
    }
    return SizedBox(width: width, height: height, child: semantics);
  }
}
