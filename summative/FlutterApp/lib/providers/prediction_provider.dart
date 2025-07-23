import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/prediction_request.dart';
import '../models/prediction_response.dart';

class PredictionProvider extends ChangeNotifier {
  PredictionResponse? _prediction;
  bool _isLoading = false;
  String? _error;
  
  // API configuration
  static const String baseUrl = 'http://localhost:8000'; // Local API for testing
  
  PredictionResponse? get prediction => _prediction;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> predictPerformance(PredictionRequest request) async {
    _isLoading = true;
    _error = null;
    _prediction = null;
    notifyListeners();

    try {
      // Validate request
      final validationError = request.getValidationError();
      if (validationError != null) {
        _error = validationError;
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Make API call with null safety
      final response = await http.post(
        Uri.parse('$baseUrl/predict'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData != null) {
          _prediction = PredictionResponse.fromJson(responseData);
        } else {
          _error = 'Invalid response from server';
        }
      } else {
        _error = 'Server error: ${response.statusCode}';
        if (response.body.isNotEmpty) {
          try {
            final errorData = jsonDecode(response.body);
            if (errorData != null && errorData['detail'] != null) {
              _error = errorData['detail'];
            }
          } catch (e) {
            // If error parsing fails, use the raw response
            _error = 'Server error: ${response.body}';
          }
        }
      }
    } catch (e) {
      _error = 'Network error: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearPrediction() {
    _prediction = null;
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
} 