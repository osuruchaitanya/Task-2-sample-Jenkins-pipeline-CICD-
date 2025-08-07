🚀 Task 2: Create a Simple Jenkins CI/CD Pipeline
This repository demonstrates the completion of Task 2, which involves automating the build, test, and deployment process of a Node.js application using Jenkins CI/CD pipeline and Docker.

✅ Objective
Build a continuous integration and continuous deployment (CI/CD) pipeline using Jenkins that:

Clones code from a GitHub repository

Installs required Node.js dependencies

Builds a Docker image of the app

Pushes the image to Docker Hub

Deploys the app container

📁 Project Structure
bash
Copy
Edit
├── Jenkinsfile                # Declarative pipeline script
├── Dockerfile                 # Defines Docker image build process
├── server.js / index.js       # Node.js application entry point
├── package.json               # Node.js dependencies and scripts
🛠️ Tools & Technologies
Jenkins – Automation server for CI/CD

GitHub – Source code hosting

Docker – Containerization

Node.js – Backend application

Docker Hub – Container registry

🔄 Jenkins Pipeline Stages
Stage	Description
🧬 Clone Code	Fetches the source code from GitHub using credentials
📦 Install Dependencies	Installs Node.js modules using npm install
🐳 Build Docker Image	Builds a Docker image with tag latest
📤 Push to Docker Hub	Authenticates with Docker Hub and pushes the image
🚀 Deploy	Runs the container using the pushed image

🔐 Credentials Used
GitHub Token (ID: github-token) – For accessing the repository

Docker Hub Credentials (ID: Docker-Hub-credentials) – For image push/login

Make sure these are securely added in Jenkins > Manage Credentials.

📝 Sample Jenkinsfile
groovy
Copy
Edit
pipeline {
    agent any

    environment {
        DOCKER_USER = 'your-docker-username'
        DOCKER_IMAGE_NAME = 'jenkins-cicd-demo'
        DOCKER_IMAGE = "${DOCKER_USER}/${DOCKER_IMAGE_NAME}"
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Clone Code') {
            steps {
                git branch: 'main', credentialsId: 'github-token', url: 'https://github.com/your-user/your-repo.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'npm install'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_IMAGE%:%DOCKER_TAG% .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'Docker-Hub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS')]) {
                        bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                        bat 'docker push %DOCKER_IMAGE%:%DOCKER_TAG%'
                }
            }
        }

        stage('Deploy') {
            steps {
                bat 'docker run -d -p 3000:3000 %DOCKER_IMAGE%:%DOCKER_TAG%'
            }
        }
    }
}
📌 Notes
Ensure Docker is installed and running on the Jenkins host.

Install the Docker Pipeline plugin in Jenkins.

Ensure your Jenkins agent has access to system commands like docker, npm, and git.

🎯 Outcome
Full automation of the CI/CD workflow using Jenkins.

Dockerized Node.js app successfully built and deployed.
