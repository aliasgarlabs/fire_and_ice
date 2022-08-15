class FireOrIceModel {
  String emoji = '';
  String date = '';

  FireOrIceModel({required this.emoji, required this.date});

  FireOrIceModel.fromJson(Map<String, dynamic> json) {
    emoji = json['emoji'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emoji'] = this.emoji;
    data['date'] = this.date;
    return data;
  }
}