import 'package:flutter/material.dart';
import '../theme.dart';

/// Logo "Mali Tonsigui" : trois bandes verticales aux couleurs du drapeau.
class MaliLogo extends StatelessWidget {
  final double size;
  const MaliLogo({super.key, this.size = 28});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: size,
        height: size,
        child: Row(
          children: const [
            Expanded(child: ColoredBox(color: MaliFlagColors.green)),
            Expanded(child: ColoredBox(color: MaliFlagColors.yellow)),
            Expanded(child: ColoredBox(color: MaliFlagColors.red)),
          ],
        ),
      ),
    );
  }
}

/// En-tête commun affiché en haut de chaque écran.
class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          MaliLogo(),
          SizedBox(width: 8),
          Text(
            'Mali Tonsigui',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Carte métrique (ex. "Cagnotte du tour : 40 000 F").
class MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color background;
  final Color labelColor;
  final Color valueColor;

  const MetricCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.background,
    required this.labelColor,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: labelColor),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 12, color: labelColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Petite étiquette arrondie (badge / chip de statut).
class Pill extends StatelessWidget {
  final String text;
  final Color background;
  final Color textColor;

  const Pill({
    super.key,
    required this.text,
    required this.background,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 13, color: textColor),
      ),
    );
  }
}

/// Carte de section blanche avec bordure fine (conteneur principal d'un écran).
class SectionCard extends StatelessWidget {
  final Widget child;
  const SectionCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}
