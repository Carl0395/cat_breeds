import 'package:flutter/material.dart' show Color, ColorScheme;

extension CustomColorScheme on ColorScheme {
  Color get primaryColor          => Color(0xFFDA4F30);
  Color get secondaryColor        => Color(0xFF3464E2);
  Color get backgroundColor       => Color(0xFFF1F2F6);
  Color get inputTextColor        => Color(0xFF323232);
  Color get highlightShimmerColor => const Color(0xFFEDEEF1);
  Color get baseShimmerColor      => const Color(0xFFDCDCDC);
  Color get placeholderPhoto      => const Color(0xFFDFDFDF);
  Color get iconPlaceholderPhoto  => const Color(0xFFB5B7BA);
  Color get blueColor             => const Color(0xFF1574F2);
  Color get borderList            => const Color(0xFFBFC2C6);
}
