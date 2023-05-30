class Performance {
  int id = 0;
  String description = '';
  String date = '';
  String amount = '';
  String category = '';

  Performance(
    this.id,
    this.date,
    this.amount,
    this.description,
    this.category,
  );

  factory Performance.fromJson(Map<String, dynamic> performanceMap) {
    return Performance(
      performanceMap['id'] ?? 0,
      performanceMap['date'] ?? '',
      performanceMap['amount'] ?? '',
      performanceMap['description'] ?? '',
      performanceMap['category'] ?? '',
    );
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
