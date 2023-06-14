class Exercise {
  String name;
  int weight;
  String reps;
  String sets;
  bool
      isChecked; // Adding a boolean field to keep the check status of each exercise

  Exercise(
      {required this.name,
      required this.weight,
      required this.reps,
      required this.sets,
      this.isChecked = false});
}
