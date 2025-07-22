pipeline {
    agent any

    environment {
        // cred ID
        AWS_CREDENTIALS = 'aws_creds'
        // Ansible private key
        ANSIBLE_PRIVATE_KEY = 'grafana-key.pem'
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Git repo clone
                git branch: 'main', url: 'https://github.com/rideg1337/grafana-observability-pipeline.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws_creds'
                ]])  {
                    sh '''
                      cd terraform
                      terraform init
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws_creds'
                ]])  {
                    sh '''
                      cd terraform
                      terraform apply -auto-approve
                      terraform output -raw private_key_pem > ../ansible/grafana-key.pem
                      chmod 400 ../ansible/grafana-key.pem
                    '''
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh '''
                  PUBLIC_IP=$(terraform -chdir=terraform output -raw public_ip)
                  echo "[grafana]" > ansible/inventory.ini
                  echo "$PUBLIC_IP ansible_user=ubuntu ansible_ssh_private_key_file=ansible/grafana-key.pem" >> ansible/inventory.ini
                  ansible-playbook -i ansible/inventory.ini ansible/deploy.yml
                  '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline successfully completed, the monitoring stack deployed in the cloud!'
        }
        failure {
            echo 'Error, check your logs...'
        }
    }
}
