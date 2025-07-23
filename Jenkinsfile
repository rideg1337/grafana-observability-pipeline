pipeline {
    agent any

    environment {
        // cred ID
        AWS_CREDENTIALS = 'aws_creds'
        // Ansible private key
        ANSIBLE_PRIVATE_KEY = '${env.WORKSPACE}/ansible/grafana-key.pem'
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
                    sh """
                      cd terraform
                      terraform apply -auto-approve
                      chmod +w "$WORKSPACE/ansible/grafana-key.pem" || true
                      terraform output -raw private_key_pem > "$WORKSPACE/ansible/grafana-key.pem"
                      chmod 400 "$WORKSPACE/ansible/grafana-key.pem"
                       """
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh '''
                  PUBLIC_IP=$(terraform -chdir=terraform output -raw public_ip)
                  echo "[grafana]" > ansible/inventory.ini
                  echo "$PUBLIC_IP ansible_user=ubuntu ansible_ssh_private_key_file=$WORKSPACE/ansible/grafana-key.pem" >> ansible/inventory.ini
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
