abstract class BaseStreamUseCase<P, R> {
  Stream<R> call(P params);
}
