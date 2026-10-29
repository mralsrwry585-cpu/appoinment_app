class WorkSchedule {
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final int sessionDuration;

  WorkSchedule({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.sessionDuration,
  });

  factory WorkSchedule.fromJson(Map<String, dynamic> json) => WorkSchedule(
        dayOfWeek: json['day_of_week'] ?? '',
        startTime: json['start_time'] ?? '',
        endTime: json['end_time'] ?? '',
        sessionDuration: json['session_duration'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'day_of_week': dayOfWeek,
        'start_time': startTime,
        'end_time': endTime,
        'session_duration': sessionDuration,
      };
}
