import 'package:flutter/widgets.dart';

import '../utils.dart';

abstract class BaseStreamUseCase<P, R> {
  @protected
  Stream<R> call(P params);

  Stream<BaseResult<R>> execute(P params) async* {
    try {
      await for (final val in call(params)) {
        yield Success(val);
      }
    } catch (e) {
      yield Failure(UnknownException());
    }
  }
}
