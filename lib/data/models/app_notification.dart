class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime receivedAt;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.receivedAt,
  });

  // Method to convert AppNotification to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'receivedAt': receivedAt.toIso8601String(),
    };
  }

  // Method to create AppNotification from a Map
  factory AppNotification.fromMap(Map<String, dynamic> map) {
    return AppNotification(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      receivedAt: DateTime.parse(map['receivedAt']),
    );
  }
}
