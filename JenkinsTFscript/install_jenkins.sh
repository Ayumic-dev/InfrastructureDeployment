#!/bin/bash
set -e

# Update system
sudo apt update -y
sudo apt install -y ca-certificates curl gnupg openjdk-17-jre-headless

# -----------------------------
#  Install Jenkins
# -----------------------------
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
    | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" \
    | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update -y
sudo apt install -y jenkins

# Enable & start Jenkins service
sudo systemctl enable jenkins
sudo systemctl start jenkins

# -----------------------------
# Install Terraform
# -----------------------------
curl -fsSL https://apt.releases.hashicorp.com/gpg \
    | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    | sudo tee /etc/apt/sources.list.d/hashicorp.list > /dev/null

sudo apt update -y
sudo apt install terraform -y

# -----------------------------
# Print Jenkins initial password
# -----------------------------
echo "======================================="
echo " Jenkins Installed Successfully "
echo "======================================="
echo "Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "======================================="

exit 0
