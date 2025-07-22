#!/bin/bash

set -e

echo "[*] Exporting Terraform SSH key to Ansible folder..."

terraform output -raw private_key_pem > ../ansible/grafana-key.pem
chmod 400 ../ansible/grafana-key.pem

echo "[+] Key exported and permission set to 400."

