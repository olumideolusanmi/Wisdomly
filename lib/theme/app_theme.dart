import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Wisdomly editorial palette
  static const Color paper = Color(0xFFF5EEDC);
  static const Color paperEdge = Color(0xFFEAE1CB);
  static const Color ink = Color(0xFF0D1830);
  static const Color amber = Color(0xFFF59E0B);
  static const Color amberSoft = Color(0xFFFBBF24);
  static const Color mutedInk = Color(0xFF4A5E82);
  static const Color rule = Color(0x1F0D1830);

  // Legacy aliases kept for widgets that still reference them.
  static const Color primaryColor = amber;
  static const Color accentColor = amberSoft;
  static const Color backgroundColor = paper;
  static const Color cardColor = Colors.white;
  static const Color textColor = ink;
  static const Color secondaryTextColor = mutedInk;

  static TextStyle serifQuote({
    double size = 26,
    Color color = ink,
    FontWeight weight = FontWeight.w500,
    FontStyle style = FontStyle.italic,
  }) => GoogleFonts.playfairDisplay(
    color: color,
    fontSize: size,
    height: 1.4,
    fontWeight: weight,
    fontStyle: style,
  );

  static TextStyle serifDisplay({double size = 34, Color color = ink}) =>
      GoogleFonts.playfairDisplay(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w700,
        height: 1.1,
      );

  static TextStyle caps({
    double size = 11,
    Color color = mutedInk,
    double spacing = 2.4,
    FontWeight weight = FontWeight.w700,
  }) => GoogleFonts.dmSans(
    color: color,
    fontSize: size,
    fontWeight: weight,
    letterSpacing: spacing,
  );

  static TextStyle sansBody({
    double size = 14,
    Color color = mutedInk,
    FontWeight weight = FontWeight.w500,
  }) => GoogleFonts.dmSans(
    color: color,
    fontSize: size,
    fontWeight: weight,
    height: 1.5,
  );

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: paper,
    primaryColor: amber,
    colorScheme: ColorScheme.fromSeed(
      seedColor: amber,
      background: paper,
      surface: Colors.white,
    ),
    textTheme: TextTheme(
      displayLarge: serifDisplay(size: 40),
      displayMedium: serifDisplay(size: 28),
      bodyLarge: serifQuote(size: 24),
      bodyMedium: sansBody(),
      labelLarge: caps(size: 12, color: ink),
    ),
  );
}
