/// Un membre de la tontine.
class Member {
  final String id;
  String name;
  String phone;
  bool hasWon; // a déjà remporté un tirage
  bool invitationConfirmed; // a confirmé l'invitation (écran "Membre")
  bool paidThisCycle; // a payé sa cotisation pour le cycle en cours

  Member({
    required this.id,
    required this.name,
    required this.phone,
    this.hasWon = false,
    this.invitationConfirmed = false,
    this.paidThisCycle = false,
  });

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}
