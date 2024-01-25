import '../../domain/domain.dart';

abstract interface class IHomepageDataSource {
  Stream<IMessageEntity> watchMessage();
}
