class Vehicle {
  final int id;
  final String plate;
  final String description;
  final double latitude;
  final double longitude;

  const Vehicle({
    required this.id,
    required this.plate,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] as int,
      plate: json['plate'] as String,
      description: json['description'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }
}

