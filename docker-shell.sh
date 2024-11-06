#!/bin/bash
# Change to your USER NAME in line 24 if mounting .gitconfig in WSL to container

set -e

export BASE_DIR=$(pwd)
export SECRETS_DIR=$(pwd)/../secrets/
export GCS_BUCKET_NAME="cheese-app-dvc-hw2"
export GCP_PROJECT="angular-harmony-434717-n1"
export GCP_ZONE="us"
export GOOGLE_APPLICATION_CREDENTIALS="/secrets/data-service-account.json"


echo "Building image"
docker build -t data-version-cli -f Dockerfile .

echo "Running container"
docker run --rm --name data-version-cli -ti \
--privileged \
--cap-add SYS_ADMIN \
--device /dev/fuse \
-v "$BASE_DIR":/app \
-v "$SECRETS_DIR":/secrets \
-v /mnt/c/Users/yuxin/.gitconfig:/etc/gitconfig \
-e GOOGLE_APPLICATION_CREDENTIALS=$GOOGLE_APPLICATION_CREDENTIALS \
-e GCP_PROJECT=$GCP_PROJECT \
-e GCP_ZONE=$GCP_ZONE \
-e GCS_BUCKET_NAME=$GCS_BUCKET_NAME data-version-cli