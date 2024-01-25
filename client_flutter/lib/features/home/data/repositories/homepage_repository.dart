import '../../domain/domain.dart';
import '../data.dart';

class HomepageRepository implements IHomepageRepository {
  HomepageRepository({required IHomepageDataSource dataSource}) : _dataSource = dataSource;

  final IHomepageDataSource _dataSource;

  @override
  Stream<IMessageEntity> watchMessage() {
    final response = _dataSource.watchMessage();
    return response;
  }
}
