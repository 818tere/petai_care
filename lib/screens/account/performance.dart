class Performance {
  int id = 0;
  String description = '';
  String date = '';
  String amount = '';
  String category = '';

  Performance(this.id, this.date, this.amount, this.description, this.category);

  Performance.fromJson(Map<String, dynamic> performanceMap) {
    id = performanceMap['id'] ?? 0;
    date = performanceMap['date'] ?? '';
    amount = performanceMap['amount'] ?? 0;
    description = performanceMap['description'] ?? '';
    category = performanceMap['category'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'amount': amount,
      'description': description,
      'category': category,
    };
  }
}
