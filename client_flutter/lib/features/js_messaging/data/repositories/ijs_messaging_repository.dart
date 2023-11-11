import '../../domain/domain.dart';

abstract interface class IJSMessagingRepository {
  Stream<IProfileEntity> watchProfile();
}
