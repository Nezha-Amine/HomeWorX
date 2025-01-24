class ServiceModel {
  final String id; // Unique identifier for the service
  final String name;
  final String houreRate;

  ServiceModel({required this.id, required this.name, required this.houreRate});

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "houreRate": houreRate};

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
      id: json["id"], name: json["name"], houreRate: json["houreRate"]);
}
