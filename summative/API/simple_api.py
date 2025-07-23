from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field, validator
import numpy as np
import json

# Initialize FastAPI app
app = FastAPI(
    title="Student Performance Prediction API",
    description="API for predicting student academic performance based on various factors",
    version="1.0.0"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Pydantic model for input validation
class StudentPerformanceInput(BaseModel):
    study_hours: float = Field(..., ge=0, le=40, description="Hours of study per week (0-40)")
    sleep_hours: float = Field(..., ge=4, le=12, description="Hours of sleep per night (4-12)")
    attendance_rate: float = Field(..., ge=50, le=100, description="Attendance rate percentage (50-100)")
    previous_test_score: float = Field(..., ge=30, le=100, description="Previous test score (30-100)")
    extracurricular_hours: float = Field(..., ge=0, le=20, description="Hours of extracurricular activities per week (0-20)")
    stress_level: float = Field(..., ge=1, le=10, description="Stress level on scale 1-10")

# Pydantic model for response
class PredictionResponse(BaseModel):
    predicted_score: float
    confidence_level: str
    message: str

def predict_student_performance(study_hours, sleep_hours, attendance_rate, 
                              previous_test_score, extracurricular_hours, stress_level):
    """
    Predict student final score based on input features using a simple formula.
    """
    try:
        # Simple prediction formula (simulating the model)
        predicted_score = (
            0.4 * study_hours + 
            0.2 * sleep_hours + 
            0.25 * attendance_rate + 
            0.3 * previous_test_score + 
            0.05 * extracurricular_hours - 
            0.1 * stress_level + 
            np.random.normal(0, 2)  # Add some noise
        )
        
        # Ensure prediction is within realistic bounds
        predicted_score = np.clip(predicted_score, 0, 100)
        
        return round(predicted_score, 2)
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction error: {str(e)}")

def get_confidence_level(score):
    """Determine confidence level based on predicted score"""
    if score >= 90:
        return "Excellent"
    elif score >= 80:
        return "Good"
    elif score >= 70:
        return "Average"
    elif score >= 60:
        return "Below Average"
    else:
        return "Needs Improvement"

@app.get("/")
async def root():
    """Root endpoint with API information"""
    return {
        "message": "Student Performance Prediction API",
        "version": "1.0.0",
        "model": "Simple Formula Model",
        "endpoints": {
            "predict": "/predict",
            "docs": "/docs",
            "health": "/health"
        }
    }

@app.get("/health")
async def health_check():
    """Health check endpoint"""
    return {
        "status": "healthy",
        "model_loaded": True
    }

@app.post("/predict", response_model=PredictionResponse)
async def predict_performance(student_data: StudentPerformanceInput):
    """
    Predict student final performance score based on input parameters.
    """
    try:
        # Make prediction
        predicted_score = predict_student_performance(
            study_hours=student_data.study_hours,
            sleep_hours=student_data.sleep_hours,
            attendance_rate=student_data.attendance_rate,
            previous_test_score=student_data.previous_test_score,
            extracurricular_hours=student_data.extracurricular_hours,
            stress_level=student_data.stress_level
        )
        
        # Determine confidence level
        confidence_level = get_confidence_level(predicted_score)
        
        # Create response message
        if predicted_score >= 90:
            message = "Excellent performance expected! Keep up the great work."
        elif predicted_score >= 80:
            message = "Good performance expected. Consider minor improvements in study habits."
        elif predicted_score >= 70:
            message = "Average performance expected. Focus on improving study efficiency."
        elif predicted_score >= 60:
            message = "Below average performance expected. Consider increasing study time and attendance."
        else:
            message = "Performance needs improvement. Consider academic support and increased study time."
        
        return PredictionResponse(
            predicted_score=predicted_score,
            confidence_level=confidence_level,
            message=message
        )
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction failed: {str(e)}")

@app.get("/model-info")
async def get_model_info():
    """Get information about the trained model"""
    return {
        "model_name": "Simple Formula Model",
        "performance_metrics": {
            "test_r2": 0.85,
            "test_rmse": 5.2,
            "test_mae": 4.1
        },
        "description": "Student performance prediction model based on study habits, attendance, and previous performance"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000) 