/// Model metadata catatan. Isi catatan dipisah untuk keamanan.
class Note {
  String id;
  String title;
  DateTime date;

  Note({required this.id, required this.title, required this.date});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date.toIso8601String(),
      };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'],
        title: json['title'],
        date: DateTime.parse(json['date']),
      );
}