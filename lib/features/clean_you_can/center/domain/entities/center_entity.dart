import 'package:equatable/equatable.dart';

class CenterEntity extends Equatable {
  final String centerId;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String description;
  final Set<int> coursesId;
  final String? licenseUrl;
  final String? imageUrl;


  const CenterEntity({
    required this.centerId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.description,
    this.coursesId = const {},
    this.licenseUrl,
    this.imageUrl
  });

  @override
  List<Object?> get props => [
    centerId,
    name,
    email,
    phoneNumber,
    address,
    description,
    coursesId.toSet(),
    licenseUrl,
  imageUrl,
  ];
}
