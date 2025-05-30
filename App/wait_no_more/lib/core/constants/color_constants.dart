import 'package:flutter/material.dart';

class AppColors {
  // Blue Palette (Primary Medical Theme)
  static const Color blue50 = Color(0xFFEFF6FF);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color blue600 = Color(0xFF2563EB);
  static const Color blue700 = Color(0xFF1D4ED8);
  static const Color blue800 = Color(0xFF1E40AF);

  // Green Palette (Secondary Medical Theme)
  static const Color green50 = Color(0xFFF0FDF4);
  static const Color green500 = Color(0xFF22C55E);
  static const Color green600 = Color(0xFF16A34A);
  static const Color green700 = Color(0xFF15803D);
  static const Color green800 = Color(0xFF166534);

  // Red Palette (Occupied/Error States)
  static const Color red500 = Color(0xFFEF4444);

  // Yellow Palette (Warning/Pending States)
  static const Color yellow200 = Color(0xFFFEF3C7);
  static const Color yellow500 = Color(0xFFEAB308);
  static const Color yellow800 = Color(0xFF92400E);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray800 = Color(0xFF1F2937);

  // Border Colors (not defined in main palette but mentioned)
  static const Color borderBlue200 = Color(0xFFBFDBFE);
  static const Color borderGreen200 = Color(0xFFBBF7D0);

  // Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [blue50, green50],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient headerGradient = LinearGradient(
    colors: [blue500, blue600],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [blue500, blue600],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient buttonHoverGradient = LinearGradient(
    colors: [blue600, blue700],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
