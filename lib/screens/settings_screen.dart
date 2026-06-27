import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(ink: ink),
                const SizedBox(height: 8),
                Text(
                  'PREFERENCES',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: muted),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      _SettingsGroup(
                        children: [
                          _SettingsTile(
                            icon: Icons.info_outline_rounded,
                            title: 'About',
                            subtitle:
                                'Quotely delivers short bursts of inspiration, one quote at a time.',
                            ink: ink,
                            muted: muted,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _SettingsGroup(
                        children: [
                          _SettingsTile(
                            icon: Icons.shield_outlined,
                            title: 'Privacy Policy',
                            ink: ink,
                            muted: muted,
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: muted,
                            ),
                            onTap: () => ScaffoldMessenger.of(context)
                                .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Privacy Policy coming soon',
                                    ),
                                  ),
                                ),
                          ),
                          _Divider(muted: muted),
                          _SettingsTile(
                            icon: Icons.mail_outline_rounded,
                            title: 'Contact Us',
                            ink: ink,
                            muted: muted,
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: muted,
                            ),
                            onTap: () => ScaffoldMessenger.of(context)
                                .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Reach us at support@quotely.app',
                                    ),
                                  ),
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Q',
                                style: GoogleFonts.playfairDisplay(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Quotely · v1.0.0',
                              style: GoogleFonts.dmSans(
                                color: muted,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
  const _Header({required this.ink});

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
          'Settings',
          style: Theme.of(
            context,
          ).textTheme.displayMedium?.copyWith(color: ink),
        ),
      ],
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color ink;
  final Color muted;

  const _SettingsTile({
    required this.icon,
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
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: AppTheme.primaryColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.dmSans(
                      color: ink,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: GoogleFonts.dmSans(
                        color: muted,
                        fontSize: 13,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 8), trailing!],
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final Color muted;
  const _Divider({required this.muted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(height: 1, color: muted.withOpacity(0.15)),
    );
  }
}
