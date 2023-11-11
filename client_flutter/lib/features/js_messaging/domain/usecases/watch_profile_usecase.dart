import '../../../../utils/utils.dart';
import '../../data/data.dart';
import '../domain.dart';

class WatchProfileUseCase extends BaseStreamUseCase<void, IProfileEntity> {
  WatchProfileUseCase({required IJSMessagingRepository repository}) : _repository = repository;

  final IJSMessagingRepository _repository;

  @override
  Stream<IProfileEntity> call(void params) {
    final response = _repository.watchProfile();
    return response;
  }
}
