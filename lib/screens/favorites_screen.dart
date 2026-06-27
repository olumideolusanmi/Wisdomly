import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/quote.dart';
import '../providers/favorites_provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  void _shareQuote(Quote quote) {
    Share.share('"${quote.text}" — ${quote.author}\n\nShared from Quotely');
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
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
            child: Column(
              children: [
                _ScreenHeader(title: 'Saved', ink: ink),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'YOUR COLLECTION',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: muted,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Consumer<FavoritesProvider>(
                    builder: (context, provider, _) {
                      final favorites = provider.favorites;
                      if (favorites.isEmpty) {
                        return _EmptyState(ink: ink, muted: muted);
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: favorites.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final quote = favorites[index];
                          return Dismissible(
                            key: Key('${quote.text}_${quote.author}'),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              provider.removeFavorite(quote);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Removed from saved'),
                                ),
                              );
                            },
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 24),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                              ),
                            ),
                            child: _SavedQuoteCard(
                              quote: quote,
                              ink: ink,
                              muted: muted,
                              onShare: () => _shareQuote(quote),
                            ),
                          );
                        },
                      );
                    },
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

class _ScreenHeader extends StatelessWidget {
  final String title;
  final Color ink;
  const _ScreenHeader({required this.title, required this.ink});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.white.withOpacity(0.6),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(9),
              child: Icon(Icons.arrow_back_rounded, size: 20, color: ink),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.displayMedium?.copyWith(color: ink),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final Color ink;
  final Color muted;
  const _EmptyState({required this.ink, required this.muted});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.bookmark_outline,
              size: 36,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Nothing saved yet',
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(color: ink, fontSize: 22),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the bookmark on a quote to save it.',
            style: GoogleFonts.dmSans(
              color: muted,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedQuoteCard extends StatelessWidget {
  final Quote quote;
  final Color ink;
  final Color muted;
  final VoidCallback onShare;

  const _SavedQuoteCard({
    required this.quote,
    required this.ink,
    required this.muted,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 12, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 56,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quote.text,
                  style: GoogleFonts.playfairDisplay(
                    color: ink,
                    fontSize: 16,
                    height: 1.45,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  quote.author.toUpperCase(),
                  style: GoogleFonts.dmSans(
                    color: muted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.3,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.ios_share_rounded, color: ink, size: 20),
            onPressed: onShare,
          ),
        ],
      ),
    );
  }
}
