#!/usr/bin/env python3
"""
Test script for the Student Performance Prediction API
"""

import requests
import json
import sys

# Update this URL with your actual API URL
API_BASE_URL = "https://your-api-url.onrender.com"

def test_health_check():
    """Test the health check endpoint"""
    print("Testing health check...")
    try:
        response = requests.get(f"{API_BASE_URL}/health")
        if response.status_code == 200:
            print("✅ Health check passed")
            print(f"Response: {response.json()}")
        else:
            print(f"❌ Health check failed: {response.status_code}")
    except Exception as e:
        print(f"❌ Health check error: {e}")

def test_model_info():
    """Test the model info endpoint"""
    print("\nTesting model info...")
    try:
        response = requests.get(f"{API_BASE_URL}/model-info")
        if response.status_code == 200:
            print("✅ Model info endpoint working")
            data = response.json()
            print(f"Model: {data.get('model_name')}")
            print(f"R² Score: {data.get('performance_metrics', {}).get('test_r2')}")
        else:
            print(f"❌ Model info failed: {response.status_code}")
    except Exception as e:
        print(f"❌ Model info error: {e}")

def test_prediction():
    """Test the prediction endpoint"""
    print("\nTesting prediction endpoint...")
    
    # Test data
    test_data = {
        "study_hours": 20,
        "sleep_hours": 8,
        "attendance_rate": 90,
        "previous_test_score": 85,
        "extracurricular_hours": 5,
        "stress_level": 4
    }
    
    try:
        response = requests.post(
            f"{API_BASE_URL}/predict",
            headers={"Content-Type": "application/json"},
            data=json.dumps(test_data)
        )
        
        if response.status_code == 200:
            print("✅ Prediction successful")
            result = response.json()
            print(f"Predicted Score: {result.get('predicted_score')}%")
            print(f"Confidence Level: {result.get('confidence_level')}")
            print(f"Message: {result.get('message')}")
        else:
            print(f"❌ Prediction failed: {response.status_code}")
            print(f"Error: {response.text}")
    except Exception as e:
        print(f"❌ Prediction error: {e}")

def test_validation():
    """Test input validation"""
    print("\nTesting input validation...")
    
    # Test invalid data
    invalid_data = {
        "study_hours": 50,  # Should be <= 40
        "sleep_hours": 2,    # Should be >= 4
        "attendance_rate": 30,  # Should be >= 50
        "previous_test_score": 20,  # Should be >= 30
        "extracurricular_hours": 25,  # Should be <= 20
        "stress_level": 15   # Should be <= 10
    }
    
    try:
        response = requests.post(
            f"{API_BASE_URL}/predict",
            headers={"Content-Type": "application/json"},
            data=json.dumps(invalid_data)
        )
        
        if response.status_code == 422:
            print("✅ Input validation working (rejected invalid data)")
        else:
            print(f"❌ Input validation failed: {response.status_code}")
            print(f"Response: {response.text}")
    except Exception as e:
        print(f"❌ Validation test error: {e}")

def test_cors():
    """Test CORS headers"""
    print("\nTesting CORS headers...")
    try:
        response = requests.options(f"{API_BASE_URL}/predict")
        cors_headers = response.headers.get('Access-Control-Allow-Origin')
        if cors_headers:
            print("✅ CORS headers present")
        else:
            print("❌ CORS headers missing")
    except Exception as e:
        print(f"❌ CORS test error: {e}")

def main():
    """Run all tests"""
    print("Student Performance Prediction API Tests")
    print("=" * 50)
    
    if len(sys.argv) > 1:
        global API_BASE_URL
        API_BASE_URL = sys.argv[1]
    
    print(f"Testing API at: {API_BASE_URL}")
    
    # Run tests
    test_health_check()
    test_model_info()
    test_prediction()
    test_validation()
    test_cors()
    
    print("\n" + "=" * 50)
    print("Test completed!")

if __name__ == "__main__":
    main() 