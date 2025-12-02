# ML CI/CD Automation

A complete CI/CD pipeline for Machine Learning projects using GitHub Actions, automated model training, evaluation, and deployment to Hugging Face Spaces.

## Live Demo

Try the deployed application: [Drug Classification App](https://huggingface.co/spaces/tavi33/Drug-Classifiaction)

## Project Overview

This project demonstrates a full MLOps workflow that automates:
- Model training and evaluation
- Performance metrics tracking
- Automated deployment to production
- Version control for models and results

## Architecture

```
Push to GitHub → CI Pipeline → Model Training → Evaluation → Deploy to Hugging Face
```

### Continuous Integration (CI)
- Installs dependencies
- Formats code with Black
- Trains RandomForest model
- Generates performance metrics
- Creates confusion matrix
- Saves results to `update` branch

### Continuous Deployment (CD)
- Pulls latest model from `update` branch
- Deploys to Hugging Face Spaces
- Updates web application
- Syncs model and metrics

## Model Performance

- **Algorithm**: Random Forest Classifier
- **Accuracy**: ~93%
- **F1 Score**: ~0.88

The model predicts drug classifications based on patient features:
- Age
- Sex
- Blood Pressure
- Cholesterol
- Na_to_K ratio

## Workflow

### On every push to `main`:

1. **CI Pipeline runs**:
   - Formats code
   - Trains model
   - Evaluates performance
   - Generates metrics
   - Commits to `update` branch

2. **CD Pipeline runs**:
   - Pulls from `update` branch
   - Deploys to Hugging Face
   - Updates web application

## Monitoring

- View CI/CD logs: GitHub Actions tab
- Check model metrics: `Results/metrics.txt`
- View confusion matrix: `Results/model_results.png`
- Monitor deployments: Hugging Face Space logs

## Tech Stack

- **ML Framework**: scikit-learn
- **CI/CD**: GitHub Actions
- **Model Versioning**: Git branches
- **Deployment**: Hugging Face Spaces
- **Web Interface**: Gradio
- **Build Tools**: Make, Python

## Project Structure

```
ml-cicd-automation/
├── .github/
│   └── workflows/
│       ├── ci.yml              # CI pipeline
│       └── cd.yml              # CD pipeline
├── App/
│   ├── drug_app.py            # Gradio web application
│   ├── requirements.txt       # App dependencies
│   └── README.md              # HF Space metadata
├── Data/
│   └── drug.csv               # Training dataset
├── Model/
│   └── drug_pipeline.skops    # Trained model (generated)
├── Results/
│   ├── metrics.txt            # Performance metrics (generated)
│   └── model_results.png      # Confusion matrix (generated)
├── Makefile                   # Build automation
├── requirements.txt           # Project dependencies
├── train.py                   # Training script
└── notebook.ipynb             # Experimentation notebook
```

## Configuration

### GitHub Secrets

Set up these secrets in your GitHub repository (Settings → Secrets → Actions):

- `USER_NAME`: Your GitHub username
- `USER_EMAIL`: Your GitHub email
- `HF`: Your Hugging Face access token

### Hugging Face Space

1. Create a new Space on Hugging Face
2. Set SDK to Gradio
3. Update space name in `Makefile` (line 28-30)

## Getting Started

### Prerequisites

- Python 3.10+
- GitHub account
- Hugging Face account

### Local Setup

1. Clone the repository:
```bash
git clone https://github.com/tavigingu/ml-cicd-automation.git
cd ml-cicd-automation
```

2. Create virtual environment:
```bash
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Train the model locally:
```bash
python train.py
```

5. Run the app locally:
```bash
python App/drug_app.py
```

## Acknowledgments

- Tutorial based on [DataCamp's CI/CD for Machine Learning](https://www.datacamp.com/tutorial/ci-cd-for-machine-learning)
- Dataset from [Kaggle - Drug Classification](https://www.kaggle.com/datasets/prathamtripathi/drug-classification)

