import 'package:flutter/material.dart';
import '../app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

class AddMemberScreen extends StatefulWidget {
  final TontineAppState appState;
  const AddMemberScreen({super.key, required this.appState});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _inviter() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Entrez un nom et un numéro de téléphone')),
      );
      return;
    }
    widget.appState.ajouterMembre(name, phone);
    _nameController.clear();
    _phoneController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invitation envoyée par SMS')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = widget.appState;

    return SingleChildScrollView(
      child: SectionCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ajouter un membre',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 14),
            const Text('Nom',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 4),
            TextField(
              controller: _nameController,
              decoration: _fieldDecoration('Aminata Traoré'),
            ),
            const SizedBox(height: 12),
            const Text('Numéro de téléphone',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 4),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: _fieldDecoration('+223 76 00 00 00'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _inviter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldStrong,
                  foregroundColor: AppColors.goldBg,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Inviter par SMS'),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Membres invités',
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
                    Text(
                      m.invitationConfirmed ? 'confirmé' : 'invitation envoyée',
                      style: TextStyle(
                        fontSize: 13,
                        color: m.invitationConfirmed
                            ? AppColors.greenText
                            : AppColors.amberText,
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

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.pageBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: AppColors.border),
      ),
    );
  }
}
