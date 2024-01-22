import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/domain.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel implements IMessageEntity {
  factory MessageModel({
    required final int counter,
    required final int numConnection,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
}
