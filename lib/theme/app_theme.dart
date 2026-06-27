import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Quotely palette — warm coral on cream with deep ink
  static const Color primaryColor = Color(0xFFE56B6F); // Coral
  static const Color accentColor = Color(0xFFEAAC8B); // Warm sand
  static const Color backgroundColor = Color(0xFFFDF6EC); // Cream
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF2A2D34); // Deep charcoal
  static const Color secondaryTextColor = Color(0xFF6B6F76); // Muted

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        background: backgroundColor,
        surface: cardColor,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.playfairDisplay(
          color: textColor,
          fontSize: 36,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          color: textColor,
          fontSize: 26,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        bodyLarge: GoogleFonts.playfairDisplay(
          color: textColor,
          fontSize: 24,
          height: 1.55,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
        bodyMedium: GoogleFonts.dmSans(
          color: secondaryTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.2,
        ),
        labelLarge: GoogleFonts.dmSans(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: textColor),
      ),
    );
  }
}
