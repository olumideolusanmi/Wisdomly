import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// Kept for backwards compatibility with existing consumers. The editorial
// design uses a single fixed palette, so this provider now exposes constants
// rather than a rotating gradient.
class ThemeProvider extends ChangeNotifier {
  Color get textColor => AppTheme.ink;
  Color get secondaryTextColor => AppTheme.mutedInk;
  Color get background => AppTheme.paper;

  void nextTheme() {}
}
