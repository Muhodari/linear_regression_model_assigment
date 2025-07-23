class PredictionResponse {
  final double predictedScore;
  final String confidenceLevel;
  final String message;

  PredictionResponse({
    required this.predictedScore,
    required this.confidenceLevel,
    required this.message,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    return PredictionResponse(
      predictedScore: (json['predicted_score'] as num).toDouble(),
      confidenceLevel: json['confidence_level'] as String,
      message: json['message'] as String,
    );
  }

  String getScoreColor() {
    if (predictedScore >= 90) return '#4CAF50'; // Green
    if (predictedScore >= 80) return '#8BC34A'; // Light Green
    if (predictedScore >= 70) return '#FFC107'; // Amber
    if (predictedScore >= 60) return '#FF9800'; // Orange
    return '#F44336'; // Red
  }

  String getEmoji() {
    if (predictedScore >= 90) return '🎉';
    if (predictedScore >= 80) return '😊';
    if (predictedScore >= 70) return '😐';
    if (predictedScore >= 60) return '😕';
    return '😢';
  }
} 