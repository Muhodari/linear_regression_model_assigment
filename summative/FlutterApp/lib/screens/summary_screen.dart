import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/prediction_request.dart';
import '../models/prediction_response.dart';
import '../providers/prediction_provider.dart';

class SummaryScreen extends StatelessWidget {
  final PredictionRequest request;
  final PredictionResponse prediction;

  const SummaryScreen({
    super.key,
    required this.request,
    required this.prediction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction Summary'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange[50]!,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange[100]!, Colors.orange[200]!],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.analytics,
                      size: 48,
                      color: Colors.orange[700],
                    ),
                    const SizedBox(height: 16),
                                          Text(
                        'Prediction Summary',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 8),
                                            Text(
                          'Here\'s your academic performance prediction',
                          style: TextStyle(
                            color: Colors.orange[600],
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Prediction Result (Moved to top for better UX)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green[50]!,
                      Colors.blue[50]!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Score Display
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            prediction.getEmoji(),
                            style: const TextStyle(fontSize: 48),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Predicted Final Score',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                                                     Text(
                             '${prediction.predictedScore?.toStringAsFixed(1) ?? '0.0'}%',
                                                         style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[700],
                            ),
                           ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              prediction.confidenceLevel,
                              style: TextStyle(
                                color: Colors.orange[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Message
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            color: Colors.orange[600],
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              prediction.message,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Student Input Summary (Moved below result)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.orange[600],
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                                                  Text(
                            'Student Profile',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[800],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                                         _buildInputSummaryItem(
                       'Study Hours per Week',
                       '${request.studyHours?.toStringAsFixed(1) ?? '0.0'} hours',
                       Icons.schedule,
                     ),
                     _buildInputSummaryItem(
                       'Sleep Hours per Night',
                       '${request.sleepHours?.toStringAsFixed(1) ?? '0.0'} hours',
                       Icons.bedtime,
                     ),
                     _buildInputSummaryItem(
                       'Attendance Rate',
                       '${request.attendanceRate?.toStringAsFixed(1) ?? '0.0'}%',
                       Icons.check_circle,
                     ),
                     _buildInputSummaryItem(
                       'Previous Test Score',
                       '${request.previousTestScore?.toStringAsFixed(1) ?? '0.0'}%',
                       Icons.grade,
                     ),
                     _buildInputSummaryItem(
                       'Extracurricular Hours',
                       '${request.extracurricularHours?.toStringAsFixed(1) ?? '0.0'} hours',
                       Icons.sports_soccer,
                     ),
                     _buildInputSummaryItem(
                       'Stress Level',
                       '${request.stressLevel?.toStringAsFixed(1) ?? '0.0'}/10',
                       Icons.psychology,
                     ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('Back to Home'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('New Prediction'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[600],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Share Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Share functionality coming soon!'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Share Results'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputSummaryItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.orange[700],
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 