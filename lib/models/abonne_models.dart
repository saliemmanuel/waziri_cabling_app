import 'dart:convert';

class AbonneModels {
  final String id;
  final String nomAbonne;
  final String prenomAbonne;
  final String cniAbonne;
  final String telephoneAbonne;
  final String descriptionZoneAbonne;
  final String secteurAbonne;
  final String idChefSecteur;
  final String typeAbonnement;
  final String idTypeAbonnement;
  AbonneModels({
    required this.id,
    required this.nomAbonne,
    required this.prenomAbonne,
    required this.cniAbonne,
    required this.telephoneAbonne,
    required this.descriptionZoneAbonne,
    required this.secteurAbonne,
    required this.idChefSecteur,
    required this.typeAbonnement,
    required this.idTypeAbonnement,
  });

  AbonneModels copyWith({
    String? id,
    String? nomAbonne,
    String? prenomAbonne,
    String? cniAbonne,
    String? telephoneAbonne,
    String? descriptionZoneAbonne,
    String? secteurAbonne,
    String? idChefSecteur,
    String? typeAbonnement,
    String? idTypeAbonnement,
  }) {
    return AbonneModels(
      id: id ?? this.id,
      nomAbonne: nomAbonne ?? this.nomAbonne,
      prenomAbonne: prenomAbonne ?? this.prenomAbonne,
      cniAbonne: cniAbonne ?? this.cniAbonne,
      telephoneAbonne: telephoneAbonne ?? this.telephoneAbonne,
      descriptionZoneAbonne:
          descriptionZoneAbonne ?? this.descriptionZoneAbonne,
      secteurAbonne: secteurAbonne ?? this.secteurAbonne,
      idChefSecteur: idChefSecteur ?? this.idChefSecteur,
      typeAbonnement: typeAbonnement ?? this.typeAbonnement,
      idTypeAbonnement: idTypeAbonnement ?? this.idTypeAbonnement,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nomAbonne': nomAbonne,
      'prenomAbonne': prenomAbonne,
      'cniAbonne': cniAbonne,
      'telephoneAbonne': telephoneAbonne,
      'descriptionZoneAbonne': descriptionZoneAbonne,
      'secteurAbonne': secteurAbonne,
      'idChefSecteur': idChefSecteur,
      'typeAbonnement': typeAbonnement,
      'idTypeAbonnement': idTypeAbonnement,
    };
  }

  factory AbonneModels.fromMap(Map<String, dynamic> map) {
    return AbonneModels(
      id: map['id'] as String,
      nomAbonne: map['nomAbonne'] as String,
      prenomAbonne: map['prenomAbonne'] as String,
      cniAbonne: map['cniAbonne'] as String,
      telephoneAbonne: map['telephoneAbonne'] as String,
      descriptionZoneAbonne: map['descriptionZoneAbonne'] as String,
      secteurAbonne: map['secteurAbonne'] as String,
      idChefSecteur: map['idChefSecteur'] as String,
      typeAbonnement: map['typeAbonnement'] as String,
      idTypeAbonnement: map['idTypeAbonnement'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AbonneModels.fromJson(String source) =>
      AbonneModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AbonneModels(id: $id, nomAbonne: $nomAbonne, prenomAbonne: $prenomAbonne, cniAbonne: $cniAbonne, telephoneAbonne: $telephoneAbonne, descriptionZoneAbonne: $descriptionZoneAbonne, secteurAbonne: $secteurAbonne, idChefSecteur: $idChefSecteur, typeAbonnement: $typeAbonnement, idTypeAbonnement: $idTypeAbonnement)';
  }

  @override
  bool operator ==(covariant AbonneModels other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nomAbonne == nomAbonne &&
        other.prenomAbonne == prenomAbonne &&
        other.cniAbonne == cniAbonne &&
        other.telephoneAbonne == telephoneAbonne &&
        other.descriptionZoneAbonne == descriptionZoneAbonne &&
        other.secteurAbonne == secteurAbonne &&
        other.idChefSecteur == idChefSecteur &&
        other.typeAbonnement == typeAbonnement &&
        other.idTypeAbonnement == idTypeAbonnement;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nomAbonne.hashCode ^
        prenomAbonne.hashCode ^
        cniAbonne.hashCode ^
        telephoneAbonne.hashCode ^
        descriptionZoneAbonne.hashCode ^
        secteurAbonne.hashCode ^
        idChefSecteur.hashCode ^
        typeAbonnement.hashCode ^
        idTypeAbonnement.hashCode;
  }
}
