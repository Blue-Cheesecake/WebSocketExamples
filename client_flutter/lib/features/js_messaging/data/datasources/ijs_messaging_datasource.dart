import '../../domain/domain.dart';

abstract interface class IJSMessagingDataSource {
  Stream<IProfileEntity> watchProfile();
}
