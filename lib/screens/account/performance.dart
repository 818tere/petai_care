class Performance {
  int id = 0;
  String description = '';
  String date = '';
  String amount = '';

  Performance(this.id, this.date, this.amount, this.description);

  Performance.fromJson(Map<String, dynamic> performanceMap) {
    id = performanceMap['id'] ?? 0;
    date = performanceMap['date'] ?? '';
    amount = performanceMap['amount'] ?? '';
    description = performanceMap['description'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'amount': amount,
      'description': description,
    };
  }
}
