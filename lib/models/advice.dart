import 'package:life_advice/models/slip.dart';

class Advice {
  Slip? slip;
  Advice({this.slip});

  factory Advice.fromJson(Map<String, dynamic> jsonMap) {
    return Advice(
        slip: jsonMap['slip'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slip'] = slip;
    return data;
  }
}