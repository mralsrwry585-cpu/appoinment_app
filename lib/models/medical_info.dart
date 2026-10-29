class MedicalInfo {
  List<String> chronicDiseases;
  List<String> allergies;
  List<String> medications;
  String? bloodType;

  MedicalInfo({
    required this.chronicDiseases,
    required this.allergies,
    required this.medications,
    this.bloodType,
  });
}
