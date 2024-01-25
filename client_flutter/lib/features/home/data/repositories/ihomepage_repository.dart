import '../../domain/domain.dart';

abstract interface class IHomepageRepository {
  Stream<IMessageEntity> watchMessage();
}
