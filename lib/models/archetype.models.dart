class Archetype {
  String archetypeName;

  Archetype({
    required this.archetypeName,
  });
  factory Archetype.fromJson(Map<String, dynamic> json) => Archetype(
        archetypeName: json["archetype_name"],
      );
  Map<String, dynamic> toJson() => {
        "archetype_name": archetypeName,
      };
}
