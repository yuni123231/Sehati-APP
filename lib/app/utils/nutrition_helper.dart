int getCalories(Map<String, dynamic> food) {
  final nutrients = food['foodNutrients'] as List<dynamic>?;

  if (nutrients == null) return 0;

  final energy = nutrients.firstWhere(
    (n) => n['nutrientName'] == 'Energy',
    orElse: () => {'value': 0},
  );

  return (energy['value'] ?? 0).toInt();
}