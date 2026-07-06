import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/quote.dart';
import '../providers/favorites_provider.dart';
import '../theme/app_theme.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  void _shareQuote(Quote quote) {
    Share.share('"${quote.text}" — ${quote.author}\n\nShared from Wisdomly');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.paper,
      body: SafeArea(
        child: Consumer<FavoritesProvider>(
          builder: (context, provider, _) {
            final favorites = provider.favorites;
            return Column(
              children: [
                _Header(count: favorites.length),
                Container(height: 1, color: AppTheme.rule),
                Expanded(
                  child: favorites.isEmpty
                      ? const _EmptyState()
                      : _FavoritesList(
                          favorites: favorites,
                          onRemove: provider.removeFavorite,
                          onShare: _shareQuote,
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int count;
  const _Header({required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: AppTheme.ink),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 4),
              Text('LIBRARY', style: AppTheme.caps(size: 11, color: AppTheme.mutedInk)),
              const Spacer(),
              Text(
                count.toString().padLeft(2, '0'),
                style: AppTheme.serifDisplay(size: 22, color: AppTheme.amber),
              ),
              const SizedBox(width: 8),
              Text(
                count == 1 ? 'ENTRY' : 'ENTRIES',
                style: AppTheme.caps(size: 10),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text('Collected Wisdom', style: AppTheme.serifDisplay(size: 32)),
          ),
        ],
      ),
    );
  }
}

class _FavoritesList extends StatelessWidget {
  final List<Quote> favorites;
  final void Function(Quote) onRemove;
  final void Function(Quote) onShare;

  const _FavoritesList({
    required this.favorites,
    required this.onRemove,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final quote = favorites[index];
        return Dismissible(
          key: Key('${quote.text}_${quote.author}'),
          direction: DismissDirection.endToStart,
          background: Container(
            color: AppTheme.ink,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 28),
            child: const Icon(Icons.delete_outline, color: AppTheme.amber),
          ),
          onDismissed: (_) {
            onRemove(quote);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Removed from library')),
            );
          },
          child: _EntryRow(
            index: index + 1,
            quote: quote,
            onShare: () => onShare(quote),
          ),
        );
      },
    );
  }
}

class _EntryRow extends StatelessWidget {
  final int index;
  final Quote quote;
  final VoidCallback onShare;
  const _EntryRow({
    required this.index,
    required this.quote,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.rule)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 22, 12, 22),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 44,
            child: Text(
              index.toString().padLeft(2, '0'),
              style: AppTheme.serifDisplay(size: 22, color: AppTheme.amber),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quote.text,
                  style: AppTheme.serifQuote(
                    size: 17,
                    color: AppTheme.ink,
                    weight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(width: 20, height: 1, color: AppTheme.ink),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        quote.author.toUpperCase(),
                        style: AppTheme.caps(size: 10, color: AppTheme.ink),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.ios_share_rounded, color: AppTheme.ink, size: 18),
            onPressed: onShare,
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 40, height: 1, color: AppTheme.amber),
          const SizedBox(height: 20),
          Text('AN EMPTY SHELF', style: AppTheme.caps(size: 11, color: AppTheme.amber)),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Bookmark a quote to begin\nyour collection.',
              textAlign: TextAlign.center,
              style: AppTheme.serifQuote(
                size: 20,
                color: AppTheme.ink,
                style: FontStyle.italic,
                weight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
