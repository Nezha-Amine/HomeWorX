import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:home_service_app/features/service/models/service_model.dart';

class ServiceRepository extends GetxController {
  static ServiceRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch all services
  Future<List<ServiceModel>> getAllServices() async {
    try {
      final snapshot = await _db.collection("Services").get();
      return snapshot.docs
          .map((doc) => ServiceModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw "Failed to fetch services: $e";
    }
  }

  // Add a new service
  Future<void> addService(ServiceModel service) async {
    try {
      await _db.collection("Services").doc(service.id).set(service.toJson());
    } catch (e) {
      throw "Failed to add service: $e";
    }
  }

  // Delete a service
  Future<void> deleteService(String serviceId) async {
    try {
      await _db.collection("Services").doc(serviceId).delete();
    } catch (e) {
      throw "Failed to delete service: $e";
    }
  }
}
