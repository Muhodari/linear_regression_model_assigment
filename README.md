# Student Performance Prediction System

## Mission and Problem Statement

**Mission**: Educational Analytics - This project aims to predict student academic performance based on various factors including study habits, attendance, and previous performance metrics. The model helps educational institutions identify at-risk students and provide targeted interventions.

**Problem**: Predicting final exam scores based on study hours, sleep hours, attendance rate, and previous test scores. This predictive model can assist in early intervention strategies and improve educational outcomes.

## Project Overview

This comprehensive system includes:

1. **Linear Regression Model** - Jupyter notebook with data analysis, visualization, and model comparison
2. **FastAPI Backend** - RESTful API with data validation and CORS support
3. **Flutter Mobile App** - Cross-platform mobile application with beautiful UI

## API Endpoint

**Public API URL**: `https://your-api-url.onrender.com`

**Swagger UI Documentation**: `https://your-api-url.onrender.com/docs`

**Health Check**: `https://your-api-url.onrender.com/health`

**Prediction Endpoint**: `POST https://your-api-url.onrender.com/predict`

### API Usage Example

```bash
curl -X POST "https://your-api-url.onrender.com/predict" \
     -H "Content-Type: application/json" \
     -d '{
       "study_hours": 20,
       "sleep_hours": 8,
       "attendance_rate": 90,
       "previous_test_score": 85,
       "extracurricular_hours": 5,
       "stress_level": 4
     }'
```

## Video Demo

**YouTube Demo Link**: [5-minute demo video showing mobile app predictions and Swagger UI tests]

## Mobile App Instructions

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Android Studio / VS Code
- Android Emulator or Physical Device

### Running the Flutter App

1. **Navigate to the Flutter app directory**:
   ```bash
   cd summative/FlutterApp
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Update API URL** (if needed):
   - Open `lib/providers/prediction_provider.dart`
   - Update the `baseUrl` constant with your deployed API URL

4. **Run the app**:
   ```bash
   flutter run
   ```

### App Features

- **Home Screen**: Welcome interface with app overview
- **Prediction Screen**: Input form with 6 parameters:
  - Study Hours per Week (0-40)
  - Sleep Hours per Night (4-12)
  - Attendance Rate (50-100%)
  - Previous Test Score (30-100)
  - Extracurricular Hours (0-20)
  - Stress Level (1-10)
- **Results Display**: Beautiful cards showing predicted score, confidence level, and recommendations
- **About Screen**: Project information and technology details

## Project Structure

```
linear_regression_model/
├── summative/
│   ├── linear_regression/
│   │   └── student_performance_prediction.ipynb
│   ├── API/
│   │   ├── prediction.py
│   │   └── requirements.txt
│   └── FlutterApp/
│       ├── lib/
│       │   ├── main.dart
│       │   ├── models/
│       │   │   ├── prediction_request.dart
│       │   │   └── prediction_response.dart
│       │   ├── providers/
│       │   │   └── prediction_provider.dart
│       │   └── screens/
│       │       ├── home_screen.dart
│       │       ├── prediction_screen.dart
│       │       └── about_screen.dart
│       └── pubspec.yaml
└── README.md
```

## Model Performance

The system compares three machine learning algorithms:

1. **Linear Regression**: Baseline model for interpretability
2. **Decision Tree**: Non-linear relationships
3. **Random Forest**: Ensemble method for improved accuracy

**Best Model**: Random Forest (typically achieves highest R² score)

**Key Features**:
- Feature engineering with interaction terms
- Data standardization
- Cross-validation
- Comprehensive visualization
- Model persistence

## API Features

- **FastAPI Framework**: Modern, fast web framework
- **Pydantic Validation**: Strict data type and range validation
- **CORS Support**: Cross-origin resource sharing enabled
- **Error Handling**: Comprehensive error messages
- **Health Checks**: API status monitoring
- **Swagger Documentation**: Interactive API documentation

## Flutter App Features

- **Material Design 3**: Modern, beautiful UI
- **Provider State Management**: Efficient state handling
- **Form Validation**: Client-side input validation
- **Error Handling**: User-friendly error messages
- **Loading States**: Smooth user experience
- **Responsive Design**: Works on various screen sizes

## Deployment Instructions

### API Deployment (Render)

1. **Create Render Account**: Sign up at render.com
2. **Connect GitHub Repository**: Link your repository
3. **Create Web Service**: 
   - Build Command: `pip install -r requirements.txt`
   - Start Command: `uvicorn prediction:app --host 0.0.0.0 --port $PORT`
4. **Environment Variables**: Set if needed
5. **Deploy**: Automatic deployment on push

### Flutter App Deployment

1. **Build APK**: `flutter build apk --release`
2. **Build iOS**: `flutter build ios --release`
3. **Distribute**: Use Firebase App Distribution or similar

## Testing

### API Testing
- Use Swagger UI at `/docs`
- Test data types and range constraints
- Verify error handling
- Check CORS functionality

### Mobile App Testing
- Test on different screen sizes
- Verify form validation
- Test network error handling
- Check UI responsiveness

## Technologies Used

- **Python**: Data analysis and API development
- **scikit-learn**: Machine learning algorithms
- **FastAPI**: Web framework
- **Flutter**: Cross-platform mobile development
- **Dart**: Programming language for Flutter
- **HTTP**: API communication
- **Provider**: State management

## Future Enhancements

- User authentication and profiles
- Historical prediction tracking
- Advanced analytics dashboard
- Push notifications for study reminders
- Integration with learning management systems

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is developed for educational purposes as part of a machine learning course assignment.

---

**Note**: Replace `https://your-api-url.onrender.com` with your actual deployed API URL before submission. 