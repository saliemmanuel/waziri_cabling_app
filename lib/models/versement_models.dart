import 'dart:convert';

class VersementModels {
  final String id;
  final String nomSecteur;
  final String nomChefSecteur;
  final String sommeVerser;
  final String dateVersement;
  final String idSecteur;
  final String idChefSecteur;
  VersementModels({
    required this.id,
    required this.nomSecteur,
    required this.nomChefSecteur,
    required this.sommeVerser,
    required this.dateVersement,
    required this.idSecteur,
    required this.idChefSecteur,
  });

  VersementModels copyWith({
    String? id,
    String? nomSecteur,
    String? nomChefSecteur,
    String? sommeVerser,
    String? dateVersement,
    String? idSecteur,
    String? idChefSecteur,
  }) {
    return VersementModels(
      id: id ?? this.id,
      nomSecteur: nomSecteur ?? this.nomSecteur,
      nomChefSecteur: nomChefSecteur ?? this.nomChefSecteur,
      sommeVerser: sommeVerser ?? this.sommeVerser,
      dateVersement: dateVersement ?? this.dateVersement,
      idSecteur: idSecteur ?? this.idSecteur,
      idChefSecteur: idChefSecteur ?? this.idChefSecteur,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nomSecteur': nomSecteur,
      'nomChefSecteur': nomChefSecteur,
      'sommeVerser': sommeVerser,
      'dateVersement': dateVersement,
      'idSecteur': idSecteur,
      'idChefSecteur': idChefSecteur,
    };
  }

  factory VersementModels.fromMap(Map<String, dynamic> map) {
    return VersementModels(
      id: map['id'] as String,
      nomSecteur: map['nomSecteur'] as String,
      nomChefSecteur: map['nomChefSecteur'] as String,
      sommeVerser: map['sommeVerser'] as String,
      dateVersement: map['dateVersement'] as String,
      idSecteur: map['idSecteur'] as String,
      idChefSecteur: map['idChefSecteur'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VersementModels.fromJson(String source) =>
      VersementModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VersementModels(id: $id, nomSecteur: $nomSecteur, nomChefSecteur: $nomChefSecteur, sommeVerser: $sommeVerser, dateVersement: $dateVersement, idSecteur: $idSecteur, idChefSecteur: $idChefSecteur)';
  }

  @override
  bool operator ==(covariant VersementModels other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nomSecteur == nomSecteur &&
        other.nomChefSecteur == nomChefSecteur &&
        other.sommeVerser == sommeVerser &&
        other.dateVersement == dateVersement &&
        other.idSecteur == idSecteur &&
        other.idChefSecteur == idChefSecteur;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nomSecteur.hashCode ^
        nomChefSecteur.hashCode ^
        sommeVerser.hashCode ^
        dateVersement.hashCode ^
        idSecteur.hashCode ^
        idChefSecteur.hashCode;
  }
}
