class CountrySummary {
  final String country;
  final int confirmed;
  final int death;
  final int recovered;
  final int active;
  final DateTime date;

  CountrySummary(
    this.country,
    this.confirmed,
    this.death,
    this.recovered,
    this.active,
    this.date,
  );

  factory CountrySummary.fromJson(Map<String, dynamic> json) {
    return CountrySummary(
      json["Country"],
      json["Confirmed"],
      json["Deaths"],
      json["Recovered"],
      json["Active"],
      DateTime.parse(json["Date"]),
    );
  }
}
