class TableModel {
  final String id;
  final String name;
  final int seats;
  double totalAmount;
  int minutesOpened;
  bool hasActiveOrder;

  TableModel({
    required this.id,
    required this.name,
    required this.seats,
    this.totalAmount = 0,
    this.minutesOpened = 0,
    this.hasActiveOrder = false,
  });

  void clear() {
    totalAmount = 0;
    minutesOpened = 0;
    hasActiveOrder = false;
  }
}
