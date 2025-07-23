# API Deployment Guide

## Deploying to Render

### Step 1: Prepare Your Repository

1. **Train the Model**: First, run the training script to generate the model files:
   ```bash
   cd summative/linear_regression
   python train_model.py
   ```

2. **Copy Model Files**: Copy the generated model files to the API directory:
   ```bash
   cp best_model.pkl ../API/
   cp scaler.pkl ../API/
   cp model_info.json ../API/
   ```

### Step 2: Create Render Account

1. Go to [render.com](https://render.com)
2. Sign up for a free account
3. Connect your GitHub account

### Step 3: Deploy the API

1. **Create New Web Service**:
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Select the repository containing your code

2. **Configure the Service**:
   - **Name**: `student-performance-api` (or your preferred name)
   - **Root Directory**: `summative/API` (if your API is in a subdirectory)
   - **Runtime**: `Python 3`
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `uvicorn prediction:app --host 0.0.0.0 --port $PORT`

3. **Environment Variables** (if needed):
   - Add any environment variables your app requires

4. **Deploy**:
   - Click "Create Web Service"
   - Render will automatically build and deploy your API

### Step 4: Update Flutter App

1. **Get Your API URL**: After deployment, Render will provide a URL like:
   `https://your-app-name.onrender.com`

2. **Update Flutter App**: Open `summative/FlutterApp/lib/providers/prediction_provider.dart` and update:
   ```dart
   static const String baseUrl = 'https://your-app-name.onrender.com';
   ```

### Step 5: Test the API

1. **Health Check**: Visit `https://your-app-name.onrender.com/health`
2. **Swagger UI**: Visit `https://your-app-name.onrender.com/docs`
3. **Test Prediction**: Use the Swagger UI to test the `/predict` endpoint

### API Endpoints

- **Root**: `GET /` - API information
- **Health**: `GET /health` - Health check
- **Predict**: `POST /predict` - Make predictions
- **Model Info**: `GET /model-info` - Model information
- **Docs**: `GET /docs` - Swagger UI documentation

### Example API Call

```bash
curl -X POST "https://your-app-name.onrender.com/predict" \
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

### Troubleshooting

1. **Build Failures**: Check that all dependencies are in `requirements.txt`
2. **Model Loading Errors**: Ensure model files are in the correct directory
3. **CORS Issues**: The API includes CORS middleware, but you may need to configure origins
4. **Timeout Issues**: Render has timeout limits for free tier

### Monitoring

- **Logs**: Check the logs in your Render dashboard
- **Metrics**: Monitor performance and usage
- **Uptime**: Free tier has limitations, consider upgrading for production

### Security Notes

- The API includes input validation
- CORS is configured for cross-origin requests
- Consider adding authentication for production use
- Environment variables should be used for sensitive data

### Cost Considerations

- **Free Tier**: Limited to 750 hours/month
- **Paid Plans**: Start at $7/month for unlimited usage
- **Auto-sleep**: Free tier services sleep after 15 minutes of inactivity

### Next Steps

1. Test the API thoroughly
2. Update the Flutter app with the correct URL
3. Create your video demo
4. Update the README with your actual API URL 