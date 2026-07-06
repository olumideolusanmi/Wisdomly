import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.paper,
      body: SafeArea(
        child: Column(
          children: [
            _Header(),
            Container(height: 1, color: AppTheme.rule),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _SectionLabel('SECTION I · READ'),
                  _Row(
                    marker: '§ 1',
                    title: 'About Wisdomly',
                    subtitle:
                        'Timeless wisdom in short quotes. A quiet corner of your phone.',
                    ink: AppTheme.ink,
                    muted: AppTheme.mutedInk,
                  ),
                  _SectionLabel('SECTION II · LEGAL'),
                  _Row(
                    marker: '§ 2',
                    title: 'Privacy Policy',
                    subtitle: 'Read how we handle your data (spoiler: we don\'t).',
                    ink: AppTheme.ink,
                    muted: AppTheme.mutedInk,
                    trailing: const Icon(Icons.north_east_rounded, size: 16, color: AppTheme.ink),
                    onTap: () async {
                      final uri = Uri.parse('https://wisdomly-tawny.vercel.app/privacy-policy');
                      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Could not open privacy policy')),
                        );
                      }
                    },
                  ),
                  _Row(
                    marker: '§ 3',
                    title: 'Contact',
                    subtitle: 'Reach us at support@wisdomly.app',
                    ink: AppTheme.ink,
                    muted: AppTheme.mutedInk,
                    trailing: const Icon(Icons.mail_outline_rounded, size: 16, color: AppTheme.ink),
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('support@wisdomly.app')),
                    ),
                  ),
                  const SizedBox(height: 40),
                  _Colophon(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
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
              Text('MENU', style: AppTheme.caps(size: 11, color: AppTheme.mutedInk)),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text('Settings', style: AppTheme.serifDisplay(size: 34)),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 10),
      child: Row(
        children: [
          Container(width: 18, height: 1, color: AppTheme.amber),
          const SizedBox(width: 10),
          Text(label, style: AppTheme.caps(size: 10, color: AppTheme.amber)),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String marker;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color ink;
  final Color muted;

  const _Row({
    required this.marker,
    required this.title,
    required this.ink,
    required this.muted,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppTheme.rule)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              child: Text(
                marker,
                style: AppTheme.serifQuote(
                  size: 15,
                  color: AppTheme.amber,
                  weight: FontWeight.w700,
                  style: FontStyle.italic,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.serifDisplay(size: 18, color: ink),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 6),
                    Text(subtitle!, style: AppTheme.sansBody(color: muted, size: 13)),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 10), trailing!],
          ],
        ),
      ),
    );
  }
}

class _Colophon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(width: 40, height: 1, color: AppTheme.amber),
          const SizedBox(height: 12),
          Text('COLOPHON', style: AppTheme.caps(size: 10, color: AppTheme.amber)),
          const SizedBox(height: 10),
          Text(
            'Wisdomly',
            style: AppTheme.serifQuote(
              size: 22,
              color: AppTheme.ink,
              weight: FontWeight.w700,
              style: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          Text('Version 1.0.0', style: AppTheme.caps(size: 10)),
        ],
      ),
    );
  }
}
