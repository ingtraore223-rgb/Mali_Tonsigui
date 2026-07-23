import 'package:flutter/material.dart';
import '../app_state.dart';
import '../models.dart';
import '../theme.dart';
import '../widgets/common.dart';

class CycleScreen extends StatefulWidget {
  final TontineAppState appState;
  const CycleScreen({super.key, required this.appState});

  @override
  State<CycleScreen> createState() => _CycleScreenState();
}

class _CycleScreenState extends State<CycleScreen> {
  Member? gagnantSelectionne;

  @override
  Widget build(BuildContext context) {
    final appState = widget.appState;
    final eligibles = appState.membresEligiblesAuTirage;

    return SingleChildScrollView(
      child: SectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cycle ${appState.cycleActuel} · éligibles au tirage',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${eligibles.length} membres n\'ont pas encore gagné',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final m in eligibles)
                  Pill(
                    text: m.name.split(' ').first,
                    background: AppColors.goldBg,
                    textColor: AppColors.goldText,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.coralBg,
                border: Border.all(color: AppColors.coralBorder),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.emoji_events_outlined,
                          size: 15, color: AppColors.coralText),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Tirage fait en réunion, saisir le gagnant',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.coralText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<Member>(
                    initialValue: gagnantSelectionne,
                    hint: const Text('Choisir le gagnant tiré au sort',
                        style: TextStyle(fontSize: 13)),
                    isExpanded: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.cardBackground,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                    ),
                    items: [
                      for (final m in eligibles)
                        DropdownMenuItem(value: m, child: Text(m.name)),
                    ],
                    onChanged: (m) => setState(() => gagnantSelectionne = m),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: gagnantSelectionne == null
                          ? null
                          : () {
                              final gagnant = gagnantSelectionne!;
                              appState.enregistrerGagnant(gagnant.id);
                              setState(() => gagnantSelectionne = null);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('${gagnant.name} a été enregistré comme gagnant'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.coralStrong,
                        foregroundColor: AppColors.coralBg,
                        disabledBackgroundColor:
                            AppColors.coralStrong.withValues(alpha: 0.4),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Enregistrer le gagnant'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Paiements de ce cycle',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            for (final m in appState.members)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(m.name, style: const TextStyle(fontSize: 13)),
                    m.paidThisCycle
                        ? const _StatutPaiement(
                            icon: Icons.check_circle_outline,
                            label: 'payé',
                            color: AppColors.greenText,
                          )
                        : GestureDetector(
                            onTap: () => appState.marquerPaye(m.id),
                            child: const _StatutPaiement(
                              icon: Icons.access_time,
                              label: 'en attente',
                              color: AppColors.amberText,
                            ),
                          ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatutPaiement extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatutPaiement({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 13, color: color)),
      ],
    );
  }
}
