class TripModel {
  final int id;
  final String title;
  final String? description;
  final DateTime date;
  final double? price;
  final String? image;
  final String? videoLink;
  final String? paymentLink;
  final String? category;

  TripModel({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    this.price,
    this.image,
    this.videoLink,
    this.paymentLink,
    this.category,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] is int ? json['id'] : (int.tryParse(json['id'].toString()) ?? (throw FormatException('Invalid id'))),
      title: json['title']?.toString() ?? (throw FormatException('Missing title')),
      description: json['description']?.toString(),
      date: DateTime.tryParse(json['date']?.toString() ?? '') ?? (throw FormatException('Invalid date')),
      price: json['price'] != null ? double.tryParse(json['price'].toString()) : null,
      image: json['image']?.toString(),
      videoLink: json['video_link']?.toString(),
      paymentLink: json['payment_link']?.toString(),
      category: json['category']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'price': price?.toString(),
      'image': image,
      'video_link': videoLink,
      'payment_link': paymentLink,
      'category': category,
    };
  }
}