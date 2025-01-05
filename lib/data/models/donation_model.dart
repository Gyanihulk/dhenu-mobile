// lib/models/donation_model.dart

class Donation {
  final String name;
  final String donor;
  final String amount;
  final String date;
  final String time;
  final String imagePath;
  final String address;
  final String contact;
  final String distance;
  final bool isPast;

  Donation({
    required this.name,
    required this.donor,
    required this.amount,
    required this.date,
    required this.time,
    required this.imagePath,
    required this.address,
    required this.contact,
    required this.distance,
    required this.isPast,
  });
}