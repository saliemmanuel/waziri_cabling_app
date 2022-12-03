import 'dart:convert';

class Secteur {
  final int id;
  final String designationSecteur;
  final String descriptionSecteur;
  Secteur({
    required this.id,
    required this.designationSecteur,
    required this.descriptionSecteur,
  });

  Secteur copyWith({
    int? id,
    String? designationSecteur,
    String? descriptionSecteur,
  }) {
    return Secteur(
      id: id ?? this.id,
      designationSecteur: designationSecteur ?? this.designationSecteur,
      descriptionSecteur: descriptionSecteur ?? this.descriptionSecteur,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'designationSecteur': designationSecteur,
      'descriptionSecteur': descriptionSecteur,
    };
  }

  factory Secteur.fromMap(Map<String, dynamic> map) {
    return Secteur(
      id: map['id'] as int,
      designationSecteur: map['designationSecteur'] as String,
      descriptionSecteur: map['descriptionSecteur'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Secteur.fromJson(String source) =>
      Secteur.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Secteur(id: $id, designationSecteur: $designationSecteur, descriptionSecteur: $descriptionSecteur)';

  @override
  bool operator ==(covariant Secteur other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.designationSecteur == designationSecteur &&
        other.descriptionSecteur == descriptionSecteur;
  }

  @override
  int get hashCode =>
      id.hashCode ^ designationSecteur.hashCode ^ descriptionSecteur.hashCode;
}
