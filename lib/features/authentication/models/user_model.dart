class UserModel {
  final String id;
  final String email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  String? profilePictureUrl;
  String? role; // Added role field
  List<HandymanService>? services; // Selected handyman services

  UserModel({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.address,
    this.profilePictureUrl,
    this.role, // Initialize role as optional
    this.services = const [], // Default empty list
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "address": address,
        "profilePictureUrl": profilePictureUrl,
        "role": role, // Include role in serialization
        "services": services?.map((service) => service.toJson()).toList(),
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        profilePictureUrl: json["profilePictureUrl"],
        role: json["role"], // Deserialize role
        services: (json["services"] as List<dynamic>?)
            ?.map((service) => HandymanService.fromJson(service))
            .toList(),
      );
}

class HandymanService {
  String serviceName;
  List<String>? projectImages;
  double? averagePricePerHour;
  int? yearsOfExperience;
  double? hourlyRate; // Add hourlyRate field

  HandymanService({
    required this.serviceName,
    this.projectImages,
    this.averagePricePerHour,
    this.yearsOfExperience,
    this.hourlyRate, // Add hourlyRate to constructor
  });

  Map<String, dynamic> toJson() => {
        "serviceName": serviceName,
        "projectImages": projectImages,
        "averagePricePerHour": averagePricePerHour,
        "yearsOfExperience": yearsOfExperience,
        "hourlyRate": hourlyRate, // Include hourlyRate in toJson
      };

  factory HandymanService.fromJson(Map<String, dynamic> json) =>
      HandymanService(
        serviceName: json["serviceName"],
        projectImages: List<String>.from(json["projectImages"] ?? []),
        averagePricePerHour: json["averagePricePerHour"],
        yearsOfExperience: json["yearsOfExperience"],
        hourlyRate: json["hourlyRate"], // Deserialize hourlyRate
      );
}
