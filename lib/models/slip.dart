class Slip {
  int? id;
  String? advice;
  Slip({this.id, this.advice});

  factory Slip.fromJson(Map<String, dynamic> jsonMap) {
    return Slip(
        id: jsonMap['id'] ?? 0,
        advice: jsonMap['advice'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['advice'] = advice;
    return data;
  }
}