import 'package:flutter/foundation.dart';
import 'models.dart';

/// État partagé de la tontine, en mémoire (pas de persistance dans ce MVP).
///
/// Les écrans écoutent cet objet via [AnimatedBuilder] pour se
/// reconstruire quand une donnée change (paiement marqué, gagnant
/// enregistré, membre ajouté...).
class TontineAppState extends ChangeNotifier {
  final String tontineName = 'Tontine Sougou';
  final int montantParCotisation = 5000; // FCFA
  final String frequence = 'semaine';
  final String prochainTirage = 'Ven. 26';
  int cycleActuel = 3;

  final List<Member> members = [
    Member(id: '1', name: 'Bakary Koné', phone: '+223 76 00 00 01',
        hasWon: true, invitationConfirmed: true, paidThisCycle: true),
    Member(id: '2', name: 'Awa Diallo', phone: '+223 76 00 00 02',
        hasWon: true, invitationConfirmed: true, paidThisCycle: true),
    Member(id: '3', name: 'Kadidia Diarra', phone: '+223 76 00 00 03',
        invitationConfirmed: true, paidThisCycle: true),
    Member(id: '4', name: 'Fousseyni Sissoko', phone: '+223 76 00 00 04',
        invitationConfirmed: false, paidThisCycle: false),
    Member(id: '5', name: 'Oumar Touré', phone: '+223 76 00 00 05',
        invitationConfirmed: true, paidThisCycle: false),
    Member(id: '6', name: 'Salimata Coulibaly', phone: '+223 76 00 00 06',
        invitationConfirmed: true, paidThisCycle: true),
    Member(id: '7', name: 'Modibo Keïta', phone: '+223 76 00 00 07',
        invitationConfirmed: true, paidThisCycle: false),
    Member(id: '8', name: 'Aminata Traoré', phone: '+223 76 00 00 08',
        invitationConfirmed: true, paidThisCycle: false),
  ];

  int get totalMembres => members.length;

  int get membresAyantPaye =>
      members.where((m) => m.paidThisCycle).length;

  int get cagnotteDuTour => montantParCotisation * totalMembres;

  List<Member> get membresEligiblesAuTirage =>
      members.where((m) => !m.hasWon).toList();

  /// Enregistre le gagnant du tirage (fait en réunion physique) pour le
  /// cycle en cours.
  void enregistrerGagnant(String memberId) {
    final member = members.firstWhere((m) => m.id == memberId);
    member.hasWon = true;
    notifyListeners();
  }

  /// Marque un membre comme ayant payé sa cotisation pour le cycle en cours.
  void marquerPaye(String memberId) {
    final member = members.firstWhere((m) => m.id == memberId);
    member.paidThisCycle = true;
    notifyListeners();
  }

  /// Ajoute un nouveau membre invité par téléphone.
  void ajouterMembre(String name, String phone) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    members.add(Member(id: id, name: name, phone: phone));
    notifyListeners();
  }
}
