import 'package:get/get.dart';
import 'package:home_service_app/data/repositories/service/service_repository.dart';
import 'package:home_service_app/data/repositories/user/user_repository.dart';
import 'package:home_service_app/features/authentication/models/user_model.dart';
import 'package:home_service_app/features/service/models/service_model.dart';

class ServiceController extends GetxController {
  static ServiceController get instance => Get.find();

  final serviceRepository = ServiceRepository.instance;
  final userRepository = UserRepository.instance;

  var allServices = <ServiceModel>[].obs; // Observable list of all services
  var selectedServices = <HandymanService>[].obs; // User-selected services

  // Fetch all available services
  void fetchServices() async {
    try {
      final services = await serviceRepository.getAllServices();
      allServices.assignAll(services);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Update user's selected services
  void updateUserSelectedServices(String userId) async {
    try {
      await userRepository.updateUserServices(userId, selectedServices);
      Get.snackbar("Success", "Services updated successfully.");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // Toggle service selection
  void toggleServiceSelection(ServiceModel service) {
    final existingService =
        selectedServices.firstWhereOrNull((s) => s.serviceName == service.name);

    if (existingService != null) {
      selectedServices.remove(existingService);
    } else {
      selectedServices.add(HandymanService(serviceName: service.name));
    }
  }
}
