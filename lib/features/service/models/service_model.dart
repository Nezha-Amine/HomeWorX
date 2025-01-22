class ServiceModel {
  final String id; // Unique identifier for the service
  final String name;

  ServiceModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["id"],
        name: json["name"],
      );
}
