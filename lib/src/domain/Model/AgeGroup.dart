enum AgeGroup {
  young(age: 0, assetPath: "assets/ageYoung.png", description: "19-21살"),
  middle(age: 1, assetPath: "assets/ageMiddle.png", description: "22-24살"),
  senior(age: 2, assetPath: "assets/ageOld.png", description: "25-27살");

  final int age;
  final String assetPath;
  final String description;
  const AgeGroup(
      {required this.age, required this.assetPath, required this.description});
  static AgeGroup fromAge(int age) {
    return AgeGroup.values
        .firstWhere((group) => group.age == age, orElse: () => AgeGroup.young);
  }
}
