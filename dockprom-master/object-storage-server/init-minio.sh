#!/bin/sh
# MinIO initialization script
# Creates buckets as required by Phase 2

# Wait for MinIO to start
sleep 5

# Configure MinIO client
mc alias set myminio http://object-storage-server:9000 minioadmin minioadmin

# Phase 2 - Requirement 5: Create buckets
mc mb myminio/profile-pics --ignore-existing
mc mb myminio/documents --ignore-existing

# Set public read policy on profile-pics
mc anonymous set download myminio/profile-pics

echo "MinIO buckets created successfully!"
