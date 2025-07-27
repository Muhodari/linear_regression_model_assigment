# 🎓 Student Performance Prediction System

## 📋 Project Overview

This comprehensive **Student Performance Prediction System** is a full-stack machine learning application that predicts academic performance based on student behavior and study patterns. The system combines data science, backend API development, and mobile app development to create a practical educational tool.

### 🎯 Problem Statement

Educational institutions face challenges in identifying students who may struggle academically before it's too late. Traditional methods rely on reactive approaches after poor performance is already evident. This system provides a **proactive solution** by predicting student performance using measurable behavioral and academic indicators.

### 🚀 Solution Architecture

The project implements a **three-tier architecture**:

1. **📊 Data Science Layer**: Machine learning models trained on synthetic student data
2. **🔧 Backend API Layer**: FastAPI server providing prediction endpoints
3. **📱 Frontend Layer**: Flutter mobile app with intuitive user interface

---

## 🧠 Machine Learning Model

### Dataset & Features

The system uses a **synthetic student performance dataset** with 6 key predictive features:

| Feature | Range | Description | Distribution |
|---------|-------|-------------|-------------|
| Study Hours per Week | 0-40 | Time spent studying outside class | Normal (μ=15, σ=5) |
| Sleep Hours per Night | 4-12 | Quality and quantity of sleep | Normal (μ=7.5, σ=1.5) |
| Attendance Rate | 50-100% | Class attendance percentage | Normal (μ=85, σ=10) |
| Previous Test Score | 30-100 | Performance in previous assessments | Normal (μ=75, σ=15) |
| Extracurricular Hours | 0-20 | Time in non-academic activities | Normal (μ=5, σ=3) |
| Stress Level | 1-10 | Self-reported stress scale | Normal (μ=5, σ=2) |

### Model Comparison

The system evaluates three machine learning algorithms:

| Model | Advantages | Use Case |
|-------|------------|----------|
| **Linear Regression** | Interpretable, fast | Baseline performance |
| **Decision Tree** | Non-linear relationships | Feature importance |
| **Random Forest** | High accuracy, robust | Production deployment |

### Dataset Details

#### **📊 Synthetic Data Generation**
- **Size**: 1,000 student records
- **Type**: Programmatically generated for educational purposes
- **Seed**: Fixed random seed (42) for reproducibility
- **Privacy**: No real student data used

#### **🔧 Feature Engineering**
The model includes **3 additional engineered features**:

| Engineered Feature | Formula | Purpose |
|-------------------|---------|---------|
| Study-Attendance Interaction | `study_hours × attendance_rate / 100` | Captures study effectiveness |
| Sleep-Study Ratio | `sleep_hours / (study_hours + 1)` | Balance between rest and work |
| Performance Momentum | `previous_test_score × attendance_rate / 100` | Academic trajectory |

#### **🎯 Target Variable**
- **Final Score** (0-100%): Academic performance prediction
- **Generation Logic**: Weighted combination of features with realistic noise

### Model Performance Metrics

- **R² Score**: Measures prediction accuracy (Current: 49.5%)
- **Mean Absolute Error (MAE)**: Average prediction error (Current: 3.78 points)
- **Root Mean Square Error (RMSE)**: Penalizes large errors (Current: 4.80 points)
- **Cross-validation**: Ensures model reliability

---

## 🔧 Backend API (FastAPI)

### API Endpoints

| Endpoint | Method | Description | URL |
|----------|--------|-------------|-----|
| `/predict` | POST | Main prediction endpoint | `http://127.0.0.1:8000/predict` |
| `/health` | GET | API health check | `http://127.0.0.1:8000/health` |
| `/model-info` | GET | Model metadata | `http://127.0.0.1:8000/model-info` |
| `/docs` | GET | Interactive API documentation | `http://127.0.0.1:8000/docs` |

### Key Features

- ✅ **Pydantic Validation**: Strict input validation with custom error messages
- ✅ **CORS Support**: Cross-origin requests enabled for mobile app
- ✅ **Error Handling**: Comprehensive error responses
- ✅ **Model Persistence**: Pre-trained models loaded at startup
- ✅ **Scalability**: Ready for production deployment

### API Usage Example

#### Local Development
```bash
curl -X POST "http://127.0.0.1:8000/predict" \
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

#### Production (when deployed)
```bash
curl -X POST "https://your-deployed-api.onrender.com/predict" \
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

**Response:**
```json
{
  "predicted_score": 87.5,
  "confidence_level": "High Confidence",
  "message": "Excellent study habits! Your predicted score of 87.5% indicates strong academic performance. Maintain your current study routine and attendance patterns."
}
```

### API Testing

You can test the API using:

1. **Swagger UI**: Visit `http://127.0.0.1:8000/docs` for interactive testing
2. **Health Check**: Visit `http://127.0.0.1:8000/health` to verify API status
3. **Model Info**: Visit `http://127.0.0.1:8000/model-info` to see model details

#### **🧪 Quick Test Commands**
```bash
# Health check
curl http://127.0.0.1:8000/health

# Model info
curl http://127.0.0.1:8000/model-info

# Test prediction
curl -X POST "http://127.0.0.1:8000/predict" \
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

---

## 📱 Mobile Application (Flutter)

### App Features

#### 🏠 Home Screen
- Welcome interface with project overview
- Quick start button for predictions
- About section with technology details

#### 📊 Prediction Screen
- **Intuitive Form Design**: Clean, user-friendly input fields
- **Real-time Validation**: Immediate feedback on input errors
- **Loading States**: Smooth user experience during API calls
- **Auto-navigation**: Seamless transition to results

#### 📈 Summary Screen
- **Prediction Results**: Prominent display of predicted score
- **Confidence Indicators**: Visual confidence level badges
- **Student Profile**: Complete input data summary
- **Action Buttons**: Easy navigation and sharing options

### Technical Implementation

- **State Management**: Provider pattern for efficient state handling
- **HTTP Communication**: Robust API integration with error handling
- **Null Safety**: Comprehensive null safety checks throughout
- **Responsive Design**: Adapts to different screen sizes
- **Material Design 3**: Modern, accessible UI components

---

## 🚀 Getting Started

### Prerequisites

- **Python 3.8+** for backend development
- **Flutter SDK 3.0+** for mobile app
- **Git** for version control

### 🎯 Dataset Information

This project uses a **synthetic student performance dataset** with the following characteristics:

- **📊 Dataset Type**: Programmatically generated for educational purposes
- **📈 Size**: 1,000 student records
- **🔒 Privacy**: No real student data used
- **🎲 Reproducibility**: Fixed random seed (42) for consistent results
- **📋 Features**: 6 base features + 3 engineered features
- **🎯 Target**: Academic performance prediction (0-100%)

#### **Why Synthetic Data?**
1. **Educational Purpose**: Demonstrates ML concepts without privacy concerns
2. **Controlled Variables**: Known relationships for learning
3. **Reproducible Results**: Same outcomes every time
4. **Realistic Ranges**: Based on educational research
5. **No Privacy Issues**: Compliant with data protection regulations

### Installation & Setup

#### 1. Clone the Repository
```bash
git clone https://github.com/Muhodari/linear_regression_model_assigment.git
cd linear_regression_model
```

#### 2. Backend Setup
```bash
cd summative/API
pip install -r requirements.txt
python -m uvicorn prediction:app --reload
```

#### 3. Mobile App Setup
```bash
cd summative/FlutterApp
flutter pub get
flutter run
```

### Configuration

#### API URL Configuration
Update the API URL in `summative/FlutterApp/lib/providers/prediction_provider.dart`:
```dart
static const String baseUrl = 'http://127.0.0.1:8000'; // Local development
// or
```

---

## 📁 Project Structure

```
linear_regression_model/
├── 📊 summative/linear_regression/
│   ├── student_performance_prediction.ipynb  # Data analysis & model training
│   ├── train_model.py                       # Model training script
│   ├── best_model.pkl                       # Trained model file
│   ├── scaler.pkl                          # Feature scaler
│   └── model_info.json                     # Model metadata
│
├── 🔧 summative/API/
│   ├── prediction.py                        # FastAPI application
│   ├── simple_api.py                       # Simplified API for testing
│   ├── requirements.txt                     # Python dependencies
│   ├── deployment_guide.md                  # Deployment instructions
│   └── test_api.py                         # API testing script
│
├── 📱 summative/FlutterApp/
│   ├── lib/
│   │   ├── main.dart                       # App entry point
│   │   ├── models/                         # Data models
│   │   │   ├── prediction_request.dart
│   │   │   └── prediction_response.dart
│   │   ├── providers/                      # State management
│   │   │   └── prediction_provider.dart
│   │   └── screens/                        # UI screens
│   │       ├── home_screen.dart
│   │       ├── prediction_screen.dart
│   │       ├── summary_screen.dart
│   │       └── about_screen.dart
│   ├── pubspec.yaml                        # Flutter dependencies
│   └── README.md                           # App documentation
│
└── 📖 README.md                            # Project documentation
```

---

## 🧪 Testing & Quality Assurance

### API Testing
- **Swagger UI**: Interactive testing at `http://127.0.0.1:8000/docs`
- **Input Validation**: Test boundary conditions and invalid inputs
- **Error Handling**: Verify proper error responses
- **Performance**: Load testing for production readiness

### Mobile App Testing
- **Form Validation**: Test all input constraints
- **Network Handling**: Test offline scenarios and API errors
- **UI Responsiveness**: Test on different screen sizes
- **Navigation Flow**: Verify smooth user experience

### Model Validation
- **Cross-validation**: Ensure model reliability
- **Feature Importance**: Understand predictive factors
- **Performance Metrics**: Monitor prediction accuracy
- **Data Quality**: Validate synthetic dataset realism

---

## 🚀 Deployment

### Backend Deployment (Render)

1. **Create Render Account**: Sign up at [render.com](https://render.com)
2. **Connect Repository**: Link your GitHub repository
3. **Configure Service**:
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `uvicorn prediction:app --host 0.0.0.0 --port $PORT`
4. **Deploy**: Automatic deployment on code push

### Mobile App Deployment

#### Android
```bash
cd summative/FlutterApp
flutter build apk --release
```

#### iOS
```bash
cd summative/FlutterApp
flutter build ios --release
```

---

## 🎨 Design Decisions

### Color Scheme
- **Orange Theme**: Warm, energetic color palette
- **Accessibility**: High contrast for readability
- **Consistency**: Unified design language across screens

### User Experience
- **Progressive Disclosure**: Information revealed as needed
- **Feedback Loops**: Immediate response to user actions
- **Error Prevention**: Input validation and helpful messages
- **Loading States**: Clear indication of processing

### Technical Architecture
- **Separation of Concerns**: Clear boundaries between layers
- **Null Safety**: Comprehensive null checking
- **Error Handling**: Graceful degradation
- **Performance**: Optimized for speed and reliability

---

## 🔮 Future Enhancements

### Planned Features
- **User Authentication**: Individual student profiles
- **Historical Tracking**: Performance over time
- **Advanced Analytics**: Detailed insights and trends
- **Push Notifications**: Study reminders and alerts
- **LMS Integration**: Connect with existing systems

### Technical Improvements
- **Real-time Updates**: WebSocket connections
- **Offline Support**: Local prediction capabilities
- **Multi-language**: Internationalization support
- **Advanced ML**: Deep learning models
- **A/B Testing**: UI/UX optimization

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Development Guidelines
- Follow existing code style and conventions
- Add comprehensive tests for new features
- Update documentation for API changes
- Ensure mobile app compatibility

---

## 📚 Technologies & Libraries

### Backend Stack
- **Python 3.8+**: Core programming language
- **FastAPI**: Modern web framework
- **Pydantic**: Data validation
- **scikit-learn**: Machine learning algorithms
- **pandas**: Data manipulation
- **numpy**: Numerical computing

### Frontend Stack
- **Flutter**: Cross-platform framework
- **Dart**: Programming language
- **Provider**: State management
- **HTTP**: API communication
- **Material Design 3**: UI components

### Development Tools
- **Git**: Version control
- **Jupyter Notebook**: Data analysis
- **VS Code**: Development environment
- **Android Studio**: Mobile development

---

## 📄 License

This project is developed for **educational purposes** as part of a machine learning course assignment. The code is provided as-is for learning and demonstration purposes.

---

## 🎥 Video Demo

### 📱 5-Minute Project Demonstration

**YouTube Video Link**: [Student Performance Prediction System Demo](https://youtube.com/watch?v=YOUR_VIDEO_ID)

#### **🎯 Video Content:**
1. **📱 Mobile App Demo** (2 minutes)
   - App navigation and UI overview
   - Input form demonstration
   - Prediction workflow
   - Results display and summary screen

2. **🔧 API Testing** (1 minute)
   - Swagger UI demonstration
   - API endpoint testing
   - Request/response examples

3. **🧠 Model Performance** (1 minute)
   - Linear Regression vs Decision Tree vs Random Forest
   - Performance metrics explanation
   - Model selection justification

4. **🚀 Deployment Overview** (1 minute)
   - System architecture
   - Technology stack
   - Future enhancements

#### **📋 Video Requirements:**
- ✅ **Presenter's Camera**: Must be visible throughout
- ✅ **Mobile App**: Live demonstration of Flutter app
- ✅ **API Testing**: Real-time Swagger UI testing
- ✅ **Model Discussion**: Performance metrics and comparisons
- ✅ **Clear Audio**: Professional presentation quality

---

## 📞 Support & Contact

For questions, issues, or contributions:
- **GitHub Issues**: Report bugs and feature requests
- **Documentation**: Check inline code comments
- **API Documentation**: Visit `http://127.0.0.1:8000/docs` when running locally

---

**🎯 Mission Accomplished**: This project successfully demonstrates the complete machine learning development lifecycle, from data science to production deployment, creating a practical tool for educational analytics.