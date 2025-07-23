# Grafana Observability Pipeline 📊 (Learning Project)

This is a **learning project** I built from scratch to better understand how to deploy a modern observability stack to the cloud using automation tools.  
It’s not perfect, not enterprise-grade – but **I built it myself**, and I learned a lot in the process. 🔧

## 🧩 What does it do?

This pipeline:

- Provisions an EC2 instance on AWS using Terraform ☁️  
- Installs Grafana + Prometheus stack using Ansible 🛠️  
- Can be run from Jenkins as part of a CI/CD pipeline 🔁  

## 🧪 Tech used

- **Terraform** – Infrastructure provisioning (AWS EC2)
- **Ansible** – Configuration and Docker setup
- **Jenkins** – Automation pipeline
- **Docker** – Grafana, Prometheus, Node Exporter containers


## 🔧 How it works

1. Terraform spins up an EC2 instance  
2. Ansible installs and configures the monitoring stack  
3. Grafana becomes accessible at `http://<ec2-ip>:3000`  

> Default Grafana login: `admin / admin`

## 🙋‍♂️ Why I built this

Because I wanted to **really understand how all these tools work together** in a real-world scenario.  
I had already learned some basics (Terraform, Ansible, Docker), but this project helped me connect the dots and build something end-to-end.

## ⭐️ If you cloned it…

Thanks for checking it out!  
Even though this is just a learning project, I hope it helps others too.  
Feel free to reach out on [LinkedIn](https://www.linkedin.com/in/zsolt-r-85b4b7124) if you're working on something similar or want to connect!

---

📈 Already 35+ unique clones – I honestly didn’t expect that. Thanks! 🙌  


