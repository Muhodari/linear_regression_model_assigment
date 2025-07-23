import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prediction_provider.dart';
import '../models/prediction_request.dart';
import '../models/prediction_response.dart';
import 'summary_screen.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _studyHoursController = TextEditingController();
  final _sleepHoursController = TextEditingController();
  final _attendanceRateController = TextEditingController();
  final _previousTestScoreController = TextEditingController();
  final _extracurricularHoursController = TextEditingController();
  final _stressLevelController = TextEditingController();
  
  PredictionRequest? _currentRequest;

  @override
  void initState() {
    super.initState();
    // Set default values
    _studyHoursController.text = '15';
    _sleepHoursController.text = '8';
    _attendanceRateController.text = '85';
    _previousTestScoreController.text = '75';
    _extracurricularHoursController.text = '5';
    _stressLevelController.text = '5';
  }

  @override
  void dispose() {
    _studyHoursController.dispose();
    _sleepHoursController.dispose();
    _attendanceRateController.dispose();
    _previousTestScoreController.dispose();
    _extracurricularHoursController.dispose();
    _stressLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Prediction'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<PredictionProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.orange[50]!, Colors.orange[100]!],
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
                          'Enter Student Data',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Fill in the details below to predict academic performance',
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
                  
                  // Input Fields
                  _buildInputField(
                    controller: _studyHoursController,
                    label: 'Study Hours per Week',
                    hint: '0-40 hours',
                    icon: Icons.schedule,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter study hours';
                      }
                      final hours = double.tryParse(value);
                      if (hours == null || hours < 0 || hours > 40) {
                        return 'Study hours must be between 0 and 40';
                      }
                      return null;
                    },
                  ),
                  
                  _buildInputField(
                    controller: _sleepHoursController,
                    label: 'Sleep Hours per Night',
                    hint: '4-12 hours',
                    icon: Icons.bedtime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter sleep hours';
                      }
                      final hours = double.tryParse(value);
                      if (hours == null || hours < 4 || hours > 12) {
                        return 'Sleep hours must be between 4 and 12';
                      }
                      return null;
                    },
                  ),
                  
                  _buildInputField(
                    controller: _attendanceRateController,
                    label: 'Attendance Rate (%)',
                    hint: '50-100%',
                                         icon: Icons.check_circle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter attendance rate';
                      }
                      final rate = double.tryParse(value);
                      if (rate == null || rate < 50 || rate > 100) {
                        return 'Attendance rate must be between 50 and 100';
                      }
                      return null;
                    },
                  ),
                  
                  _buildInputField(
                    controller: _previousTestScoreController,
                    label: 'Previous Test Score',
                    hint: '30-100',
                    icon: Icons.grade,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter previous test score';
                      }
                      final score = double.tryParse(value);
                      if (score == null || score < 30 || score > 100) {
                        return 'Previous test score must be between 30 and 100';
                      }
                      return null;
                    },
                  ),
                  
                  _buildInputField(
                    controller: _extracurricularHoursController,
                    label: 'Extracurricular Hours per Week',
                    hint: '0-20 hours',
                    icon: Icons.sports_soccer,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter extracurricular hours';
                      }
                      final hours = double.tryParse(value);
                      if (hours == null || hours < 0 || hours > 20) {
                        return 'Extracurricular hours must be between 0 and 20';
                      }
                      return null;
                    },
                  ),
                  
                  _buildInputField(
                    controller: _stressLevelController,
                    label: 'Stress Level (1-10)',
                    hint: '1-10 scale',
                    icon: Icons.psychology,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter stress level';
                      }
                      final level = double.tryParse(value);
                      if (level == null || level < 1 || level > 10) {
                        return 'Stress level must be between 1 and 10';
                      }
                      return null;
                    },
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Predict Button
                  SizedBox(
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: provider.isLoading ? null : _predictPerformance,
                      icon: provider.isLoading 
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.analytics),
                      label: Text(
                        provider.isLoading ? 'Predicting...' : 'Predict Performance',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[600],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Error Display
                  if (provider.error != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red[700]),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              provider.error!,
                              style: TextStyle(color: Colors.red[700]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  const SizedBox(height: 24),
                  
                  // Show loading or success message
                  if (provider.isLoading)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(width: 16),
                          Text(
                            'Processing prediction...',
                            style: TextStyle(
                              color: Colors.orange[700],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  // Auto-redirect to summary screen when prediction is ready
                  if (provider.prediction != null && _currentRequest != null)
                    FutureBuilder(
                      future: Future.delayed(const Duration(milliseconds: 500)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // Auto-navigate to summary screen
                          WidgetsBinding.instance.addPostFrameCallback((_) async {
                            await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SummaryScreen(
                                  request: _currentRequest!,
                                  prediction: provider.prediction!,
                                ),
                              ),
                            );
                            // Clear the prediction after navigation
                            context.read<PredictionProvider>().clearPrediction();
                          });
                        }
                        return Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green[600]),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Prediction completed! Redirecting...',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.orange[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.orange[600]!, width: 2),
            ),
        ),
        validator: validator,
      ),
    );
  }



  void _predictPerformance() {
    if (_formKey.currentState!.validate()) {
      final request = PredictionRequest(
        studyHours: double.parse(_studyHoursController.text),
        sleepHours: double.parse(_sleepHoursController.text),
        attendanceRate: double.parse(_attendanceRateController.text),
        previousTestScore: double.parse(_previousTestScoreController.text),
        extracurricularHours: double.parse(_extracurricularHoursController.text),
        stressLevel: double.parse(_stressLevelController.text),
      );
      
      _currentRequest = request;
      context.read<PredictionProvider>().predictPerformance(request);
    }
  }
} 