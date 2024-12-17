#!/bin/bash

# Variables
PROJECT_ID="lively-hall-445018-g5"
REGION="us-central1"
DB_INSTANCE_NAME="tic-tac-toe-db"
DB_USER="nakama"
DB_PASSWORD="password"
DB_NAME="nakama"

# Authenticate to Google Cloud
gcloud auth login

# Set the Google Cloud project
gcloud config set project $PROJECT_ID

# Create a new Cloud SQL instance
gcloud sql instances create $DB_INSTANCE_NAME \
  --database-version=POSTGRES_13 \
  --tier=db-f1-micro \
  --region=$REGION

# Set the root password for the database
gcloud sql users set-password postgres --instance=$DB_INSTANCE_NAME --password=$DB_PASSWORD

# Create the 'nakama' database
gcloud sql databases create $DB_NAME --instance=$DB_INSTANCE_NAME

# Set up database access
gcloud sql instances patch $DB_INSTANCE_NAME \
  --authorized-networks=0.0.0.0/0  # You can restrict access by setting an IP range instead of 0.0.0.0/0

# Output connection information
echo "Cloud SQL instance setup completed."
echo "You can connect to your PostgreSQL database using the following credentials:"
echo "User: $DB_USER"
echo "Database: $DB_NAME"
echo "Password: $DB_PASSWORD"
