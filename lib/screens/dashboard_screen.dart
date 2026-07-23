import 'package:flutter/material.dart';
import '../app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

class DashboardScreen extends StatelessWidget {
  final TontineAppState appState;
  final VoidCallback onVoirCycle;

  const DashboardScreen({
    super.key,
    required this.appState,
    required this.onVoirCycle,
  });

  @override
  Widget build(BuildContext context) {
    final progression =
        appState.membresAyantPaye / appState.totalMembres;
    final avatarsAffiches = appState.members.take(3).toList();
    final reste = appState.totalMembres - avatarsAffiches.length;

    return SingleChildScrollView(
      child: SectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TONTINE ACTIVE',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 0.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        appState.tontineName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                Pill(
                  text: 'Cycle ${appState.cycleActuel} / ${appState.totalMembres}',
                  background: AppColors.goldBg,
                  textColor: AppColors.goldText,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.people_outline,
                    size: 15, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  '${appState.totalMembres} membres · '
                  '${appState.montantParCotisation} FCFA par ${appState.frequence}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: MetricCard(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'Cagnotte du tour',
                    value: '${appState.cagnotteDuTour} F',
                    background: AppColors.goldBg,
                    labelColor: AppColors.amberText,
                    valueColor: AppColors.goldDark,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MetricCard(
                    icon: Icons.event_outlined,
                    label: 'Prochain tirage',
                    value: appState.prochainTirage,
                    background: AppColors.coralBg,
                    labelColor: AppColors.coralText,
                    valueColor: AppColors.coralDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Paiements du cycle ${appState.cycleActuel}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '${appState.membresAyantPaye} / ${appState.totalMembres}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: progression,
                minHeight: 6,
                backgroundColor: AppColors.pageBackground,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.greenBar),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 26,
                  child: Stack(
                    children: [
                      for (int i = 0; i < avatarsAffiches.length; i++)
                        Positioned(
                          left: i * 18.0,
                          child: _Avatar(initials: avatarsAffiches[i].initials),
                        ),
                      if (reste > 0)
                        Positioned(
                          left: avatarsAffiches.length * 18.0,
                          child: _Avatar(initials: '+$reste', muted: true),
                        ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: onVoirCycle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.goldStrong,
                    foregroundColor: AppColors.goldBg,
                    elevation: 0,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  label: const Text('Voir le cycle',
                      style: TextStyle(fontSize: 13)),
                  icon: const Icon(Icons.arrow_forward, size: 14),
                  iconAlignment: IconAlignment.end,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String initials;
  final bool muted;
  const _Avatar({required this.initials, this.muted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: muted ? AppColors.pageBackground : const Color(0xFFEF9F27),
        border: Border.all(color: AppColors.cardBackground, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: muted ? AppColors.textSecondary : AppColors.goldDark,
        ),
      ),
    );
  }
}
