class User {
  final int id;
  final String nom;
  final String prenom;
  final String nni;
  final dynamic telephone;

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.nni,
    required this.telephone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      nni: json['nni'],
      telephone: json['telephone'],
    );
  }
}
