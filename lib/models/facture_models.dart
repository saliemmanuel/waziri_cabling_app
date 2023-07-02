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
    required this.telephoneAbonne,
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
      idFacture: map['id_facture'].toString(),
      numeroFacture: map['numero_facture'].toString(),
      mensualiteFacture: map['mensualite_facture'].toString(),
      montantVerser: map['montant_verser'].toString(),
      resteFacture: map['reste_facture'].toString(),
      statutFacture: map['statut_facture'] != null
          ? map['statut_facture'] as String
          : null,
      impayes: map['impayes'].toString(),
      idAbonne: map['id_abonne'].toString(),
      nomAbonne: map['nom_abonne'] != null ? map['nom_abonne'] as String : null,
      prenomAbonne:
          map['prenom_abonne'] != null ? map['prenom_abonne'] as String : null,
      cniAbonne: map['cni_abonne'].toString(),
      telephoneAbonne: map['telephone_abonne'] != null
          ? map['telephone_abonne'] as String
          : null,
      descriptionZoneAbonne: map['description_zone_abonne'] != null
          ? map['description_zone_abonne'] as String
          : null,
      secteurAbonne: map['secteur_abonne'] != null
          ? map['secteur_abonne'] as String
          : null,
      typeAbonnement: map['type_abonnement'] != null
          ? map['type_abonnement'] as String
          : null,
      montant: map['montant'].toString(),
      nombreChaine: map['nombre_chaine'].toString(),
      createAt: map['create_fm'].toString(),
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
