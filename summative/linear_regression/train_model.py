#!/usr/bin/env python3
"""
Model Training Script for Student Performance Prediction
This script trains the model and saves it for API deployment.
"""

import pandas as pd
import numpy as np
import joblib
import json
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LinearRegression
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error

def generate_student_data(n_students=1000):
    """Generate realistic student performance dataset"""
    np.random.seed(42)
    
    # Generate features
    study_hours = np.random.normal(15, 5, n_students)
    sleep_hours = np.random.normal(7.5, 1.5, n_students)
    attendance_rate = np.random.normal(85, 10, n_students)
    previous_test_score = np.random.normal(75, 15, n_students)
    extracurricular_hours = np.random.normal(5, 3, n_students)
    stress_level = np.random.normal(5, 2, n_students)
    
    # Create target variable with realistic relationships
    final_score = (
        0.4 * study_hours + 
        0.2 * sleep_hours + 
        0.25 * attendance_rate + 
        0.3 * previous_test_score + 
        0.05 * extracurricular_hours - 
        0.1 * stress_level + 
        np.random.normal(0, 5, n_students)
    )
    
    # Create DataFrame
    data = pd.DataFrame({
        'study_hours': study_hours,
        'sleep_hours': sleep_hours,
        'attendance_rate': attendance_rate,
        'previous_test_score': previous_test_score,
        'extracurricular_hours': extracurricular_hours,
        'stress_level': stress_level,
        'final_score': final_score
    })
    
    # Ensure realistic ranges
    data['study_hours'] = np.clip(data['study_hours'], 0, 40)
    data['sleep_hours'] = np.clip(data['sleep_hours'], 4, 12)
    data['attendance_rate'] = np.clip(data['attendance_rate'], 50, 100)
    data['previous_test_score'] = np.clip(data['previous_test_score'], 30, 100)
    data['extracurricular_hours'] = np.clip(data['extracurricular_hours'], 0, 20)
    data['stress_level'] = np.clip(data['stress_level'], 1, 10)
    data['final_score'] = np.clip(data['final_score'], 0, 100)
    
    return data

def create_features(data):
    """Create feature engineering for the model"""
    # Create interaction features
    data['study_attendance_interaction'] = data['study_hours'] * data['attendance_rate'] / 100
    data['sleep_study_ratio'] = data['sleep_hours'] / (data['study_hours'] + 1)
    data['performance_momentum'] = data['previous_test_score'] * data['attendance_rate'] / 100
    
    # Select numerical features for modeling
    numerical_features = [
        'study_hours', 'sleep_hours', 'attendance_rate', 'previous_test_score',
        'extracurricular_hours', 'stress_level', 'study_attendance_interaction',
        'sleep_study_ratio', 'performance_momentum'
    ]
    
    return data[numerical_features], data['final_score']

def train_models(X, y):
    """Train and compare multiple models"""
    # Split the data
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    # Standardize features
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)
    
    # Initialize models
    models = {
        'Linear Regression': LinearRegression(),
        'Decision Tree': DecisionTreeRegressor(random_state=42),
        'Random Forest': RandomForestRegressor(n_estimators=100, random_state=42)
    }
    
    # Train and evaluate models
    results = {}
    
    for name, model in models.items():
        print(f"Training {name}...")
        
        # Train the model
        model.fit(X_train_scaled, y_train)
        
        # Make predictions
        y_pred_train = model.predict(X_train_scaled)
        y_pred_test = model.predict(X_test_scaled)
        
        # Calculate metrics
        train_r2 = r2_score(y_train, y_pred_train)
        test_r2 = r2_score(y_test, y_pred_test)
        test_rmse = np.sqrt(mean_squared_error(y_test, y_pred_test))
        test_mae = mean_absolute_error(y_test, y_pred_test)
        
        results[name] = {
            'model': model,
            'test_r2': test_r2,
            'test_rmse': test_rmse,
            'test_mae': test_mae
        }
        
        print(f"  {name} - Test R²: {test_r2:.4f}, RMSE: {test_rmse:.4f}, MAE: {test_mae:.4f}")
    
    return results, scaler, X.columns.tolist()

def save_best_model(results, scaler, feature_names):
    """Save the best performing model"""
    # Find the best model based on test R²
    best_model_name = max(results.keys(), key=lambda k: results[k]['test_r2'])
    best_model = results[best_model_name]['model']
    
    print(f"\nBest performing model: {best_model_name}")
    print(f"Test R²: {results[best_model_name]['test_r2']:.4f}")
    
    # Save the best model and scaler
    joblib.dump(best_model, 'best_model.pkl')
    joblib.dump(scaler, 'scaler.pkl')
    
    # Save model info
    model_info = {
        'model_name': best_model_name,
        'feature_names': feature_names,
        'test_r2': float(results[best_model_name]['test_r2']),
        'test_rmse': float(results[best_model_name]['test_rmse']),
        'test_mae': float(results[best_model_name]['test_mae'])
    }
    
    with open('model_info.json', 'w') as f:
        json.dump(model_info, f, indent=2)
    
    print("Model saved successfully!")
    return best_model_name

def main():
    """Main training function"""
    print("Student Performance Prediction Model Training")
    print("=" * 50)
    
    # Generate data
    print("Generating student performance dataset...")
    data = generate_student_data(1000)
    print(f"Dataset shape: {data.shape}")
    
    # Create features
    print("\nCreating features...")
    X, y = create_features(data)
    print(f"Feature matrix shape: {X.shape}")
    
    # Train models
    print("\nTraining models...")
    results, scaler, feature_names = train_models(X, y)
    
    # Save best model
    print("\nSaving best model...")
    best_model_name = save_best_model(results, scaler, feature_names)
    
    print(f"\nTraining completed! Best model: {best_model_name}")
    print("Files created:")
    print("- best_model.pkl (trained model)")
    print("- scaler.pkl (feature scaler)")
    print("- model_info.json (model information)")

if __name__ == "__main__":
    main() 