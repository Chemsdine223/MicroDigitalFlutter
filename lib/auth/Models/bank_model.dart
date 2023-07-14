class Bank {
  int? id;
  String? nom;
  Bank({
    this.id,
    this.nom,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(id: json['id'], nom: json['nom']);
  }

  @override
  String toString() => 'Bank(id: $id, nom: $nom)';
}
