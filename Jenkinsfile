pipeline {
  agent any

  environment {
    REPO_URL = 'https://github.com/spring-projects/spring-petclinic.git'
    ARTIFACT_NAME = 'petclinic.war'
    BUILD_DIR = 'target'
    DEPLOY_DIR = '/opt/app'
  }

  stages {
    stage('Checkout') {
      steps {
        git "${REPO_URL}"
      }
    }

    stage('Build') {
      steps {
        sh 'mvn clean package -DskipTests'
      }
    }

    stage('Release') {
      steps {
        sh "cp ${BUILD_DIR}/*.war ${ARTIFACT_NAME}"
        archiveArtifacts artifacts: "${ARTIFACT_NAME}", fingerprint: true
      }
    }

    stage('Deploy to Test') {
      steps {
        sh "docker cp ${ARTIFACT_NAME} test-vm:${DEPLOY_DIR}/${ARTIFACT_NAME}"
      }
    }

    stage('Deploy to Staging') {
      steps {
        input message: "Staging onayı verilsin mi?"
        sh "docker cp ${ARTIFACT_NAME} staging-vm:${DEPLOY_DIR}/${ARTIFACT_NAME}"
      }
    }

    stage('Deploy to Production') {
      steps {
        input message: "Production onayı verilsin mi?"
        sh "docker cp ${ARTIFACT_NAME} prod-vm:${DEPLOY_DIR}/${ARTIFACT_NAME}"
      }
    }
  }
}
