import '../../domain/domain.dart';
import '../data.dart';

class JSMessagingRepository implements IJSMessagingRepository {
  JSMessagingRepository({required IJSMessagingDataSource dataSource}) : _dataSource = dataSource;

  final IJSMessagingDataSource _dataSource;

  @override
  Stream<IProfileEntity> watchProfile() {
    final response = _dataSource.watchProfile();
    return response;
  }
}
