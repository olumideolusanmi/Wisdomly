import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/quote.dart';
import '../services/quote_service.dart';
import '../providers/favorites_provider.dart';
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
  int _pageNumber = 1;

  @override
  void initState() {
    super.initState();
    _currentQuote = QuoteService.getRandomQuote();
  }

  void _nextQuote() {
    setState(() {
      _currentQuote = QuoteService.getRandomQuote();
      _pageNumber++;
    });
  }

  void _shareQuote() {
    Share.share(
      '"${_currentQuote.text}" — ${_currentQuote.author}\n\nShared from Wisdomly',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.paper,
      body: SafeArea(
        child: Column(
          children: [
            _Masthead(
              onFavorites: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              ),
              onSettings: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
            ),
            const _Hairline(),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.06, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: _QuoteFolio(
                  key: ValueKey(_currentQuote.text),
                  quote: _currentQuote,
                  pageNumber: _pageNumber,
                ),
              ),
            ),
            const _Hairline(),
            _ActionRow(
              quote: _currentQuote,
              onShare: _shareQuote,
              onTurn: _nextQuote,
            ),
          ],
        ),
      ),
    );
  }
}

class _Masthead extends StatelessWidget {
  final VoidCallback onFavorites;
  final VoidCallback onSettings;
  const _Masthead({required this.onFavorites, required this.onSettings});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 18, 16, 18),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: AppTheme.amber,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text('WISDOMLY', style: AppTheme.caps(color: AppTheme.ink, size: 13)),
          const SizedBox(width: 8),
          Container(width: 3, height: 3, color: AppTheme.rule),
          const SizedBox(width: 8),
          Text('EST. 2026', style: AppTheme.caps(size: 10)),
          const Spacer(),
          _MastheadIcon(icon: Icons.bookmark_outline, onTap: onFavorites),
          _MastheadIcon(icon: Icons.tune_rounded, onTap: onSettings),
        ],
      ),
    );
  }
}

class _MastheadIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _MastheadIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, size: 22, color: AppTheme.ink),
      splashRadius: 22,
    );
  }
}

class _Hairline extends StatelessWidget {
  const _Hairline();
  @override
  Widget build(BuildContext context) => Container(height: 1, color: AppTheme.rule);
}

class _QuoteFolio extends StatelessWidget {
  final Quote quote;
  final int pageNumber;
  const _QuoteFolio({super.key, required this.quote, required this.pageNumber});

  @override
  Widget build(BuildContext context) {
    final pageLabel = pageNumber.toString().padLeft(2, '0');
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('FOLIO', style: AppTheme.caps(size: 10, color: AppTheme.amber)),
              const SizedBox(width: 10),
              Container(width: 24, height: 1, color: AppTheme.amber),
              const SizedBox(width: 10),
              Text('N°$pageLabel', style: AppTheme.caps(size: 10)),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'On Reflection',
            style: AppTheme.serifDisplay(size: 30),
          ),
          const SizedBox(height: 28),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 2,
                      height: constraints.maxHeight,
                      color: AppTheme.amber,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          quote.text,
                          style: AppTheme.serifQuote(size: 24, color: AppTheme.ink),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(width: 40, height: 1, color: AppTheme.ink),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  quote.author.toUpperCase(),
                  style: AppTheme.caps(size: 11, color: AppTheme.ink, spacing: 3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final Quote quote;
  final VoidCallback onShare;
  final VoidCallback onTurn;
  const _ActionRow({
    required this.quote,
    required this.onShare,
    required this.onTurn,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      child: Row(
        children: [
          _GhostIcon(icon: Icons.ios_share_rounded, onTap: onShare),
          const SizedBox(width: 8),
          Consumer<FavoritesProvider>(
            builder: (context, fav, _) {
              final isFav = fav.isFavorite(quote);
              return _GhostIcon(
                icon: isFav ? Icons.bookmark_rounded : Icons.bookmark_add_outlined,
                filled: isFav,
                onTap: () => fav.toggleFavorite(quote),
              );
            },
          ),
          const Spacer(),
          _TurnButton(onTap: onTurn),
        ],
      ),
    );
  }
}

class _GhostIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;
  const _GhostIcon({
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: filled ? AppTheme.ink : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppTheme.ink.withValues(alpha: filled ? 0 : 0.25)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(
            icon,
            size: 20,
            color: filled ? AppTheme.amber : AppTheme.ink,
          ),
        ),
      ),
    );
  }
}

class _TurnButton extends StatelessWidget {
  final VoidCallback onTap;
  const _TurnButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.ink,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'TURN THE PAGE',
                style: AppTheme.caps(size: 12, color: AppTheme.amber, spacing: 2.6),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_forward_rounded, size: 18, color: AppTheme.amber),
            ],
          ),
        ),
      ),
    );
  }
}
