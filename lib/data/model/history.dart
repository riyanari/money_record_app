// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'dart:convert';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
  final String? idHistory;
  final String? idUser;
  final String? type;
  final String? date;
  final String? total;
  final String? details;
  final String? createdAt;
  final String? updatedAt;

  History({
    required this.idHistory,
    required this.idUser,
    required this.type,
    required this.date,
    required this.total,
    required this.details,
    required this.createdAt,
    required this.updatedAt,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    idHistory: json["id_history"],
    idUser: json["id_user"],
    type: json["type"],
    date: json["date"],
    total: json["total"],
    details: json["details"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id_history": idHistory,
    "id_user": idUser,
    "type": type,
    "date": date,
    "total": total,
    "details": details,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
