import 'dart:convert';

class FactureModels {
  final String? idFacture;
  final String? numeroFacture;
  final String? mensualiteFacture;
  final String? montantVerser;
  final String? resteFacture;
  final String? statutFacture;
  final String? impayes;
  final String? idAbonne;
  final String? nomAbonne;
  final String? prenomAbonne;
  final String? cniAbonne;
  final String? telephoneAbonne;
  final String? descriptionZoneAbonne;
  final String? secteurAbonne;
  final String? typeAbonnement;
  final String? montant;
  final String? nombreChaine;
  final String? createAt;
  FactureModels({
    this.idFacture,
    this.numeroFacture,
    this.mensualiteFacture,
    this.montantVerser,
    this.resteFacture,
    this.statutFacture,
    this.impayes,
    this.idAbonne,
    this.nomAbonne,
    this.prenomAbonne,
    this.cniAbonne,
    this.telephoneAbonne,
    this.descriptionZoneAbonne,
    this.secteurAbonne,
    this.typeAbonnement,
    this.montant,
    this.nombreChaine,
    required this.createAt,
  });

  FactureModels copyWith({
    String? idFacture,
    String? numeroFacture,
    String? mensualiteFacture,
    String? montantVerser,
    String? resteFacture,
    String? statutFacture,
    String? impayes,
    String? idAbonne,
    String? nomAbonne,
    String? prenomAbonne,
    String? cniAbonne,
    String? telephoneAbonne,
    String? descriptionZoneAbonne,
    String? secteurAbonne,
    String? typeAbonnement,
    String? montant,
    String? nombreChaine,
    String? createAt,
  }) {
    return FactureModels(
      idFacture: idFacture ?? this.idFacture,
      numeroFacture: numeroFacture ?? this.numeroFacture,
      mensualiteFacture: mensualiteFacture ?? this.mensualiteFacture,
      montantVerser: montantVerser ?? this.montantVerser,
      resteFacture: resteFacture ?? this.resteFacture,
      statutFacture: statutFacture ?? this.statutFacture,
      impayes: impayes ?? this.impayes,
      idAbonne: idAbonne ?? this.idAbonne,
      nomAbonne: nomAbonne ?? this.nomAbonne,
      prenomAbonne: prenomAbonne ?? this.prenomAbonne,
      cniAbonne: cniAbonne ?? this.cniAbonne,
      telephoneAbonne: telephoneAbonne ?? this.telephoneAbonne,
      descriptionZoneAbonne:
          descriptionZoneAbonne ?? this.descriptionZoneAbonne,
      secteurAbonne: secteurAbonne ?? this.secteurAbonne,
      typeAbonnement: typeAbonnement ?? this.typeAbonnement,
      montant: montant ?? this.montant,
      nombreChaine: nombreChaine ?? this.nombreChaine,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_facture': idFacture,
      'numero_facture': numeroFacture,
      'mensualite_facture': mensualiteFacture,
      'montant_verser': montantVerser,
      'reste_facture': resteFacture,
      'statut_facture': statutFacture,
      'impayes': impayes,
      'id_abonne': idAbonne,
      'nom_abonne': nomAbonne,
      'prenom_abonne': prenomAbonne,
      'cni_abonne': cniAbonne,
      'telephone_abonne': telephoneAbonne,
      'description_zone_abonne': descriptionZoneAbonne,
      'secteur_abonne': secteurAbonne,
      'type_abonnement': typeAbonnement,
      'montant': montant,
      'nombre_chaine': nombreChaine,
      'create_fm': createAt,
    };
  }

  factory FactureModels.fromMap(Map<String, dynamic> map) {
    return FactureModels(
      idFacture: map['idFacture'] != null ? map['idFacture'] as String : null,
      numeroFacture:
          map['numeroFacture'] != null ? map['numeroFacture'] as String : null,
      mensualiteFacture: map['mensualiteFacture'] != null
          ? map['mensualiteFacture'] as String
          : null,
      montantVerser:
          map['montantVerser'] != null ? map['montantVerser'] as String : null,
      resteFacture:
          map['resteFacture'] != null ? map['resteFacture'] as String : null,
      statutFacture:
          map['statutFacture'] != null ? map['statutFacture'] as String : null,
      impayes: map['impayes'] != null ? map['impayes'] as String : null,
      idAbonne: map['idAbonne'] != null ? map['idAbonne'] as String : null,
      nomAbonne: map['nomAbonne'] != null ? map['nomAbonne'] as String : null,
      prenomAbonne:
          map['prenomAbonne'] != null ? map['prenomAbonne'] as String : null,
      cniAbonne: map['cniAbonne'] != null ? map['cniAbonne'] as String : null,
      telephoneAbonne: map['telephoneAbonne'] != null
          ? map['telephoneAbonne'] as String
          : null,
      descriptionZoneAbonne: map['descriptionZoneAbonne'] != null
          ? map['descriptionZoneAbonne'] as String
          : null,
      secteurAbonne:
          map['secteurAbonne'] != null ? map['secteurAbonne'] as String : null,
      typeAbonnement: map['typeAbonnement'] != null
          ? map['typeAbonnement'] as String
          : null,
      montant: map['montant'] != null ? map['montant'] as String : null,
      nombreChaine:
          map['nombreChaine'] != null ? map['nombreChaine'] as String : null,
      createAt: map['createAt'] != null ? map['createAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FactureModels.fromJson(String source) =>
      FactureModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FactureModels(idFacture: $idFacture, numeroFacture: $numeroFacture, mensualiteFacture: $mensualiteFacture, montantVerser: $montantVerser, resteFacture: $resteFacture, statutFacture: $statutFacture, impayes: $impayes, idAbonne: $idAbonne, nomAbonne: $nomAbonne, prenomAbonne: $prenomAbonne, cniAbonne: $cniAbonne, telephoneAbonne: $telephoneAbonne, descriptionZoneAbonne: $descriptionZoneAbonne, secteurAbonne: $secteurAbonne, typeAbonnement: $typeAbonnement, montant: $montant, nombreChaine: $nombreChaine, createAt: $createAt)';
  }

  @override
  bool operator ==(covariant FactureModels other) {
    if (identical(this, other)) return true;

    return other.idFacture == idFacture &&
        other.numeroFacture == numeroFacture &&
        other.mensualiteFacture == mensualiteFacture &&
        other.montantVerser == montantVerser &&
        other.resteFacture == resteFacture &&
        other.statutFacture == statutFacture &&
        other.impayes == impayes &&
        other.idAbonne == idAbonne &&
        other.nomAbonne == nomAbonne &&
        other.prenomAbonne == prenomAbonne &&
        other.cniAbonne == cniAbonne &&
        other.telephoneAbonne == telephoneAbonne &&
        other.descriptionZoneAbonne == descriptionZoneAbonne &&
        other.secteurAbonne == secteurAbonne &&
        other.typeAbonnement == typeAbonnement &&
        other.montant == montant &&
        other.nombreChaine == nombreChaine &&
        other.createAt == createAt;
  }

  @override
  int get hashCode {
    return idFacture.hashCode ^
        numeroFacture.hashCode ^
        mensualiteFacture.hashCode ^
        montantVerser.hashCode ^
        resteFacture.hashCode ^
        statutFacture.hashCode ^
        impayes.hashCode ^
        idAbonne.hashCode ^
        nomAbonne.hashCode ^
        prenomAbonne.hashCode ^
        cniAbonne.hashCode ^
        telephoneAbonne.hashCode ^
        descriptionZoneAbonne.hashCode ^
        secteurAbonne.hashCode ^
        typeAbonnement.hashCode ^
        montant.hashCode ^
        nombreChaine.hashCode ^
        createAt.hashCode;
  }
}
