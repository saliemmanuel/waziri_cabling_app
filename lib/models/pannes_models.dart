import 'dart:convert';

class PannesModels {
  final String id;
  final String designation;
  final String description;
  final String detectedDate;
  final String secteur;
  PannesModels({
    required this.id,
    required this.designation,
    required this.description,
    required this.detectedDate,
    required this.secteur,
  });

  PannesModels copyWith({
    String? id,
    String? designation,
    String? description,
    String? detectedDate,
    String? secteur,
  }) {
    return PannesModels(
      id: id ?? this.id,
      designation: designation ?? this.designation,
      description: description ?? this.description,
      detectedDate: detectedDate ?? this.detectedDate,
      secteur: secteur ?? this.secteur,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'designation': designation,
      'description': description,
      'detectedDate': detectedDate,
      'secteur': secteur,
    };
  }

  factory PannesModels.fromMap(Map<String, dynamic> map) {
    return PannesModels(
      id: map['id'] as String,
      designation: map['designation'] as String,
      description: map['description'] as String,
      detectedDate: map['detectedDate'] as String,
      secteur: map['secteur'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PannesModels.fromJson(String source) =>
      PannesModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PannesModels(id: $id, designation: $designation, description: $description, detectedDate: $detectedDate, secteur: $secteur)';
  }

  @override
  bool operator ==(covariant PannesModels other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.designation == designation &&
        other.description == description &&
        other.detectedDate == detectedDate &&
        other.secteur == secteur;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        designation.hashCode ^
        description.hashCode ^
        detectedDate.hashCode ^
        secteur.hashCode;
  }
}
