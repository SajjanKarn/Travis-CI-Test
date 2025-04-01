#!/bin/bash
set -e

echo "Setting up SSH connection to EC2..."
openssl aes-256-cbc -K $encrypted_key -iv $encrypted_iv -in deploy_key.enc -out deploy_key -d
chmod 600 deploy_key
eval "$(ssh-agent -s)"
ssh-add deploy_key

echo "Deploying to EC2..."
ssh -i demo-test.pem -o StrictHostKeyChecking=no ubuntu@15.206.247.0 <<EOF
  cd /home/ubuntu/Travis-CI-Test
  git pull origin main
  npm install
  npm run build
  pm2 restart all || pm2 start npm --name "my-app" -- start
EOF
