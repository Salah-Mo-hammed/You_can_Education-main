import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad_project_ver_1/features/clean_you_can/center/domain/entities/center_entity.dart';

class CenterModel extends CenterEntity {
  const CenterModel({
    required super.centerId,
    required super.name,
    required super.email,
    required super.phoneNumber,
    required super.address,
    required super.description,
    super.coursesId = const {},
    super.licenseUrl,
    super.imageUrl,
  });

  factory CenterModel.fromJson(Map<String, dynamic> json) {
    return CenterModel(
      centerId: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      coursesId:
          (json['coursesId'] as List<dynamic>?)
              ?.map((id) => id as int)
              .toSet() ??
          {},
      licenseUrl: json['licenseUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': centerId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'description': description,
      'coursesId': coursesId.toList(),
      'licenseUrl': licenseUrl,
      'imageUrl':imageUrl
    };
  }

  // try it if you like ya faleh
  factory CenterModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CenterModel.fromJson(data);
  }
}
/**
 :super(id: id,name: name,email: email,phoneNumber: phoneNumber,address: address,description: description,coursesId: coursesId,licenseUrl: licenseUrl)
 */