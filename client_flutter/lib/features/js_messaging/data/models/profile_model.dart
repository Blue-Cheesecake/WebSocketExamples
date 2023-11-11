import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/domain.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class ProfileModel with _$ProfileModel implements IProfileEntity {
  factory ProfileModel({
    required final String fullName,
    required final int age,
    required final int counter,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
}
