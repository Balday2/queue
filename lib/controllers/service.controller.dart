
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:queue/app/config/app.constants.dart';
import 'package:queue/models/service.model.dart';

class ServiceController extends GetxController {
  Rx<List<ServiceModel>> serviceList =  Rx<List<ServiceModel>>([]);
  List<ServiceModel> get services => serviceList.value;

  @override
  void onReady() {
    serviceList.bindStream(read_());
  }

  /// create a new service
  create_(ServiceModel serviceModel) async {
    await AppConst.fireStore
      .collection('users')
      .doc(AppConst.fireAuth.currentUser!.uid)
      .collection('services')
      .add({
        'title': serviceModel.title,
        'description': serviceModel.description,
        'phoneNumber': serviceModel.phoneNumber,
        'location': serviceModel.location,
      });
  }

  /// read all services 
  Stream<List<ServiceModel>> read_() {
    return AppConst.fireStore
      .collection('users')
      .doc(AppConst.fireAuth.currentUser!.uid)
      .collection('services')
      .snapshots()
      .map((QuerySnapshot query) {
        List<ServiceModel> services = [];
        for (var service in query.docs) {
          final serviceModel = ServiceModel.fromDocumentSnapshot(docSnapshot: service);
          services.add(serviceModel);
        }
        return services;
      });
  }


  /// update a service by documentId
  update_(ServiceModel serviceModel, documentId) {
    AppConst.fireStore
      .collection('users')
      .doc(AppConst.fireAuth.currentUser!.uid)
      .collection('services')
      .doc(documentId)
      .update({
        'title': serviceModel.title,
        'description': serviceModel.description,
        'phoneNumber': serviceModel.phoneNumber,
        'location': serviceModel.location,
      });
  }

  /// delete a service by docuementId
  delete_(String documentId) {
    AppConst.fireStore
      .collection('users')
      .doc(AppConst.fireAuth.currentUser!.uid)
      .collection('services')
      .doc(documentId)
      .delete();
  }
}