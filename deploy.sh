#!/bin/bash
set -e

# Setup SSH for EC2
echo "Setting up SSH connection to EC2..."
openssl aes-256-cbc -K $encrypted_key -iv $encrypted_iv -in deploy_key.enc -out deploy_key -d
chmod 600 deploy_key
eval "$(ssh-agent -s)"
ssh-add deploy_key

# Deploy to EC2
echo "Deploying to EC2..."
ssh -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST <<EOF
  cd /path/to/your/app
  git pull origin main
  npm ci
  npm run build
  # Copy the dist folder into the right location if needed
  
  # Restart your application
  pm2 restart ci-cd-learning || pm2 start dist/index.js --name ci-cd-learning
EOF