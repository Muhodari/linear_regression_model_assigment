class PredictionRequest {
  final double studyHours;
  final double sleepHours;
  final double attendanceRate;
  final double previousTestScore;
  final double extracurricularHours;
  final double stressLevel;

  PredictionRequest({
    required this.studyHours,
    required this.sleepHours,
    required this.attendanceRate,
    required this.previousTestScore,
    required this.extracurricularHours,
    required this.stressLevel,
  });

  Map<String, dynamic> toJson() {
    return {
      'study_hours': studyHours,
      'sleep_hours': sleepHours,
      'attendance_rate': attendanceRate,
      'previous_test_score': previousTestScore,
      'extracurricular_hours': extracurricularHours,
      'stress_level': stressLevel,
    };
  }

  bool isValid() {
    return studyHours >= 0 && studyHours <= 40 &&
           sleepHours >= 4 && sleepHours <= 12 &&
           attendanceRate >= 50 && attendanceRate <= 100 &&
           previousTestScore >= 30 && previousTestScore <= 100 &&
           extracurricularHours >= 0 && extracurricularHours <= 20 &&
           stressLevel >= 1 && stressLevel <= 10;
  }

  String? getValidationError() {
    if (studyHours < 0 || studyHours > 40) {
      return 'Study hours must be between 0 and 40';
    }
    if (sleepHours < 4 || sleepHours > 12) {
      return 'Sleep hours must be between 4 and 12';
    }
    if (attendanceRate < 50 || attendanceRate > 100) {
      return 'Attendance rate must be between 50 and 100';
    }
    if (previousTestScore < 30 || previousTestScore > 100) {
      return 'Previous test score must be between 30 and 100';
    }
    if (extracurricularHours < 0 || extracurricularHours > 20) {
      return 'Extracurricular hours must be between 0 and 20';
    }
    if (stressLevel < 1 || stressLevel > 10) {
      return 'Stress level must be between 1 and 10';
    }
    return null;
  }
} 