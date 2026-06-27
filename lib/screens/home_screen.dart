import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/quote.dart';
import '../services/quote_service.dart';
import '../providers/favorites_provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Quote _currentQuote;

  @override
  void initState() {
    super.initState();
    _currentQuote = QuoteService.getRandomQuote();
  }

  void _generateNewQuote() {
    setState(() {
      _currentQuote = QuoteService.getRandomQuote();
    });
  }

  void _shareQuote() {
    Share.share(
      '"${_currentQuote.text}" — ${_currentQuote.author}\n\nShared from Quotely',
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final ink = themeProvider.textColor;
    final muted = themeProvider.secondaryTextColor;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: themeProvider.currentGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              children: [
                _Header(
                  ink: ink,
                  onPalette: themeProvider.nextTheme,
                  onFavorites: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FavoritesScreen(),
                    ),
                  ),
                  onSettings: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'QUOTE OF THE MOMENT',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: muted,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 450),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.04),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    ),
                    child: _QuoteCard(
                      key: ValueKey(_currentQuote.text),
                      quote: _currentQuote,
                      ink: ink,
                      muted: muted,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _ActionBar(
                  quote: _currentQuote,
                  ink: ink,
                  onShare: _shareQuote,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _generateNewQuote,
                    icon: const Icon(Icons.auto_awesome, size: 20),
                    label: const Text('Surprise Me'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Color ink;
  final VoidCallback onPalette;
  final VoidCallback onFavorites;
  final VoidCallback onSettings;

  const _Header({
    required this.ink,
    required this.onPalette,
    required this.onFavorites,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            'Q',
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Quotely',
          style: Theme.of(
            context,
          ).textTheme.displayMedium?.copyWith(color: ink),
        ),
        const Spacer(),
        _CircleIcon(icon: Icons.palette_outlined, onTap: onPalette, ink: ink),
        const SizedBox(width: 8),
        _CircleIcon(
          icon: Icons.bookmark_border,
          onTap: onFavorites,
          ink: ink,
        ),
        const SizedBox(width: 8),
        _CircleIcon(
          icon: Icons.tune_rounded,
          onTap: onSettings,
          ink: ink,
        ),
      ],
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color ink;
  const _CircleIcon({
    required this.icon,
    required this.onTap,
    required this.ink,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.6),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Icon(icon, size: 20, color: ink),
        ),
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  final Quote quote;
  final Color ink;
  final Color muted;

  const _QuoteCard({
    super.key,
    required this.quote,
    required this.ink,
    required this.muted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '“',
            style: GoogleFonts.playfairDisplay(
              fontSize: 72,
              height: 0.8,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                quote.text,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: ink),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: muted.withOpacity(0.2)),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppTheme.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  quote.author.toUpperCase(),
                  style: GoogleFonts.dmSans(
                    color: muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  final Quote quote;
  final Color ink;
  final VoidCallback onShare;

  const _ActionBar({
    required this.quote,
    required this.ink,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _PillAction(
          icon: Icons.ios_share_rounded,
          label: 'Share',
          ink: ink,
          onTap: onShare,
        ),
        const SizedBox(width: 12),
        Consumer<FavoritesProvider>(
          builder: (context, fav, _) {
            final isFav = fav.isFavorite(quote);
            return _PillAction(
              icon: isFav ? Icons.bookmark_rounded : Icons.bookmark_outline,
              label: isFav ? 'Saved' : 'Save',
              ink: ink,
              highlight: isFav,
              onTap: () => fav.toggleFavorite(quote),
            );
          },
        ),
      ],
    );
  }
}

class _PillAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color ink;
  final bool highlight;
  final VoidCallback onTap;

  const _PillAction({
    required this.icon,
    required this.label,
    required this.ink,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final fg = highlight ? Colors.white : ink;
    final bg = highlight ? AppTheme.primaryColor : Colors.white;
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(40),
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20, color: fg),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.dmSans(
                  color: fg,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
