import 'package:flutter/material.dart';

import '../utils.dart';

abstract class BaseUseCase<P, R> {
  @protected
  Future<R> call(P params);

  Future<BaseResult<R>> execute(P params) async {
    try {
      final response = await call(params);
      return Success(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  Future<BaseResult<R>> _handleException(dynamic e) async {
    // TODO: implement handling exception

    return Failure(UnknownException());
  }
}
