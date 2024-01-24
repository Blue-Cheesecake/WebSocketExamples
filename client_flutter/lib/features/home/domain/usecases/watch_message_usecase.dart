import 'package:client_flutter/utils/utils.dart';

import '../../data/data.dart';
import '../domain.dart';

class WatchMessaageUseCase extends BaseStreamUseCase<void, IMessageEntity> {
  WatchMessaageUseCase({required IHomepageRepository repository}) : _repository = repository;

  final IHomepageRepository _repository;

  @override
  Stream<IMessageEntity> call(void params) {
    final response = _repository.watchMessage();
    return response;
  }
}
