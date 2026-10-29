class WorkSchedule {
  final List<String> workDays;
  final String startTime;
  final String endTime;
  final int sessionDuration;

  WorkSchedule({
    required this.workDays,
    required this.startTime,
    required this.endTime,
    required this.sessionDuration,
  });

  factory WorkSchedule.fromJson(Map<String, dynamic> json) {
    return WorkSchedule(
      workDays: List<String>.from(json['work_days'] ?? []),
      startTime: json['start_time']?.toString() ?? '',
      endTime: json['end_time']?.toString() ?? '',
      sessionDuration: json['session_duration'] ?? 0,
    );
  }
}
