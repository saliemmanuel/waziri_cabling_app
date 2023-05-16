import 'dart:convert';

class MessageMoisModel {
  final String id;
  final String designationMessageMois;
  final String corpsMessageMois;
  MessageMoisModel({
    required this.id,
    required this.designationMessageMois,
    required this.corpsMessageMois,
  });

  MessageMoisModel copyWith({
    String? id,
    String? designationMessageMois,
    String? corpsMessageMois,
  }) {
    return MessageMoisModel(
      id: id ?? this.id,
      designationMessageMois:
          designationMessageMois ?? this.designationMessageMois,
      corpsMessageMois: corpsMessageMois ?? this.corpsMessageMois,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'designationMessageMois': designationMessageMois,
      'corpsMessageMois': corpsMessageMois,
    };
  }

  factory MessageMoisModel.fromMap(Map<String, dynamic> map) {
    return MessageMoisModel(
      id: map['id'] as String,
      designationMessageMois: map['designationMessageMois'] as String,
      corpsMessageMois: map['corpsMessageMois'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageMoisModel.fromJson(String source) =>
      MessageMoisModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MessageMoisModel(id: $id, designationMessageMois: $designationMessageMois, corpsMessageMois: $corpsMessageMois)';

  @override
  bool operator ==(covariant MessageMoisModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.designationMessageMois == designationMessageMois &&
        other.corpsMessageMois == corpsMessageMois;
  }

  @override
  int get hashCode =>
      id.hashCode ^ designationMessageMois.hashCode ^ corpsMessageMois.hashCode;
}
