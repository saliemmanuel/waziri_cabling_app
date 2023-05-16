import 'dart:convert';

class ChargeModels {
  final String id;
  final String designationCharge;
  final String descriptionCharge;
  final String dateCharge;
  final String sommeCharge;
  ChargeModels({
    required this.id,
    required this.designationCharge,
    required this.descriptionCharge,
    required this.dateCharge,
    required this.sommeCharge,
  });

  ChargeModels copyWith({
    String? id,
    String? designationCharge,
    String? descriptionCharge,
    String? dateCharge,
    String? sommeCharge,
  }) {
    return ChargeModels(
      id: id ?? this.id,
      designationCharge: designationCharge ?? this.designationCharge,
      descriptionCharge: descriptionCharge ?? this.descriptionCharge,
      dateCharge: dateCharge ?? this.dateCharge,
      sommeCharge: sommeCharge ?? this.sommeCharge,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'designationCharge': designationCharge,
      'descriptionCharge': descriptionCharge,
      'dateCharge': dateCharge,
      'sommeCharge': sommeCharge,
    };
  }

  factory ChargeModels.fromMap(Map<String, dynamic> map) {
    return ChargeModels(
      id: map['id'] as String,
      designationCharge: map['designationCharge'] as String,
      descriptionCharge: map['descriptionCharge'] as String,
      dateCharge: map['dateCharge'] as String,
      sommeCharge: map['sommeCharge'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChargeModels.fromJson(String source) =>
      ChargeModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChargeModels(id: $id, designationCharge: $designationCharge, descriptionCharge: $descriptionCharge, dateCharge: $dateCharge, sommeCharge: $sommeCharge)';
  }

  @override
  bool operator ==(covariant ChargeModels other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.designationCharge == designationCharge &&
        other.descriptionCharge == descriptionCharge &&
        other.dateCharge == dateCharge &&
        other.sommeCharge == sommeCharge;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        designationCharge.hashCode ^
        descriptionCharge.hashCode ^
        dateCharge.hashCode ^
        sommeCharge.hashCode;
  }
}
