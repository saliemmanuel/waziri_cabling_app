import 'dart:convert';

class Users {
  final int? id;
  final String? nomUtilisateur;
  final String? email;
  final String? prenomUtilisateur;
  final String? telephoneUtilisateur;
  final String? roleUtilisateur;
  final String? zoneUtilisateur;
  final int? idUtilisateurInitiateur;
  Users({
    this.id,
    this.nomUtilisateur,
    this.email,
    this.prenomUtilisateur,
    this.telephoneUtilisateur,
    this.roleUtilisateur,
    this.zoneUtilisateur,
    this.idUtilisateurInitiateur,
  });

  Users copyWith({
    int? id,
    String? nomUtilisateur,
    String? email,
    String? prenomUtilisateur,
    String? telephoneUtilisateur,
    String? roleUtilisateur,
    String? zoneUtilisateur,
    int? idUtilisateurInitiateur,
  }) {
    return Users(
      id: id ?? this.id,
      nomUtilisateur: nomUtilisateur ?? this.nomUtilisateur,
      email: email ?? this.email,
      prenomUtilisateur: prenomUtilisateur ?? this.prenomUtilisateur,
      telephoneUtilisateur: telephoneUtilisateur ?? this.telephoneUtilisateur,
      roleUtilisateur: roleUtilisateur ?? this.roleUtilisateur,
      zoneUtilisateur: zoneUtilisateur ?? this.zoneUtilisateur,
      idUtilisateurInitiateur:
          idUtilisateurInitiateur ?? this.idUtilisateurInitiateur,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nomUtilisateur': nomUtilisateur,
      'email': email,
      'prenomUtilisateur': prenomUtilisateur,
      'telephoneUtilisateur': telephoneUtilisateur,
      'roleUtilisateur': roleUtilisateur,
      'zoneUtilisateur': zoneUtilisateur,
      'idUtilisateurInitiateur': idUtilisateurInitiateur,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] != null ? map['id'] as int : null,
      nomUtilisateur: map['nomUtilisateur'] != null
          ? map['nomUtilisateur'] as String
          : null,
      email: map['email'] != null ? map['email'] as String : null,
      prenomUtilisateur: map['prenomUtilisateur'] != null
          ? map['prenomUtilisateur'] as String
          : null,
      telephoneUtilisateur: map['telephoneUtilisateur'] != null
          ? map['telephoneUtilisateur'] as String
          : null,
      roleUtilisateur: map['roleUtilisateur'] != null
          ? map['roleUtilisateur'] as String
          : null,
      zoneUtilisateur: map['zoneUtilisateur'] != null
          ? map['zoneUtilisateur'] as String
          : null,
      idUtilisateurInitiateur: map['idUtilisateurInitiateur'] != null
          ? map['idUtilisateurInitiateur'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) =>
      Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Users(id: $id, nomUtilisateur: $nomUtilisateur, email: $email, prenomUtilisateur: $prenomUtilisateur, telephoneUtilisateur: $telephoneUtilisateur, roleUtilisateur: $roleUtilisateur, zoneUtilisateur: $zoneUtilisateur, idUtilisateurInitiateur: $idUtilisateurInitiateur)';
  }

  @override
  bool operator ==(covariant Users other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nomUtilisateur == nomUtilisateur &&
        other.email == email &&
        other.prenomUtilisateur == prenomUtilisateur &&
        other.telephoneUtilisateur == telephoneUtilisateur &&
        other.roleUtilisateur == roleUtilisateur &&
        other.zoneUtilisateur == zoneUtilisateur &&
        other.idUtilisateurInitiateur == idUtilisateurInitiateur;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nomUtilisateur.hashCode ^
        email.hashCode ^
        prenomUtilisateur.hashCode ^
        telephoneUtilisateur.hashCode ^
        roleUtilisateur.hashCode ^
        zoneUtilisateur.hashCode ^
        idUtilisateurInitiateur.hashCode;
  }
}
