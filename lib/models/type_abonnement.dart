import 'dart:convert';

class TypeAbonnement {
  final int id;
  final String designationTypeAbonnement;
  final String montant;
  final String nombreChaine;
  final String idInitiateur;
  TypeAbonnement({
    required this.id,
    required this.designationTypeAbonnement,
    required this.montant,
    required this.nombreChaine,
    required this.idInitiateur,
  });

  TypeAbonnement copyWith({
    int? id,
    String? designationTypeAbonnement,
    String? montant,
    String? nombreChaine,
    String? idInitiateur,
  }) {
    return TypeAbonnement(
      id: id ?? this.id,
      designationTypeAbonnement:
          designationTypeAbonnement ?? this.designationTypeAbonnement,
      montant: montant ?? this.montant,
      nombreChaine: nombreChaine ?? this.nombreChaine,
      idInitiateur: idInitiateur ?? this.idInitiateur,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'designationTypeAbonnement': designationTypeAbonnement,
      'montant': montant,
      'nombreChaine': nombreChaine,
      'idInitiateur': idInitiateur,
    };
  }

  factory TypeAbonnement.fromMap(Map<String, dynamic> map) {
    return TypeAbonnement(
      id: map['id'] as int,
      designationTypeAbonnement: map['designationTypeAbonnement'] as String,
      montant: map['montant'] as String,
      nombreChaine: map['nombreChaine'] as String,
      idInitiateur: map['idInitiateur'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeAbonnement.fromJson(String source) =>
      TypeAbonnement.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TypeAbonnement(id: $id, designationTypeAbonnement: $designationTypeAbonnement, montant: $montant, nombreChaine: $nombreChaine, idInitiateur: $idInitiateur)';
  }

  @override
  bool operator ==(covariant TypeAbonnement other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.designationTypeAbonnement == designationTypeAbonnement &&
        other.montant == montant &&
        other.nombreChaine == nombreChaine &&
        other.idInitiateur == idInitiateur;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        designationTypeAbonnement.hashCode ^
        montant.hashCode ^
        nombreChaine.hashCode ^
        idInitiateur.hashCode;
  }
}
