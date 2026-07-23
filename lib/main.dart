import 'package:flutter/material.dart';
import 'app_state.dart';
import 'theme.dart';
import 'widgets/common.dart';
import 'screens/dashboard_screen.dart';
import 'screens/cycle_screen.dart';
import 'screens/add_member_screen.dart';

void main() {
  runApp(const MaliTonsiguiApp());
}

class MaliTonsiguiApp extends StatelessWidget {
  const MaliTonsiguiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mali Tonsigui',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomeShell(),
    );
  }
}

/// Coquille principale : en-tête + onglets + contenu de l'écran actif.
///
/// Toutes les données sont partagées via une seule instance de
/// [TontineAppState], reconstruite avec un [AnimatedBuilder] à chaque
/// changement (paiement marqué, gagnant enregistré, membre ajouté).
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  final TontineAppState appState = TontineAppState();
  int selectedIndex = 0;

  static const tabs = ['Tableau', 'Cycle', 'Membre'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: appState,
          builder: (context, _) {
            return Column(
              children: [
                const AppHeader(),
                _TabBar(
                  labels: tabs,
                  selectedIndex: selectedIndex,
                  onSelected: (i) => setState(() => selectedIndex = i),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: IndexedStack(
                    index: selectedIndex,
                    children: [
                      DashboardScreen(
                        appState: appState,
                        onVoirCycle: () => setState(() => selectedIndex = 1),
                      ),
                      CycleScreen(appState: appState),
                      AddMemberScreen(appState: appState),
                    ],
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

class _TabBar extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _TabBar({
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.pageBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            for (int i = 0; i < labels.length; i++)
              Expanded(
                child: GestureDetector(
                  onTap: () => onSelected(i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedIndex == i
                          ? AppColors.cardBackground
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      labels[i],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: selectedIndex == i
                            ? FontWeight.w600
                            : FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
