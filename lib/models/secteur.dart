import 'dart:convert';

class Secteur {
  final String id;
  final String designationSecteur;
  final String descriptionSecteur;
  final String nomChefSecteur;
  final String idChefSecteur;
  Secteur({
    required this.id,
    required this.designationSecteur,
    required this.descriptionSecteur,
    required this.nomChefSecteur,
    required this.idChefSecteur,
  });

  Secteur copyWith({
    String? id,
    String? designationSecteur,
    String? descriptionSecteur,
    String? nomChefSecteur,
    String? idChefSecteur,
  }) {
    return Secteur(
      id: id ?? this.id,
      designationSecteur: designationSecteur ?? this.designationSecteur,
      descriptionSecteur: descriptionSecteur ?? this.descriptionSecteur,
      nomChefSecteur: nomChefSecteur ?? this.nomChefSecteur,
      idChefSecteur: idChefSecteur ?? this.idChefSecteur,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'designationSecteur': designationSecteur,
      'descriptionSecteur': descriptionSecteur,
      'nomChefSecteur': nomChefSecteur,
      'idChefSecteur': idChefSecteur,
    };
  }

  factory Secteur.fromMap(Map<String, dynamic> map) {
    return Secteur(
      id: map['id'] as String,
      designationSecteur: map['designationSecteur'] as String,
      descriptionSecteur: map['descriptionSecteur'] as String,
      nomChefSecteur: map['nomChefSecteur'] as String,
      idChefSecteur: map['idChefSecteur'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Secteur.fromJson(String source) =>
      Secteur.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Secteur(id: $id, designationSecteur: $designationSecteur, descriptionSecteur: $descriptionSecteur, nomChefSecteur: $nomChefSecteur, idChefSecteur: $idChefSecteur)';
  }

  @override
  bool operator ==(covariant Secteur other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.designationSecteur == designationSecteur &&
        other.descriptionSecteur == descriptionSecteur &&
        other.nomChefSecteur == nomChefSecteur &&
        other.idChefSecteur == idChefSecteur;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        designationSecteur.hashCode ^
        descriptionSecteur.hashCode ^
        nomChefSecteur.hashCode ^
        idChefSecteur.hashCode;
  }
}
