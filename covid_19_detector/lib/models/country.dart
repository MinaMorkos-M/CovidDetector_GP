class Country {
  final String country;
  final String slug;
  final String iso2;

  Country(
    this.country,
    this.slug,
    this.iso2,
  );

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      json["Country"],
      json["Slug"],
      json["ISO2"],
    );
  }
}
