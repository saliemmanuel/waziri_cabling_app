import 'dart:convert';

class MaterielModels {
  final int id;
  final String designationMateriel;
  final String prixMateriel;
  final String? imageMateriel;
  final String dateAchatMateriel;
  final String? factureMateriel;
  final String createAt;
  MaterielModels({
    required this.id,
    required this.designationMateriel,
    required this.prixMateriel,
    this.imageMateriel,
    required this.dateAchatMateriel,
    this.factureMateriel,
    required this.createAt,
  });

  MaterielModels copyWith({
    int? id,
    String? designationMateriel,
    String? prixMateriel,
    String? imageMateriel,
    String? dateAchatMateriel,
    String? factureMateriel,
    String? createAt,
  }) {
    return MaterielModels(
      id: id ?? this.id,
      designationMateriel: designationMateriel ?? this.designationMateriel,
      prixMateriel: prixMateriel ?? this.prixMateriel,
      imageMateriel: imageMateriel ?? this.imageMateriel,
      dateAchatMateriel: dateAchatMateriel ?? this.dateAchatMateriel,
      factureMateriel: factureMateriel ?? this.factureMateriel,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'designationMateriel': designationMateriel,
      'prixMateriel': prixMateriel,
      'imageMateriel': imageMateriel,
      'dateAchatMateriel': dateAchatMateriel,
      'factureMateriel': factureMateriel,
      'createAt': createAt,
    };
  }

  factory MaterielModels.fromMap(Map<String, dynamic> map) {
    return MaterielModels(
      id: map['id'] as int,
      designationMateriel: map['designationMateriel'] as String,
      prixMateriel: map['prixMateriel'] as String,
      imageMateriel: map['imageMateriel'] as String,
      dateAchatMateriel: map['dateAchatMateriel'] as String,
      factureMateriel: map['factureMateriel'] as String,
      createAt: map['createAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MaterielModels.fromJson(String source) =>
      MaterielModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MaterielModels(id: $id, designationMateriel: $designationMateriel, prixMateriel: $prixMateriel, imageMateriel: $imageMateriel, dateAchatMateriel: $dateAchatMateriel, factureMateriel: $factureMateriel, createAt: $createAt)';
  }

  @override
  bool operator ==(covariant MaterielModels other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.designationMateriel == designationMateriel &&
        other.prixMateriel == prixMateriel &&
        other.imageMateriel == imageMateriel &&
        other.dateAchatMateriel == dateAchatMateriel &&
        other.factureMateriel == factureMateriel &&
        other.createAt == createAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        designationMateriel.hashCode ^
        prixMateriel.hashCode ^
        imageMateriel.hashCode ^
        dateAchatMateriel.hashCode ^
        factureMateriel.hashCode ^
        createAt.hashCode;
  }
}
