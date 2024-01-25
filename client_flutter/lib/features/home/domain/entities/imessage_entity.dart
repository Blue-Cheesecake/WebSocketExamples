abstract interface class IMessageEntity {
  IMessageEntity({required this.counter, required this.numConnection});

  final int counter;
  final int numConnection;
}
